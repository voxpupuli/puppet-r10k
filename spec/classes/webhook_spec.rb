# frozen_string_literal: true

require 'spec_helper'
describe 'r10k::webhook', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'With FOSS and the mcollective webhook' do
        let :params do
          {
            use_mcollective: true
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('r10k::webhook::package') }
        it { is_expected.not_to contain_file('peadmin-cert.pem').with(path: '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem') }
        it { is_expected.to contain_package('sinatra') }
        it { is_expected.to contain_package('json') }
        it { is_expected.to contain_package('webrick') }
        it { is_expected.to contain_systemd__unit_file('webhook.service') }
      end
    end
  end
end
