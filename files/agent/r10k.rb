module MCollective
  module Agent
    class R10k<RPC::Agent
       ['push',
        'pull',
        'status'].each do |act|
          action act do
            validate :path, :shellsafe
            path = request[:path]
            reply.fail "Path not found #{path}" unless File.exists?(path)
            return unless reply.statuscode == 0
            run_cmd act, path
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
              run_cmd act, environment
              reply[:environment] = environment
            elsif act == 'deploy_module'
              validate :module_name, :shellsafe
              module_name = request[:module_name]
              run_cmd act, module_name
              reply[:module_name] = module_name
            else
              run_cmd act
            end
          end
        end
      private

      def run_cmd(action,arg=nil)
        output = ''
        git  = ['/usr/bin/env', 'git']
        r10k = ['/usr/bin/env', 'r10k']
        # Given most people using this are using Puppet Enterprise, add the PE Path
        environment = {"LC_ALL" => "C","PATH" => "#{ENV['PATH']}:/opt/puppet/bin"}
        case action
          when 'push','pull','status'
            cmd = git
            cmd << 'push'   if action == 'push'
            cmd << 'pull'   if action == 'pull'
            cmd << 'status' if action == 'status'
            reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true, :cwd => arg, :environment => environment  )
          when 'cache','synchronize','sync', 'deploy', 'deploy_module'
            cmd = r10k
            cmd << 'cache' if action == 'cache'
            cmd << 'deploy' << 'environment' << '-p' if action == 'synchronize' or action == 'sync'
            if action == 'deploy'
              cmd << 'deploy' << 'environment' << arg << '-p'
            elsif action == 'deploy_module'
              cmd << 'deploy' << 'module' << arg
            end
            reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true, :environment => environment)
        end
      end
    end
  end
end
