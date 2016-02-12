require 'puppetclassify' if Puppet.features.puppetclassify?
require 'puppet/network/http_pool'
module PuppetX
  module Webhook
    module Util
      # Read classifier.yaml for split installation compatibility
      def self.load_classifier_config
        configfile = File.join Puppet.settings[:confdir], 'classifier.yaml'
        if File.exist?(configfile)
          classifier_yaml = YAML.load_file(configfile)
          @classifier_url = "https://#{classifier_yaml['server']}:#{classifier_yaml['port']}/classifier-api"
        else
          Puppet.debug "Config file #{configfile} not found"
          puts "no config file! - wanted #{configfile}"
          exit 2
        end
      end

      # Create classifier instance var
      # Uses the local hostcertificate for auth ( assume we are
      # running from master in whitelist entry of classifier ).
      def self.load_classifier()
        auth_info = {
          'ca_certificate_path' => Puppet[:localcacert],
          'certificate_path'    => Puppet[:hostcert],
          'private_key_path'    => Puppet[:hostprivkey],
        }
        unless @classifier
          load_classifier_config
          @classifier = PuppetClassify.new(@classifier_url, auth_info)
        end
      end

      def self.http_instance(host,port,whitelist: true)
        if whitelist
          Puppet::Network::HttpPool.http_instance(host,port,true)
        else
          http = Net::HTTP.new(host,port)
          http.use_ssl = ssl
          http.cert = OpenSSL::X509::Certificate.new(File.read(Puppet[:hostcert]))
          http.key = OpenSSL::PKey::RSA.new(File.read(Puppet[:hostprivkey]))
          http.ca_file = Puppet[:localcacert]
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http
        end
      end

      def self.update_master_profile(r10k_private_key: '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa',r10k_remote: '')
        Puppet.notice("Adding code manager params to master profile in classifier")
        load_classifier
        groups = @classifier.groups
        pe_master = groups.get_groups.select { |group| group['name'] == 'PE Master'}
      
        classes = pe_master.first['classes']
      
        master_profile = classes['puppet_enterprise::profile::master']
        master_profile.update(master_profile.merge(
          'r10k_private_key'             => r10k_private_key,
          'r10k_remote'                  => r10k_remote, 
          'file_sync_enabled'            => true,
           'code_manager_auto_configure' => true,
        ))
      
        group_hash = pe_master.first.merge({ "classes" => {"puppet_enterprise::profile::master" => master_profile}})
      
        groups.update_group(group_hash)
      end

      def self.run_puppet(argv)
        command_line = Puppet::Util::CommandLine.new('puppet', argv)
        apply = Puppet::Application::Apply.new(command_line)
        apply.parse_options
        apply.run_command
      end

      def self.service(service,action)
        Puppet.notice "Attempting to ensure=>#{action} #{service}"
        start_service = Puppet::Resource.new('service',service, :parameters => {
          :ensure => action,
        })
        result, report = Puppet::Resource.indirection.save(start_service)
      end
 
      def self.service_restart(service)
        self.service(service,'stopped')
        self.service(service,'running')
      end


     
    end
  end
end
