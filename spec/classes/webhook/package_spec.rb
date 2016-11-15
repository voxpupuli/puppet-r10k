require 'spec_helper'
describe 'r10k::webhook::package', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'Puppet Enterprise 2015.x' do
        let :params do
          {
            is_pe_server: true
          }
        end
        let :facts do
          facts.merge(
            is_pe:         'true',
            puppetversion: '4.2.0'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'puppet_gem'
          )
        end
        it { is_expected.to contain_package('rack').with(ensure: 'installed') }
        it { is_expected.not_to contain_package('webrick') }
        it { is_expected.not_to contain_package('json') }
      end

      context 'Puppet Enterprise 3.6' do
        let :facts do
          facts.merge(
            is_pe:         true,
            puppetversion: '3.6.0'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'pe_gem'
          )
        end
        it { is_expected.not_to contain_package('rack') }
        it { is_expected.not_to contain_package('webrick') }
        it { is_expected.not_to contain_package('json') }
      end

      context 'Puppet FOSS 3.x' do
        let :facts do
          facts.merge(
            is_pe:          false,
            puppetversion: '3.8.0'
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
          is_expected.to contain_package('json').with(
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
      end

      context 'Puppet FOSS 4.x' do
        let :facts do
          facts.merge(
            is_pe:         false,
            puppetversion: '4.8.0'
          )
        end

        it do
          is_expected.to contain_package('sinatra').with(
            ensure:   'installed',
            provider: 'puppet_gem'
          )
        end
        it do
          is_expected.to contain_package('webrick').with(
            ensure:   'installed',
            provider: 'puppet_gem'
          )
        end
        it do
          is_expected.to contain_package('json').with(
            ensure:   'installed',
            provider: 'puppet_gem'
          )
        end
        it do
          is_expected.to contain_package('rack').with(
            ensure:   'installed',
            provider: 'puppet_gem'
          )
        end
      end
    end
  end
end
