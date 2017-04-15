require 'spec_helper'

version = '2.0.0'

describe 'r10k::install', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with gem provider' do
        let :params do
          {
            install_options:        '',
            keywords:               '',
            manage_ruby_dependency: 'declare',
            package_name:           'r10k',
            provider:               'gem',
            version:                version,
            puppet_master:          true
          }
        end

        it { is_expected.to contain_class('git') }

        # New versions of this gem do not require these packages
        it { is_expected.not_to contain_class('make') }
        it { is_expected.not_to contain_package('gcc') }

        it { is_expected.to contain_class('r10k::install::gem').with(version: version) }
        it do
          is_expected.to contain_package('r10k').with(
            ensure:   version,
            provider: 'gem'
          )
        end
      end

      context 'with gem with empty install_options' do
        let :params do
          {
            manage_ruby_dependency: 'include',
            package_name:           'r10k',
            provider:               'gem',
            version:                version,
            keywords:               '',
            install_options:        [],
            puppet_master:          true
          }
        end

        it do
          is_expected.to contain_package('r10k').with(
            ensure:          version,
            provider:        'gem',
            install_options: ['--no-ri', '--no-rdoc']
          )
        end
      end

      context 'with gem with populated install_options' do
        let :params do
          {
            manage_ruby_dependency: 'include',
            package_name:           'r10k',
            provider:               'gem',
            version:                version,
            keywords:               '',
            install_options:        ['BOGON'],
            puppet_master:          true
          }
        end

        it do
          is_expected.to contain_package('r10k').with(
            ensure:          version,
            provider:        'gem',
            install_options: ['BOGON']
          )
        end
      end

      context 'with puppet_gem provider' do
        let :params do
          {
            package_name:           'r10k',
            version:                version,
            provider:               'puppet_gem',
            keywords:               '',
            manage_ruby_dependency: 'declare',
            install_options:        ''
          }
        end

        it { is_expected.to contain_class('git') }
        it { is_expected.to contain_class('r10k::install::puppet_gem') }
        it do
          is_expected.to contain_package('r10k').with(
            ensure:   version,
            provider: 'puppet_gem'
          )
        end
      end

      context 'with puppet_gem on Puppet FOSS 4.2.1' do
        let :params do
          {
            manage_ruby_dependency: 'declare',
            install_options:        '',
            package_name:           'r10k',
            provider:               'puppet_gem',
            version:                version,
            keywords:               ''
          }
        end
        let :facts do
          facts.merge(
            puppetversion: '4.2.1'
          )
        end

        it do
          is_expected.to contain_package('r10k').with(
            ensure:   version,
            provider: 'puppet_gem'
          )
        end

        it do
          is_expected.to contain_file('/usr/bin/r10k').with(
            ensure:  'link',
            target:  '/opt/puppetlabs/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
      end

      context 'with bundle provider' do
        let :params do
          {
            package_name:           'r10k',
            version:                version,
            provider:               'bundle',
            manage_ruby_dependency: 'declare',
            keywords:               '',
            install_options:        '',
            puppet_master:          true
          }
        end

        it { is_expected.to contain_class('git') }
        it { is_expected.to contain_class('r10k::install::bundle') }
        it { is_expected.not_to contain_package('r10k') }
      end

      context 'with yum provider' do
        let :params do
          {
            install_options:        '',
            keywords:               '',
            manage_ruby_dependency: 'declare',
            package_name:           'rubygem-r10k',
            provider:               'yum',
            version:                'latest',
            puppet_master:          true
          }
        end

        it { is_expected.not_to contain_class('git') }
        it { is_expected.to contain_package('rubygem-r10k') }
      end

      context 'with zypper provider' do
        let :params do
          {
            install_options:        '',
            keywords:               '',
            manage_ruby_dependency: 'declare',
            package_name:           'r10k',
            provider:               'zypper',
            version:                'latest',
            puppet_master:          true
          }
        end
        let :facts do
          {
            osfamily:               'Suse',
            operatingsystemrelease: '11.3'
          }
        end

        it { is_expected.not_to contain_class('git') }
        it { is_expected.to contain_package('r10k') }
      end

      context 'with portage provider' do
        let :params do
          {
            install_options:        '',
            keywords:               ['~amd64', '~x86'],
            manage_ruby_dependency: 'declare',
            package_name:           'app-admin/r10k',
            provider:               'portage',
            version:                version,
            puppet_master:          true
          }
        end
        let :facts do
          {
            osfamily:               'Gentoo',
            operatingsystemrelease: '2.1'
          }
        end

        it { is_expected.not_to contain_class('git') }
        it do
          is_expected.to contain_class('r10k::install::portage').with(
            package_name: 'app-admin/r10k',
            keywords:     ['~amd64', '~x86'],
            version:      version
          )
        end
        it do
          is_expected.to contain_package_keywords('dev-ruby/cri').with(
            keywords: ['~amd64', '~x86'],
            target:   'puppet'
          )
        end
        it do
          is_expected.to contain_portage__package('app-admin/r10k').with(
            keywords: ['~amd64', '~x86'],
            ensure:   version,
            target:   'puppet'
          )
        end
        it { is_expected.to contain_package('app-admin/r10k') }
        it { is_expected.not_to contain_package('r10k') }
      end
    end
  end
end
