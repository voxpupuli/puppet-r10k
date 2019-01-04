require 'spec_helper'
describe 'r10k::webhook', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'With FOSS and the mcollective webhook' do
        let :params do
          {
            use_mcollective: true
          }
        end

        it { is_expected.to contain_class('r10k::webhook::package') }
        it { is_expected.not_to contain_file('peadmin-cert.pem').with(path: '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem') }
      end

      context 'On PE', if: facts[:osfamily] == 'RedHat' do
        let :facts do
          super().merge(
            is_pe: 'true',
            pe_version: '2016.4.2'
          )
        end

        if facts[:operatingsystemmajrelease].to_i >= 7
          it do
            is_expected.to contain_file('webhook_init_script').with(
              path:   '/usr/lib/systemd/system/webhook.service',
              content: %r{\[Unit\]}
            )
          end
        else
          it do
            is_expected.to contain_file('webhook_init_script').with(
              path:   '/etc/init.d/webhook',
              content: %r{#!\/bin\/bash}
            )
          end
        end
      end
    end
  end
end
