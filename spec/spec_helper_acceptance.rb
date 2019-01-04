require 'beaker-rspec'
require 'beaker-puppet'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'
install_module
install_module_dependencies

RSpec.configure do |c|
  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |_host|
      ensure_puppet_user_exists = %(
        user { 'puppet':
          ensure => present,
        }
      )
      apply_manifest(ensure_puppet_user_exists, catch_failures: true)
    end
  end
end
