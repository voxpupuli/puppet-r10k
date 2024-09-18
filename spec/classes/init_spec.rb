# frozen_string_literal: true

require 'spec_helper'

version = '2.0.0'

describe 'r10k' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let :facts do
        os_facts
      end

      context 'with default values' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('r10k::install') }
        it { is_expected.to contain_class('r10k::config') }
        it { is_expected.not_to contain_class('r10k::mcollective') }
        it { is_expected.not_to contain_class('r10k::prerun_command') }
        it { is_expected.not_to contain_class('r10k::postrun_command') }
      end

      context 'with param include_prerun_command set to true' do
        let :params do
          {
            include_prerun_command: true
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('r10k::prerun_command') }
      end

      context 'with param include_postrun_command set to true' do
        let :params do
          {
            include_postrun_command: true
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('r10k::postrun_command') }
      end

      context 'modified file locations and ownership' do
        let :params do
          {
            configfile: '/etc/r10k.yaml',
            cachedir: '/var/cache/r10k',
            manage_modulepath: false,
            root_user: 'root',
            root_group: 'root'
          }
        end

        it do
          expect(subject).to contain_file('r10k.yaml').with(
            ensure: 'file',
            owner: 'root',
            group: 'root',
            mode: '0644',
            path: '/etc/r10k.yaml'
          )
        end
      end

      context 'set to value true and a configfile specified' do
        let :params do
          {
            manage_configfile_symlink: true
          }
        end

        it do
          expect(subject).to contain_file('symlink_r10k.yaml').with(
            ensure: 'link',
            path: '/etc/r10k.yaml',
            target: '/etc/puppetlabs/r10k/r10k.yaml'
          )
        end
      end

      context 'Managing r10k with rugged turned on via git_settings' do
        let :params do
          {
            git_settings: { 'private_key' => '/root/.ssh/id_dsa', 'provider' => 'rugged' }
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{git:\n.*private_key: "/root/\.ssh/id_dsa"\n.*provider: rugged\n}) }
      end

      context 'managing git repository settings' do
        let :params do
          {
            git_settings: {
              repositories: [{
                remote: 'https://github.com/voxpupuli/fake_repo',
                proxy: 'http://some.proxy.com'
              }]
            }
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{git:\n\s+repositories:\n\s+- remote: https://github\.com/voxpupuli/fake_repo\n\s+proxy: http://some\.proxy\.com\n}) }
      end

      context 'manage forge settings of r10k via forge_settings' do
        let :params do
          {
            forge_settings: { 'baseurl' => 'https://forgeapi.puppetlabs.com', 'proxy' => 'https://proxy.example.com:3128' }
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{forge:\n.*baseurl: https://forgeapi\.puppetlabs\.com\n.*proxy: https://proxy\.example\.com:3128\n}) }
      end

      context 'with optional parameter postrun specified with array of system call "/usr/bin/curl -F deploy=done http://my-app.site/endpoint"' do
        let :params do
          {
            configfile: '/etc/r10k.yaml',
            cachedir: '/var/cache/r10k',
            manage_modulepath: false,
            postrun: ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint'],
            root_user: 'root',
            root_group: 'root'
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{^postrun:\n.*"/usr/bin/curl"\n.*"-F"\n.*deploy=done\n.*http://my-app\.site/endpoint\n}) }
      end

      context 'with empty proxy' do
        let :params do
          {
            proxy: :undef
          }
        end

        it { is_expected.to contain_file('r10k.yaml').without_content(%r{^proxy: .*$}) }
      end

      context 'with proxy' do
        let :params do
          {
            proxy: 'https://proxy.local:8080'
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{^proxy: https://proxy.local:8080$}) }
      end

      context 'with pool_size' do
        let :params do
          {
            pool_size: 5
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{^pool_size: 5$}) }
      end
      # This install method uses the archived puppetlabs/ruby module
      # It doesn't support Gentoo

      context 'with gem provider', if: os_facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            install_options: '',
            provider: 'gem',
            version: version,
            puppet_master: true
          }
        end

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'gem'
          )
        end
      end

      context 'with gem with empty install_options', if: os_facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            provider: 'gem',
            version: version,
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
      end

      context 'with gem with populated install_options', if: os_facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            provider: 'gem',
            version: version,
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
      end

      context 'with puppet_gem provider' do
        let :params do
          {
            version: version,
            provider: 'puppet_gem',
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
      end

      context 'with puppet_gem on Puppet FOSS' do
        let :params do
          {
            install_options: '',
            provider: 'puppet_gem',
            version: version,
          }
        end

        it {
          is_expected.to contain_package('r10k').with(
            ensure: version,
            provider: 'puppet_gem'
          )
        }

        it do
          expect(subject).to contain_file('/usr/bin/r10k').with(
            ensure: 'link',
            target: '/opt/puppetlabs/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
      end

      context 'with defaults and source specified', if: os_facts[:os]['name'] != 'Gentoo' do
        let :params do
          {
            provider: 'gem',
            version: version,
            gem_source: 'https://some.alternate.source.com/',
            install_options: [],
            puppet_master: true
          }
        end

        it do
          expect(subject).to contain_package('r10k').with(
            ensure: version,
            provider: 'gem',
            source: 'https://some.alternate.source.com/'
          )
        end
      end

      context 'with bundle provider' do
        let :params do
          {
            version: version,
            provider: 'bundle',
            install_options: '',
            puppet_master: true
          }
        end

        it { is_expected.to contain_class('r10k::install::bundle') }
        it { is_expected.not_to contain_package('r10k') }
      end
    end
  end
end
