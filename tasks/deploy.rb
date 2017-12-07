#!/opt/puppetlabs/puppet/bin/ruby
require 'json'
require 'open3'

params       = JSON.parse(STDIN.read)

# Munge items into arrays of things to deploy
environments = params['environments'] || params['environment']
environments = environments.split(',') if environments

modules      = params['modules'] || params['module']
modules      = modules.split(',') if modules

messages   = []
exitstatus = 0
if environments
  environments.each do |env|
    output, status = Open3.capture2e('r10k', 'deploy', 'environment', env, '--puppetfile')
    messages << "Deploying environment #{env}: #{output}"
    exitstatus += status.exitstatus
  end
end

if modules
  output, status = Open3.capture2e('r10k', 'deploy', 'module', *modules)
  messages << "Deploying modules #{modules.join(',')}: #{output}"
  exitstatus += status.exitstatus
end

if environments.nil? && modules.nil?
  output, status = Open3.capture2e('r10k', 'deploy', 'environment', '--puppetfile')
  messages << "Deploying all environments: #{output}"
  exitstatus += status.exitstatus
end

puts({ 'messages' => messages }.to_json)
exit exitstatus
