#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'open3'

params       = JSON.parse($stdin.read)

# Munge items into arrays of things to deploy
environments = params['environments'] || params['environment']
environments = environments.split(',') if environments

modules      = params['modules'] || params['module']
modules      = modules.split(',') if modules

messages   = []
warnings   = []
errors     = []
exitstatus = 0
environments&.each do |env|
  output, status = Open3.capture2e('r10k', 'deploy', 'environment', env, '--puppetfile')
  messages << "Deploying environment #{env}"
  exitstatus += status.exitstatus

  next if output.empty?

  (status.success? ? warnings : errors) << output
end

if modules
  output, status = Open3.capture2e('r10k', 'deploy', 'module', *modules)
  messages << "Deploying modules '#{modules.join(', ')}'"
  exitstatus += status.exitstatus

  unless output.empty?
    (status.success? ? warnings : errors) << output
  end
end

if environments.nil? && modules.nil?
  output, status = Open3.capture2e('r10k', 'deploy', 'environment', '--puppetfile')
  messages << 'Deploying all environments'
  exitstatus += status.exitstatus

  unless output.empty?
    (status.success? ? warnings : errors) << output
  end
end

puts({
  'status' => exitstatus.zero?,
  'messages' => messages,
  'warnings' => warnings,
  'errors' => errors
}.to_json)
exit exitstatus
