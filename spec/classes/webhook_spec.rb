require 'spec_helper'
describe 'r10k::webhook', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'Puppet Enterprise 3.8 with the mcollective webhook' do
        let :params do
          {
            use_mcollective: true
          }
        end
        let :facts do
          facts.merge(
            is_pe:         true,
            pe_version:    '3.8.0',
            puppetversion: '3.8.0'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'pe_gem'
          )
        end
        it do
          is_expected.to contain_file('peadmin-cert.pem').with(
            path:   '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
            ensure: 'file',
            owner:  'peadmin',
            group:  'peadmin',
            mode:   '0644'
          )
        end
      end

      context 'Puppet Enterprise 3.8 with no Webhook' do
        let :params do
          {
            ensure: false
          }
        end
        let :facts do
          facts.merge(
            is_pe:         'true',
            pe_version:    '3.8.0',
            puppetversion: '3.8.0'
          )
        end
        it { is_expected.to contain_file('/var/log/webhook/access.log').with(ensure: 'absent') }
        it { is_expected.to contain_file('/var/log/webhook').with(ensure: 'absent') }
        it { is_expected.to contain_file('/var/run/webhook').with(ensure: 'absent') }
        it { is_expected.to contain_file('webhook_init_script').with(ensure: 'absent') }
      end

      context 'Puppet Enterprise 3.8 with a non-mcollective webhook' do
        let :params do
          {
            use_mcollective: false
          }
        end
        let :facts do
          facts.merge(
            is_pe:         'true',
            pe_version:    '3.8.0',
            puppetversion: '3.8.0'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'pe_gem'
          )
        end
        it { is_expected.not_to contain_file('peadmin-cert.pem').with(path: '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem') }
      end

      context 'Puppet FOSS 4.x with the mcollective webhook' do
        let :params do
          {
            use_mcollective: true
          }
        end
        let :facts do
          facts.merge(
            puppetversion: '4.8.0'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'puppet_gem'
          )
        end
        it { is_expected.not_to contain_file('peadmin-cert.pem').with(path: '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem') }
      end

      context 'Puppet FOSS 3.7.1 with a webhook' do
        let :facts do
          facts.merge(
            puppetversion: '3.7.1'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'gem'
          )
        end
        it do
          is_expected.to contain_package('webrick').with(
            ensure:   'installed',
            provider: 'gem'
          )
        end
        it do
          is_expected.to contain_package('rack').with(
            ensure:   'installed',
            provider: 'gem'
          )
        end
        it do
          is_expected.to contain_package('json').with(
            ensure:   'installed',
            provider: 'gem'
          )
        end
        it { is_expected.not_to contain_file('peadmin-cert.pem').with(path: '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem') }
      end
    end
  end

  # Tests outside of the supported OS loop
  context 'Enterprise Linux 7 host with systemd' do
    let :facts do
      {
        osfamily:                  'RedHat',
        operatingsystemmajrelease: '7',
        operatingsystem:           'Centos',
        is_pe:                     'true',
        pe_version:                '3.7.0'
      }
    end

    it do
      is_expected.to contain_file('webhook_init_script').with(
        path:   '/usr/lib/systemd/system/webhook.service',
        content: %r{\[Unit\]}
      )
    end
  end

  context 'Non Enteprise Linux 7 host' do
    let :facts do
      {
        osfamily:                  'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem:           'Centos',
        is_pe:                     'true',
        pe_version:                '3.7.0'
      }
    end

    it do
      is_expected.to contain_file('webhook_init_script').with(
        path:   '/etc/init.d/webhook',
        content: %r{#!\/bin\/bash}
      )
    end
  end
end
