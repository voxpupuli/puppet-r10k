module MCollective
  module Agent
    class R10k<RPC::Agent
       activate_when do
         #This helper only activate this agent for discovery and execution
         #If r10k is found on $PATH.
         # http://docs.puppetlabs.com/mcollective/simplerpc/agents.html#agent-activation
         r10k_binary = `which r10k 2> /dev/null`
         if r10k_binary == ""
           #r10k not found on path.
           Log.error('r10k binary not found in PATH')
           false
         else
           true
         end
       end
       ['push',
        'pull',
        'status'].each do |act|
          action act do
            validate :path, :shellsafe
            path = request[:path]
            reply.fail "Path not found #{path}" unless File.exist?(path)
            return unless reply.statuscode == 0
            lock do
              run_cmd act, path
            end
            reply[:path] = path
          end
        end
        ['cache',
         'synchronize',
         'deploy',
         'deploy_module',
         'sync'].each do |act|
          action act do
            if act == 'deploy'
              validate :environment, :shellsafe
              environment = request[:environment]
              lock do
                run_cmd act, environment
              end
              reply[:environment] = environment
            elsif act == 'deploy_module'
              validate :module_name, :shellsafe
              module_name = request[:module_name]
              lock do
                run_cmd act, module_name
              end
              reply[:module_name] = module_name
            else
              lock do
                run_cmd act
              end
            end
          end
        end
      private

      def cmd_as_user(cmd, cwd = nil)
        if /^\w+$/.match(request[:user])
          cmd_as_user = ['su', '-', request[:user], '-c', '\'']
          if cwd
            cmd_as_user += ['cd', cwd, '&&']
          end
          cmd_as_user += cmd + ["'"]

          # doesn't seem to execute when passed as an array
          cmd_as_user.join(' ')
        else
          cmd
        end
      end

      def run_cmd(action,arg=nil)
        output = ''
        git  = ['/usr/bin/env', 'git']
        r10k = ['/usr/bin/env', 'r10k']
        # Given most people using this are using Puppet Enterprise, add the PE Path
        environment = {"LC_ALL" => "C","PATH" => "#{ENV['PATH']}:/opt/puppet/bin:/usr/local/bin"}
        environment["http_proxy"] = config.pluginconf.fetch("r10k.http_proxy", "")
        case action
          when 'push','pull','status'
            cmd = git
            cmd << 'push'   if action == 'push'
            cmd << 'pull'   if action == 'pull'
            cmd << 'status' if action == 'status'
            reply[:status] = run(cmd_as_user(cmd, arg), :stderr => :error, :stdout => :output, :chomp => true, :cwd => arg, :environment => environment )
          when 'cache','synchronize','sync', 'deploy', 'deploy_module'
            cmd = r10k
            cmd << 'cache' if action == 'cache'
            cmd << 'deploy' << 'environment' << '-p' if action == 'synchronize' or action == 'sync'
            if action == 'deploy'
              cmd << 'deploy' << 'environment' << arg << '-p'
            elsif action == 'deploy_module'
              cmd << 'deploy' << 'module' << arg
            end
            reply[:status] = run(cmd_as_user(cmd), :stderr => :error, :stdout => :output, :chomp => true, :environment => environment)
        end
      end

      def lock
        File.open('/var/run/r10k.lock', 'w+') do |f|
          if (not f.flock(File::LOCK_EX | File::LOCK_NB))
            reply.fail "Another instance of r10k already running"
            Log.info "Another instance of r10k already running"
          else
            yield
          end
        end
      end
    end
  end
end
