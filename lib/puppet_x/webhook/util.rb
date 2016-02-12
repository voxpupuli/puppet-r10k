require 'puppetclassify' if Puppet.features.puppetclassify?
require 'puppet/network/http_pool'
require 'puppet/application/apply'
require 'puppet/settings/ini_file'

module PuppetX
  module Webhook
    module Util

      # Read puppet.conf as Puppet[:node_terminus] will read from [main]
      def self.read_node_terminus()
        path = Puppet::FileSystem.pathname(Puppet.settings.which_configuration_file)
        Puppet::Settings::IniFile.parse(path).setting('master','node_terminus').value
      end

      # Read the local classes file
      def self.read_classfile()
        if File.exist? Puppet[:classfile]
           classes = IO.readlines Puppet[:classfile]
         else
           raise "Unable to find the local classfile #{Puppet[:classfile]}"
         end
         classes.map!{|x| x.chomp }
      end

      # return current r10k config
      def self.load_r10k_yaml(yaml_path)
        # Load the existing r10k yaml file, if it exists
        if File.exist?(yaml_path)
          r10k_yaml = YAML.load_file(yaml_path)
        else
          raise "Unable to file r10k.yaml at path #{yaml_path}, use --r10k_yaml for custom location"
        end
        # Make sure they read the docs and are using the rugged provider already
        unless r10k_yaml.has_key?('git') && r10k_yaml['git']['provider'] == 'rugged'
          Puppet.err "Specified #{yaml_path} is not using rugged provider, you must migrate to rugged before using code manager"
          raise "Missing key ['git']['provider']['rugged'] in r10k.yaml see: https://github.com/puppetlabs/r10k/blob/master/doc/git/providers.mkd"
        end

        # If your control repo is public , you don't need a key,and apparently
        # don't care security in your environment...
        if ! r10k_yaml['git']['private_key']
          Puppet.warning "No private_key configured for rugged, assuming you have a public control repo"
          r10k_yaml['git']['private_key'] = ''
        end
        r10k_yaml
      rescue Exception => e
        raise "Unable to load r10k.yaml file: #{e.message}"
      end

      def self.migrate_ssh_key(old_key_path)
        # Check if key is owned by root and produce a warning
        if File.stat(old_key_path).owned?
          Puppet.warning "Current ssh key #{old_key_path} is owned by root"
        end

        # We don't know what type of key the user has so we check
        # https://stelfox.net/blog/2014/04/calculating-rsa-key-fingerprints-in-ruby/
        begin
          key = OpenSSL::PKey::RSA.new File.read(old_key_path)
          key_type = :rsa
          if key.private?
            data_string = [7].pack('N') + 'ssh-rsa' + key.public_key.e.to_s(0) + key.public_key.n.to_s(0)
            finger_print = OpenSSL::Digest::MD5.hexdigest(data_string).scan(/../).join(':')
          else
            raise "File #{old_key_path} does not contain a #{key_type.to_s} private key"
          end
        rescue OpenSSL::PKey::RSAError
          key = OpenSSL::PKey::DSA.new File.read(old_key_path)
          key_type = :dsa
          finger_print = ''
        end

        Puppet.info "Validated Private key of type #{key_type.to_s} #{finger_print}"
        # Update the paths to the new code manager private_key file path
        # https://docs.puppetlabs.com/pe/latest/code_mgr_config.html
        Puppet.info "Copying #{old_key_path} to /etc/puppetlabs/puppetserver/ssh/id-control_repo.#{key_type.to_s}"
        FileUtils.mkdir '/etc/puppetlabs/puppetserver/ssh' if ! File.directory?('/etc/puppetlabs/puppetserver/ssh')
        FileUtils.cp old_key_path, "/etc/puppetlabs/puppetserver/ssh/id-control_repo.#{key_type.to_s}" unless old_key_path == "/etc/puppetlabs/puppetserver/ssh/id-control_repo.#{key_type.to_s}"

        # Fix the ownership so that code manager can read it via puppetserver
        # user ( which should be the same as the current puppet.conf user )
        Puppet.info "Updating ownership to #{Puppet[:user]}:#{Puppet[:group]} /etc/puppetlabs/puppetserver/ssh/id-control_repo.#{key_type.to_s}"
        FileUtils.chown Puppet[:user], Puppet[:group], '/etc/puppetlabs/puppetserver/ssh'
        FileUtils.chown Puppet[:user], Puppet[:group], "/etc/puppetlabs/puppetserver/ssh/id-control_repo.#{key_type.to_s}"


      rescue Exception => e
        raise "Unable to migrate ssh key: #{e.message}"
      end

      # Read classifier.yaml for split installation compatibility
      def self.load_classifier_config
        configfile = File.join Puppet.settings[:confdir], 'classifier.yaml'
        if File.exist?(configfile)
          classifier_yaml = YAML.load_file(configfile)
          @classifier_url = "https://#{classifier_yaml['server']}:#{classifier_yaml['port']}/classifier-api"
        else
          Puppet.debug "Config file #{configfile} not found"
          raise "no classifier config file! - wanted #{configfile}"
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
        Puppet.info("Adding code manager params to master profile in classifier")
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

      def self.puppet_apply(argv)
        command_line = Puppet::Util::CommandLine.new('puppet', argv)
        apply = Puppet::Application::Apply.new(command_line)
        apply.parse_options
        apply.run_command
      end

      def self.run_puppet()
        command_line = Puppet::Util::CommandLine.new('puppet',['agent','-t'])
        apply = Puppet::Application::Agent.new(command_line)
        apply.parse_options
        apply.run_command
      end

      def self.service(service,action)
        Puppet.info "Attempting to ensure=>#{action} #{service}"
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
