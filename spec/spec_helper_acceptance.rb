require 'json'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(source: proj_root, module_name: 'r10k')
    hosts.each do |host|
      JSON.parse(File.read('metadata.json'))['dependencies'].each do |dependency|
        on host, puppet('module', 'install', dependency['name'].to_s), acceptable_exit_codes: [0, 1]
      end
    end
  end
end
