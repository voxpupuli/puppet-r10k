require 'spec_helper'
describe 'r10k::config', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'on Puppet Opensource' do
        let :params do
          {
            configfile:        '/etc/r10k.yaml',
            cachedir:          '/var/cache/r10k',
            manage_modulepath: false,
            root_user:         'root',
            root_group:        'root'
          }
        end

        it { is_expected.to contain_class('r10k::params') }
        it do
          is_expected.to contain_file('r10k.yaml').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            path:   '/etc/r10k.yaml'
          )
        end
        it { is_expected.to contain_file('r10k.yaml').without_content(%r{^:postrun: .*$}) }
        it { is_expected.not_to contain_ini_setting('R10k Modulepath') }
      end

      context 'on Puppet Enterprise 3.8.0' do
        let :params do
          {
            configfile:        '/etc/r10k.yaml',
            cachedir:          '/var/cache/r10k',
            manage_modulepath: true,
            root_user:         'root',
            root_group:        'root'
          }
        end

        let :facts do
          super().merge(
            is_pe:      'true',
            pe_version: '3.8.0'
          )
        end

        it { is_expected.to contain_class('r10k::params') }
        it do
          is_expected.to contain_file('r10k.yaml').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            path:   '/etc/r10k.yaml'
          )
        end
        it do
          is_expected.to contain_ini_setting('R10k Modulepath').with(
            ensure:  'present',
            path:    '/etc/puppetlabs/puppet/puppet.conf',
            section: 'main',
            setting: 'modulepath'
          )
        end
      end

      context 'when forgetting to pass a hash' do
        let :params do
          {
            configfile:        '/etc/r10k.yaml',
            cachedir:          '/var/cache/r10k',
            manage_modulepath: true,
            sources:           'i-am-not-a-hash',
            root_user:         'root',
            root_group:        'root'
          }
        end

        it 'fails when sources is not a hash' do
          expect { catalogue }.to raise_error(Puppet::Error, %r{is not a Hash})
        end
      end

      describe 'with manage_configfile_symlink' do
        ['true', true].each do |value|
          context "set to value '#{value}' and a configfile specified" do
            let :params do
              {
                manage_configfile_symlink: value,
                configfile:                '/etc/puppet/r10k.yaml',
                cachedir:                  '/var/cache/r10k',
                manage_modulepath:         false,
                root_user:                 'root',
                root_group:                'root'
              }
            end

            it do
              is_expected.to contain_file('symlink_r10k.yaml').with(
                ensure: 'link',
                path:   '/etc/r10k.yaml',
                target: '/etc/puppet/r10k.yaml'
              )
            end
          end
        end

        ['false', false].each do |value|
          context "set to value '#{value}' and a configfile specified" do
            let :params do
              {
                manage_configfile_symlink: value,
                configfile:                '/etc/puppet/r10k.yaml',
                cachedir:                  '/var/cache/r10k',
                manage_modulepath:         false,
                root_user:                 'root',
                root_group:                'root'
              }
            end

            it { is_expected.not_to contain_file('symlink_r10k.yaml') }
          end
        end

        context 'set to a non-boolean value' do
          let :params do
            {
              manage_configfile_symlink: 'invalid',
              configfile:                '/etc/r10k.yaml',
              cachedir:                  '/var/cache/r10k',
              manage_modulepath:         false,
              root_user:                 'root',
              root_group:                'root'
            }
          end

          it 'fails' do
            expect { catalogue }.to raise_error(Puppet::Error)
          end
        end
      end

      context 'with configfile_symlink specified as a non fully qualified path' do
        let :params do
          {
            manage_configfile_symlink: true,
            configfile:                '/etc/r10k.yaml',
            configfile_symlink:        'invalid/path',
            cachedir:                  '/var/cache/r10k',
            manage_modulepath:         false,
            root_user:                 'root',
            root_group:                'root'
          }
        end

        it 'fails' do
          expect { catalogue }.to raise_error(Puppet::Error)
        end
      end

      context 'Managing r10k with rugged turned on via git_settings' do
        let :params do
          {
            configfile:          '/etc/r10k.yaml',
            cachedir:            '/var/cache/r10k',
            manage_modulepath:   false,
            git_settings:        { 'provider' => 'rugged', 'private_key' => '/root/.ssh/id_dsa' },
            root_user:           'root',
            root_group:          'root'
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{git:\n.*private_key: /root/\.ssh/id_dsa\n.*provider: rugged\n}) }
      end

      context 'manage forge settings of r10k via forge_settings' do
        let :params do
          {
            configfile:          '/etc/r10k.yaml',
            cachedir:            '/var/cache/r10k',
            manage_modulepath:   false,
            forge_settings:      { 'proxy' => 'https://proxy.example.com:3128', 'baseurl' => 'https://forgeapi.puppetlabs.com' },
            root_user:          'root',
            root_group:         'root'
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{forge:\n.*baseurl: https:\/\/forgeapi\.puppetlabs\.com\n.*proxy: https:\/\/proxy\.example\.com:3128\n}) }
      end

      describe 'with optional parameter postrun specified' do
        context 'with array of system call "/usr/bin/curl -F deploy=done http://my-app.site/endpoint"' do
          let :params do
            {
              configfile:          '/etc/r10k.yaml',
              cachedir:            '/var/cache/r10k',
              manage_modulepath:   false,
              postrun:             ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint'],
              root_user:          'root',
              root_group:         'root'
            }
          end

          it { is_expected.to contain_file('r10k.yaml').with_content(%r{^.*:postrun: \[\"/usr/bin/curl\", \"-F\", \"deploy=done\", \"http://my-app\.site/endpoint\"\]\n.*$}) }
        end

        ['string', true, 1, 1.0, {}].each do |value|
          context "with #{value}" do
            let :params do
              {
                configfile:          '/etc/r10k.yaml',
                cachedir:            '/var/cache/r10k',
                manage_modulepath:   false,
                postrun:             value,
                root_user:          'root',
                root_group:         'root'
              }
            end

            it 'fails when sources is not an Array' do
              expect { catalogue }.to raise_error(Puppet::Error, %r{is not an Array})
            end
          end
        end
      end
    end
  end
end
