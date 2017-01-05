require 'spec_helper'
describe 'r10k::install::bundle', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'Puppet with bundle & no params' do
        let :facts do
          facts
        end

        it do
          is_expected.to contain_package('r10k-bundle').with(
            ensure:   'installed',
            name:     'bundler',
            provider: 'gem'
          )
        end
        it do
          is_expected.to contain_vcsrepo('r10k-r10k-github').with(
            ensure:   'latest',
            provider: 'git',
            path:     '/tmp/r10k',
            source:   'https://github.com/adrienthebo/r10k.git',
            revision: 'master'
          )
        end
        it do
          is_expected.to contain_exec('r10k-install-via-bundle').with(
            command: 'bundle && bundle install --path /opt/ --binstubs /usr/local/bin/',
            cwd:     '/tmp/r10k',
            unless:  'bundle list | grep -q " r10k "'
          )
        end
      end

      context 'Puppet Enterprise with bundle & custom params' do
        let :params do
          {
            revision: 'new_feature',
            source:   'https://github.com/acidprime/r10k-fork.git'
          }
        end
        let :facts do
          facts
        end

        it do
          is_expected.to contain_package('r10k-bundle').with(
            ensure:   'installed',
            name:     'bundler',
            provider: 'gem'
          )
        end
        it do
          is_expected.to contain_vcsrepo('r10k-r10k-github').with(
            ensure:   'latest',
            provider: 'git',
            path:     '/tmp/r10k',
            source:   'https://github.com/acidprime/r10k-fork.git',
            revision: 'new_feature'
          )
        end
        it do
          is_expected.to contain_exec('r10k-install-via-bundle').with(
            command: 'bundle && bundle install --path /opt/ --binstubs /usr/local/bin/',
            cwd:     '/tmp/r10k',
            unless:  'bundle list | grep -q " r10k "'
          )
        end
      end
    end
  end
end
