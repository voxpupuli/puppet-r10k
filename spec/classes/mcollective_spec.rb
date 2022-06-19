# frozen_string_literal: true

require 'spec_helper'
describe 'r10k::mcollective', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      # Gentoo has no choria package and upstream doesn't offer a 3rd party repo
      context 'With defaults', if: facts[:os]['name'] != 'Gentoo' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('r10k::params') }

        it do
          expect(subject).to contain_mcollective__module_plugin('mcollective_agent_r10k').with(
            ensure: 'present',
            server: 'true',
            client: 'true',
            server_config: {
              'http_proxy' => '',
            },
            config_name: 'r10k',
            common_files: [
              'agent/r10k.ddl',
              'agent/r10k.json',
            ],
            server_files: [
              'agent/r10k.rb',
            ],
            client_files: [
              'application/r10k.rb'
            ]
          )
        end
      end

      context 'Removing the mcollective agent & application', if: facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            ensure: 'absent'
          }
        end

        it { is_expected.to contain_mcollective__module_plugin('mcollective_agent_r10k').with(ensure: 'absent') }
      end
    end
  end
end
