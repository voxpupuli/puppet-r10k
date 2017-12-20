require 'spec_helper'
describe 'r10k::webhook::package', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      let :pre_condition do
        "service { 'webhook': ensure => present,}"
      end

      context 'Puppet Enterprise 2016.4.2' do
        let :params do
          {
            is_pe_server: true
          }
        end
        let :facts do
          facts.merge(
            pe_server_version: '2016.4.2'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   '~> 1.0',
            provider: 'puppet_gem'
          )
        end
        it { is_expected.not_to contain_package('webrick') }
        it { is_expected.not_to contain_package('json') }
      end

      context 'Puppet FOSS 4.x' do
        let :facts do
          facts.merge(
            is_pe:         false,
            puppetversion: '4.8.0'
          )
        end

        it { is_expected.to contain_package('sinatra').with(ensure: '~> 1.0') }
        it { is_expected.to contain_package('webrick').with(ensure: '1.3.1') }
        it { is_expected.to contain_package('json').with(ensure: 'installed') }
      end
    end
  end
end
