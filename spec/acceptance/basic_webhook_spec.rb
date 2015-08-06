require 'spec_helper_acceptance'
require 'json'
describe 'System Ruby with No SSL, Not protected, No mcollective' do

  context 'default parameters' do
    let(:pp) {"
      class { 'r10k':
        remote => 'git@github.com:someuser/puppet.git',
      }
      class {'r10k::webhook::config':
        enable_ssl      => false,
        protected       => false,
        use_mcollective => false,
        notify     => Service['webhook'],
      }
      
      class {'r10k::webhook':
        require => Class['r10k::webhook::config'],
      }
    "}
    it 'should apply with no errors' do
      apply_manifest(pp, :catch_failures=>true)
    end
    it 'should be idempotent' do
      apply_manifest(pp, :catch_changes=>true)
    end
    describe service('webhook') do
      it { should be_enabled }
      it { should be_running }
    end
    it 'should support style Github payloads via module end point' do
      shell('/usr/bin/curl -d \'{ "repository": { "name": "puppetlabs-stdlib" } }\' -H "Accept: application/json" "http://localhost:8088/module" -k -q') do |r|
        expect(r.stdout).to match(/^.*success.*$/)
        expect(r.exit_code).to eq(0)
      end
    end
    it 'should support style Bitbucket payloads via module end point' do
      shell('/usr/bin/curl -X POST -d \'{ "repository": { "full_name": "puppetlabs/puppetlabs-stdlib", "name": "PuppetLabs : StdLib" } }\' "http://localhost:8088/module" -k -q') do |r|
        expect(r.stdout).to match(/^.*success.*$/)
        expect(r.exit_code).to eq(0)
      end
    end
    it 'should support style Github payloads via payload end point' do
      shell('/usr/bin/curl -d \'{ "ref": "refs/heads/production" }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q') do |r|
        expect(r.stdout).to match(/^.*success.*$/)
        expect(r.exit_code).to eq(0)
      end
    end
    it 'should support style Gitorious payloads via payload end point' do
      shell('/usr/bin/curl -X POST -d \'%7b%22ref%22%3a%22master%22%7d\' "http://localhost:8088/payload" -q') do |r|
        expect(r.stdout).to match(/^.*success.*$/)
        expect(r.exit_code).to eq(0)
      end
    end
    it 'should support style BitBucket payloads via payload end point' do
      shell('/usr/bin/curl -X POST -d \'{ "push": { "changes": [ { "new": { "name": "production" } } ] } }\' "http://localhost:8088/payload" -q') do |r|
        expect(r.stdout).to match(/^.*success.*$/)
        expect(r.exit_code).to eq(0)
      end
    end
  end
end
