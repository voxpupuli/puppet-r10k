require 'spec_helper'
describe 'r10k::webhook', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
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

        it { is_expected.to contain_class('r10k::webhook::package') }
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
        pe_version:                '2016.4.2'
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
        pe_version:                '2016.4.2'
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
