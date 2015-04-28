source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake',                    :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'rspec-core', '2.99.2',    :require => false
  gem 'rspec-puppet', '~> 1.0',  :require => false
  gem 'puppet-lint',             :require => false
  gem 'puppet-syntax',           :require => false
end

#group :system_tests do
#  gem 'beaker-rspec',  :require => false
#  gem 'serverspec',    :require => false
#end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '3.7.0', :require => false
end

# vim:ft=ruby
