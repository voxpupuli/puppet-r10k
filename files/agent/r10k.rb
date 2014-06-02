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
          reply[:path]   = path
        end
      end
        ['cache',
        'environment',
        'module',
        'synchronize',
        'deploy_all',
        'sync'].each do |act|
        action act do
          run_cmd act
        end
      end

      action 'deploy_only', :description => "Deploy a specific environment, and its Puppetfile specified modules" do
        validate :r10k_env, :shellsafe
        r10k_env = request[:r10k_env]
        deploy_only_cmd r10k_env
        reply[:r10k_env] = r10k_env
      end

      private

      def run_cmd(action,path=nil)
        output = ''
        git  = ['/usr/bin/env', 'git']
        r10k = ['/usr/bin/env', 'r10k']
        case action
        when 'push','pull','status'
          cmd = git
          cmd << 'push'   if action == 'push'
          cmd << 'pull'   if action == 'pull'
          cmd << 'status' if action == 'status'
          reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true, :cwd => path )
        when 'cache','environment','module','synchronize','sync', 'deploy_all'
          cmd = r10k
          cmd << 'cache'       if action == 'cache'
          cmd << 'synchronize' if action == 'synchronize' or action == 'sync'
          cmd << 'environment' if action == 'environment'
          cmd << 'module'      if action == 'module'
          cmd << 'deploy' << 'environment' << '-p' if action == 'deploy_all'
          reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true)
        end
      end


      def deploy_only_cmd(r10k_env=nil)
        output = ''
        r10k = ['/usr/bin/env', 'r10k']
        cmd = r10k
        cmd << 'deploy' << 'environment' << r10k_env << '-p'
        reply[:status] = run(cmd, :stderr => :error, :stdout => :output, :chomp => true)
      end

    end
  end
end
