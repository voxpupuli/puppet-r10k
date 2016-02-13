require 'uri'
require 'json'
require 'puppet/face'
require 'puppet_x/webhook/util'
require 'puppet/util/package'
require 'facter'

Puppet::Face.define(:webhook, '1.0.0') do
  action :migrate do
    summary "Remove zack/r10k webhook from machine, setup code manager"
    arguments "<none>"


    # R10k 
    option "--r10k_yaml=" do
      summary "Opensource r10k.yaml Path - defaults to </etc/r10k.yaml>"
      default_to { '/etc/r10k.yaml'}
    end

    # RBAC Services
    option "--rbac_server=" do
      summary "Console Server - defaults to <certname>"
      default_to { Puppet[:certname] }
    end

    option "--rbac_port=" do
      summary "RBAC Server port - defaults to <4433>"
      default_to { 4433 }
    end

    option "--rbac_api_version=" do
      summary "RBAC API version string - <rbac-api/v1>"
      default_to { 'rbac-api/v1' }
    end

    # Code Manager
    option "--cm_server=" do
      summary "Code Manager Server - defaults to <ca_server>"
      default_to { Puppet[:ca_server] }
    end

    option "--cm_port=" do
      summary "Code Manager port - defaults to <8170>"
      default_to { 8170 }
    end

    option "--cm_api_version=" do
      summary "Code Manager API version string - <code-manager/v1>"
      default_to { 'code-manager/v1' }
    end

    option "--deploy_user=" do
      summary "Deploy user password - defaults to <deploy>"
      default_to { 'deploy' }
    end

    option "--deploy_password=" do
      summary "Deploy user password - defaults to <puppetlabs>"
      default_to { 'puppetlabs' }
    end

    description <<-'EOT'
      This is a migration tool to be used one time to remove the zack/r10k webhook
      and setup and configure the Puppet Enterprise Code manager interface in one
      operation. 
    EOT
    notes <<-'NOTES'
      Directly connects to the services such as rbac,classifier ,CM using your local certificate
    NOTES
    examples <<-'EOT'
      Remove webhook from system and setup code manager:

      $ puppet webhook migrate 

    EOT

    when_invoked do |options|
      payloads = [
        {
          :description  => 'Creating a new role able to deploy code',
          :api_version  => options[:rbac_api_version],
          :api_host     => options[:rbac_server],
          :api_port     => options[:rbac_port],
          :api_endpoint     => 'roles',
          :payload      => {
            "permissions" =>  [
              {
                "object_type" => "environment",
                "action"      => "deploy_code",
                "instance"    => "*"},
              {
                "object_type" => "tokens",
                "action"      => "override_lifetime",
                "instance"    => "*"
              }
             ],
            "user_ids"     => [],
            "group_ids"    => [],
            "display_name" => "Deploy Environments",
            "description"  => "Ability to deploy environment with code manager"
          },
        },
        {
          :description  => 'Creating a user able to deploy code',
          :api_version  => options[:rbac_api_version],
          :api_host     => options[:rbac_server],
          :api_port     => options[:rbac_port],
          :api_endpoint         => 'users',
          :payload          => {
            "login"         => options[:deploy_user],
            "password"      => options[:deploy_password],
             "email"        => "",
             "display_name" => "",
             "role_ids"     => [4]
          }
        },
        {
          :description  => 'Generating token with zero expiry',
          :api_version  => options[:rbac_api_version],
          :api_host     => options[:rbac_server],
          :api_port     => options[:rbac_port],
          :api_endpoint => 'token',
          :payload  => {
            "login"    => options[:deploy_user],
            "password" => options[:deploy_password],
            "lifetime" => "0"
          },
          :returns_token => true
        },
        {
          :description  => "Triggering code manager deployment for environment #{Puppet[:environment]}",
          :api_version  => options[:cm_api_version],
          :api_host     => options[:cm_server],
          :api_port     => options[:cm_port],
          :api_endpoint => 'deploys',
          :payload  => {
            "environments" => Puppet[:environment],
            "wait"         => true
          },
        },
      ]

      # Sanity Checks
      raise 'This face must be ran as root user (uid 0)' unless Process.uid == 0

      raise "This face only works with 2015.3.x not #{Facter.value(:pe_server_version)}" unless Puppet::Util::Package.versioncmp(Facter.value(:pe_server_version), '2015.3.0') >= 0

      @classfile = PuppetX::Webhook::Util.read_classfile()

      raise 'This face must be run from master of masters,  missing class: puppet_enterprise::profile::certificate_authority' unless @classfile.include?('puppet_enterprise::profile::certificate_authority')

      raise "This face requires use of the PE node classifier not node_terminus=#{Puppet[:node_terminus]}" unless PuppetX::Webhook::Util.read_node_terminus == 'classifier'

      raise "This face requires the puppetclassify gem to be installed" unless Puppet.features.puppetclassify?

      # Load FOSS r10k.yaml for data in the classifier
      r10k_yaml = PuppetX::Webhook::Util.load_r10k_yaml(options[:r10k_yaml])

      Dir.mkdir('/etc/puppetlabs/puppetserver/.puppetlabs') unless File.directory?('/etc/puppetlabs/puppetserver/.puppetlabs')

      # Migrate existing ssh key to code manger user and path
      code_manager_ssh_key = PuppetX::Webhook::Util.migrate_ssh_key(r10k_yaml['git']['private_key'])

      # Update classification to reflect change to path above
      PuppetX::Webhook::Util.update_master_profile(
        r10k_private_key: code_manager_ssh_key,
        r10k_remote: r10k_yaml['sources']['puppet']['remote'],
      )
      
      # Run puppet agent to apply new classification
      Puppet.info "Triggering a puppet run..."
      PuppetX::Webhook::Util.run_puppet()

      # Stop PuppetServer
      PuppetX::Webhook::Util.service('pe-puppetserver','stopped')

      # Stop webhook (to prevent r10k from re-populating codedir)
      PuppetX::Webhook::Util.service('webhook','stopped')

      # Perform code migration
      @current_code_dir = Puppet[:codedir]
      FileUtils.mv Dir.glob("#{@current_code_dir}/*"),'/etc/puppetlabs/code-staging'
      FileUtils.rm_rf '/etc/puppetlabs/code-staging/.gitmodules' if File.exists?('/etc/puppetlabs/code-staging/.gitmodules')
      Puppet.info "Updating ownership on /etc/puppetlabs/code-staging to #{Puppet[:user]}:#{Puppet[:group]}"
      FileUtils.chown_R Puppet[:user], Puppet[:group], '/etc/puppetlabs/code-staging'

      # Change code dir to staging so puppet runs work
      Puppet.info("Rewriting codedir to be staging directory during migration")
      Puppet::Face[:config, '0.0.1'].set(['codedir','/etc/puppetlabs/code-staging'],{:section => 'main'})

      # Start PuppetServer (as code manager runs under it)
      PuppetX::Webhook::Util.service('pe-puppetserver','running')

      # Perform the various payload operations
      payloads.each do |curl|
        headers = {'Accept' => 'application/json'}

        # Include our token once we have it in the loop
        headers.merge!({'X-Authentication' => @token}) if @token

        connection = PuppetX::Webhook::Util.http_instance(curl[:api_host], curl[:api_port])

        # Log our current status description
        Puppet.info(curl[:description])

        unless body = connection.post(
          "#{curl[:api_version]}/#{curl[:api_endpoint]}",
          curl[:payload].to_json,
          headers).body
        )
        begin
          response = JSON.load(body)
        rescue
          response = body
        end
        #raise "Error parsing (j/p)son output of response from: https://#{curl[:api_host]}:#{curl[:api_port]}/#{curl[:api_version]}/#{curl[:api_endpoint]}"
        end
        @token = response['token'] if curl[:returns_token]
      end
      Puppet.info "Resetting codedir back to #{@current_code_dir}"
      Puppet::Face[:config, '0.0.1'].set(['codedir',@current_code_dir],{:section => 'main'})

      PuppetX::Webhook::Util.service_restart('pe-puppetserver')
    end

    when_rendering :console do |output,options|
      if output.empty?
        Puppet.info("No output recorded")
      end
      Puppet.info("Make sure to update your Github/Gitlab/Stash server with the new post url for code manager")
    end
  end
end

