# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'System Ruby with No SSL, Not protected, No mcollective' do
  context 'with basics parameters' do
    hosts_as('agent').each do |agent|
      it 'applies with no errors and idempotently' do
        pp = %(
          class { 'r10k':
            remote => 'git@github.com:someuser/puppet.git',
          }
          class {'r10k::webhook::config':
            enable_ssl      => false,
            protected       => false,
            use_mcollective => false,
            notify     => Service['webhook.service'],
          }

          class {'r10k::webhook':
            require => Class['r10k::webhook::config'],
          }
        )

        apply_manifest_on(agent, pp, catch_failures: true)
        apply_manifest_on(agent, pp, catch_changes: true)
      end

      describe service('webhook') do
        it { is_expected.to be_enabled }
        it { is_expected.to be_running }
      end

      # rubocop:disable RSpec/RepeatedExampleGroupBody
      describe command('/usr/bin/curl -d \'{ "repository": { "name": "puppetlabs-stdlib" } }\' -H "Accept: application/json" "http://localhost:8088/module" -k -q') do
        its(:stdout) { is_expected.not_to match %r{.*You shall not pass.*} }
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe command('/usr/bin/curl -X POST -d \'{ "repository": { "full_name": "puppetlabs/puppetlabs-stdlib", "name": "PuppetLabs : StdLib" } }\' "http://localhost:8088/module" -k -q') do
        its(:stdout) { is_expected.not_to match %r{.*You shall not pass.*} }
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe command('/usr/bin/curl -d \'{ "ref": "refs/heads/production" }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q') do
        its(:stdout) { is_expected.not_to match %r{.*You shall not pass.*} }
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe command('/usr/bin/curl -X POST -d \'%7b%22ref%22%3a%22maste%r22%7d\' "http://localhost:8088/payload" -q') do
        its(:stdout) { is_expected.not_to match %r{.*You shall not pass.*} }
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe command('/usr/bin/curl -X POST -d \'{ "push": { "changes": [ { "new": { "name": "production" } } ] } }\' "http://localhost:8088/payload" -q') do
        its(:stdout) { is_expected.not_to match %r{.*You shall not pass.*} }
        its(:exit_status) { is_expected.to eq 0 }
      end
      # Following test is let here commented to rememeber it.
      #   * it does not work as is.
      #   * it is interesting to add this tests when possible.
      #
      #      it 'successfully locks when hammered with multiple requests' do
      #        4.times do
      #          Thread.new do
      #            result = on(agent, '/usr/bin/curl -d \'{ "ref": "refs/heads/production" }\' -H "Accept: application/json" "http://localhost:8088/payload" -k -q')
      #            result.exit_code.should == 0
      #          end
      #        end
      #      end
    end
    # rubocop:enable RSpec/RepeatedExampleGroupBody
  end
end
