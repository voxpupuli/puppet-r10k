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
        'sync'].each do |act|
          action act do
            run_cmd act
          end
          action 'deploy' do
            validate :environment, :shellsafe
            environment = request[:environment]
            run_cmd 'deploy', environment
            reply[:environment] = environment
          end
        end
      private

      def run_cmd(action,arg=nil)
        output = ''
        git  = ['/usr/bin/env', 'git']
        r10k = ['/usr/bin/env', 'r10k']
        case action
          when 'push','pull','status'
            cmd = git
            cmd << 'push'   if action == 'push'
            cmd << 'pull'   if action == 'pull'
            cmd << 'status' if action == 'status'
            reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true, :cwd => arg )
          when 'cache','synchronize','sync', 'deploy'
            cmd = r10k
            cmd << 'cache' if action == 'cache'
            cmd << 'deploy' << 'environment' << '-p' if action == 'synchronize' or action == 'sync'
            if action == 'deploy'
              cmd << 'deploy' << 'environment' << arg << '-p'
            end
            reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true)
        end
      end
    end
  end
end
