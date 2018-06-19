require 'spec_helper'
describe 'r10k::config', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'modified file locations and ownership' do
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
      end

      context 'set to value true and a configfile specified' do
        let :params do
          {
            manage_configfile_symlink: true
          }
        end

        it do
          is_expected.to contain_file('symlink_r10k.yaml').with(
            ensure: 'link',
            path:   '/etc/r10k.yaml',
            target: '/etc/puppetlabs/r10k/r10k.yaml'
          )
        end
      end

      context 'Managing r10k with rugged turned on via git_settings' do
        let :params do
          {
            git_settings: { 'provider' => 'rugged', 'private_key' => '/root/.ssh/id_dsa' }
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
            forge_settings: { 'proxy' => 'https://proxy.example.com:3128', 'baseurl' => 'https://forgeapi.puppetlabs.com' }
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{forge:\n.*baseurl: https:\/\/forgeapi\.puppetlabs\.com\n.*proxy: https:\/\/proxy\.example\.com:3128\n}) }
      end

      context 'with optional parameter postrun specified with array of system call "/usr/bin/curl -F deploy=done http://my-app.site/endpoint"' do
        let :params do
          {
            configfile:         '/etc/r10k.yaml',
            cachedir:           '/var/cache/r10k',
            manage_modulepath:  false,
            postrun:            ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint'],
            root_user:         'root',
            root_group:        'root'
          }
        end

        it { is_expected.to contain_file('r10k.yaml').with_content(%r{^.*:postrun: \[\"/usr/bin/curl\", \"-F\", \"deploy=done\", \"http://my-app\.site/endpoint\"\]\n.*$}) }
      end

      context 'with empty cachedir' do
        let :params do
          {
            cachedir: ''
          }
        end

        it { is_expected.to contain_file('r10k.yaml').without_content(%r{^:cachedir: .*$}) }
      end
    end
  end
end
