# frozen_string_literal: true

require 'spec_helper'

version = '2.0.0'

describe 'r10k::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      # This install method uses the archived puppetlabs/ruby module
      # It doesn't support Gentoo
      context 'with gem provider', if: facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            install_options: '',
            keywords: '',
            manage_ruby_dependency: 'declare',
            package_name: 'r10k',
            provider: 'gem',
            version: version,
            puppet_master: true
          }
        end

        it { is_expected.to contain_class('r10k::install::gem').with(version: version) }

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'gem'
          )
        end
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with gem with empty install_options', if: facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            manage_ruby_dependency: 'include',
            package_name: 'r10k',
            provider: 'gem',
            version: version,
            keywords: '',
            install_options: [],
            puppet_master: true
          }
        end

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'gem',
            install_options: ['--no-document']
          )
        end
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with gem with populated install_options', if: facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            manage_ruby_dependency: 'include',
            package_name: 'r10k',
            provider: 'gem',
            version: version,
            keywords: '',
            install_options: ['BOGON'],
            puppet_master: true
          }
        end

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'gem',
            install_options: ['BOGON']
          )
        end
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with puppet_gem provider' do
        let :params do
          {
            package_name: 'r10k',
            version: version,
            provider: 'puppet_gem',
            keywords: '',
            manage_ruby_dependency: 'declare',
            install_options: ''
          }
        end

        it { is_expected.to contain_class('r10k::install::puppet_gem') }

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'puppet_gem'
          )
        end
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with puppet_gem on Puppet FOSS 4.2.1' do
        let :params do
          {
            manage_ruby_dependency: 'declare',
            install_options: '',
            package_name: 'r10k',
            provider: 'puppet_gem',
            version: version,
            keywords: ''
          }
        end
        let :facts do
          facts.merge(
            puppetversion: '4.2.1'
          )
        end

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'puppet_gem'
          )
        end

        it do
          expect(subject).to contain_file('/usr/bin/r10k').with(
            ensure: 'link',
            target: '/opt/puppetlabs/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with defaults and source specified', if: facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            manage_ruby_dependency: 'include',
            package_name: 'r10k',
            provider: 'gem',
            version: version,
            keywords: '',
            gem_source: 'https://some.alternate.source.com/',
            install_options: [],
            puppet_master: true
          }
        end

        it { is_expected.to contain_class('r10k::install::gem') }

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'gem',
            source: 'https://some.alternate.source.com/'
          )
        end
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with bundle provider' do
        let :params do
          {
            package_name: 'r10k',
            version: version,
            provider: 'bundle',
            manage_ruby_dependency: 'declare',
            keywords: '',
            install_options: '',
            puppet_master: true
          }
        end

        it { is_expected.to contain_class('r10k::install::bundle') }
        it { is_expected.not_to contain_package('r10k') }
        it { is_expected.not_to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end
    end
  end
end
