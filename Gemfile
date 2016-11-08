source ENV['GEM_SOURCE'] || 'https://rubygems.org'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '~> 3.0', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

gem 'puppetlabs_spec_helper', '>= 1.2.0'
gem 'rspec-puppet'
gem 'puppet-lint', '~> 2.0'

gem 'rspec', '~> 2.0', :require => false              if RUBY_VERSION < '1.9'
gem 'rspec', :require => false                        if RUBY_VERSION >= '1.9'
gem 'rake', '~> 10.0', :require => false              if RUBY_VERSION < '1.9'
gem 'rake', :require => false                         if RUBY_VERSION >= '1.9'
gem 'json', '<= 1.8', :require => false               if RUBY_VERSION < '2.0.0'
gem 'json_pure', '<= 2.0.1', :require => false        if RUBY_VERSION < '2.0.0'
gem 'metadata-json-lint', '0.0.11', :require => false if RUBY_VERSION < '1.9'
gem 'metadata-json-lint', :require => false           if RUBY_VERSION >= '1.9'

group :acceptance do
  gem 'beaker', '> 2.0.0', :require => false
  gem 'beaker-rspec', '>= 5.1.0', :require => false
  gem 'serverspec',    :require => false
  gem 'vagrant-wrapper', :require => false
end

# vim:ft=ruby
