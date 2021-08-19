require 'spec_helper'
describe 'r10k::webhook::package', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      let :pre_condition do
        "service { 'webhook.service': ensure => 'running'}"
      end

      context 'Puppet Enterprise 2019.8.7' do
        let :params do
          {
            is_pe_server: true
          }
        end
        let :facts do
          facts.merge(
            pe_server_version: '2019.8.7'
          )
        end

        provider = case facts[:os]['name']
                   when 'Archlinux'
                     'pacman'
                   else
                     'puppet_gem'
                   end
        it { is_expected.to contain_package('sinatra').with(provider: provider) }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.not_to contain_package('webrick') }
        it { is_expected.not_to contain_package('json') }
      end
      context 'Puppet FOSS 6' do
        let :facts do
          facts.merge(
            is_pe:         false,
            puppetversion: '6.24.0'
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('sinatra').with(ensure: 'installed') }
        it { is_expected.to contain_package('webrick').with(ensure: 'installed') }
        it { is_expected.to contain_package('json').with(ensure: 'installed') }
      end
      context 'Puppet FOSS 7' do
        let :facts do
          facts.merge(
            is_pe:         false,
            puppetversion: '7.10.0'
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('sinatra').with(ensure: 'installed') }
        it { is_expected.to contain_package('webrick').with(ensure: 'installed') }
        it { is_expected.to contain_package('json').with(ensure: 'installed') }
      end
    end
  end
end
