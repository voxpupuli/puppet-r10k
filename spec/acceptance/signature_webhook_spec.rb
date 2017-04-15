require 'spec_helper_acceptance'
require 'json'
require 'openssl'
describe 'GitHub Secret Enabled, System Ruby with No SSL, Not protected, No mcollective' do
  context 'default parameters' do
    let(:pp) do
      "
      class { 'r10k':
        remote => 'git@github.com:someuser/puppet.git',
      }
      class {'r10k::webhook::config':
        enable_ssl      => false,
        protected       => false,
        use_mcollective => false,
        github_secret   => 'secret',
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
    context 'supports style Github payloads via module end point with signature in header' do
      HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(HMAC_DIGEST, 'secret', '{ "repository": { "name": "puppetlabs-stdlib" } }')

      shell("/usr/bin/curl -d '{ \"repository\": { \"name\": \"puppetlabs-stdlib\" } }' -H \"Accept: application/json\" \"http://localhost:8088/module\" -H \"X-Hub-Signature: #{signature}\" -k -q") do |r|
        it { expect(r.stdout).to match(%r{^.*success.*$}) }
        it { expect(r.exit_code).to eq(0) }
      end
    end
    context 'supports style Github payloads via payload end point with signature in header' do
      HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(HMAC_DIGEST, 'secret', '{ "ref": "refs/heads/production" }')

      shell("/usr/bin/curl -d '{ \"ref\": \"refs/heads/production\" }' -H \"Accept: application/json\" -H \"X-Hub-Signature: #{signature}\" \"http://localhost:8088/payload\" -k -q") do |r|
        it { expect(r.stdout).to match(%r{^.*success.*$}) }
        it { expect(r.exit_code).to eq(0) }
      end
    end
    it '/heartbeat is successful' do
      shell('/usr/bin/curl -H \"Accept: application/json\" \"http://localhost:8088/heartbeat\" -k -q') do |r|
        expect(r.stdout).to match(%r{^.*success.*$})
      end
    end
  end
end
