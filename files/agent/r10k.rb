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
            reply.fail "Path not found #{path}" unless File.exists?(path)
            return unless reply.statuscode == 0
            run_cmd act, path
            reply[:path] = path
          end
        end
        ['cache',
         'synchronize',
         'deploy',
         'sync'].each do |act|
          action act do
            if act == 'deploy'
              validate :environment, :shellsafe
              environment = request[:environment]
              run_cmd act, environment
              reply[:environment] = environment
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
