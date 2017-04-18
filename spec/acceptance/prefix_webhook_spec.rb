require 'spec_helper_acceptance'
require 'json'
describe 'Prefix Enabled,System Ruby with No SSL, Not protected, No mcollective' do
  context 'default parameters' do
    let(:pp) do
      "
      file {'/usr/local/bin/prefix_command.rb':
        ensure => file,
        mode   => '0755',
        owner  => 'root',
        group  => '0',
        source => 'puppet:///modules/r10k/prefix_command.rb',
      }
      class { 'r10k':
        sources => {
          'webteam' => {
            'remote'  => 'https://github.com/webteam/somerepo.git',
            'basedir' => '${::settings::confdir}/environments',
            'prefix'  => true,
          },
          'secteam' => {
            'remote'  => 'https://github.com/secteam/someotherrepo.git',
            'basedir' => '${::settings::confdir}/environments',
            'prefix'  => true,
          },
          'noprefix' => {
            'remote'  => 'https://github.com/noprefix/repo.git',
            'basedir' => '${::settings::confdir}/environments'
          },
          'customprefix' => {
            'remote'  => 'https://github.com/customprefix/repo.git',
            'basedir' => '${::settings::confdir}/environments',
            'prefix'  => 'custom'
          }
        },
      }
      class {'r10k::webhook::config':
        enable_ssl      => false,
        protected       => false,
        use_mcollective => false,
        prefix          => true,
        prefix_command  => '/usr/local/bin/prefix_command.rb',
        require         => File['/usr/local/bin/prefix_command.rb'],
        notify          => Service['webhook'],
      }
      class {'r10k::webhook':
        require => Class['r10k::webhook::config'],
      }
      "
    end

    it 'applies with no errors' do
      apply_manifest(pp, catch_failures: true)
    end
    it 'is idempotent' do
      apply_manifest(pp, catch_changes: true)
    end
    describe service('webhook') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    # rubocop:disable RSpec/RepeatedExample
    shell('/usr/bin/curl -d \'{ "ref": "refs/heads/production", "repository": { "name": "puppet-control" , "url": "https://github.com/webteam/somerepo.git"} }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q') do |r|
      it { expect(r.stdout).to match(%r{^.*webteam_production.*$}) }
      it { expect(r.exit_code).to eq(0) }
    end
    shell('/usr/bin/curl -d \'{ "ref": "refs/heads/production", "repository": { "name": "puppet-control" , "url": "https://github.com/secteam/someotherrepo.git"} }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q') do |r|
      it { expect(r.stdout).to match(%r{^.*secteam_production.*$}) }
      it { expect(r.exit_code).to eq(0) }
    end
    shell('/usr/bin/curl -d \'{ "ref": "refs/heads/production", "repository": { "name": "puppet-control" , "url": "https://github.com/customprefix/repo.git"} }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q') do |r|
      it { expect(r.stdout).to match(%r{^.*custom_production.*$}) }
      it { expect(r.exit_code).to eq(0) }
    end
    shell('/usr/bin/curl -d \'{ "ref": "refs/heads/production", "repository": { "name": "puppet-control" , "url": "https://github.com/noprefix/repo.git"} }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q') do |r|
      it { expect(r.stdout).to match(%r{^.* production.*$}) }
      it { expect(r.exit_code).to eq(0) }
    end
    # rubocop:enable RSpec/RepeatedExample
  end
end
