# frozen_string_literal: true

require 'spec_helper'

describe 'r10k::webhook' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let :facts do
        os_facts
      end

      context 'with default params' do
        if %w[archlinux-rolling-x86_64 archlinux-6-x86_64 gentoo-2-x86_64].include?(os)
          it { is_expected.not_to compile }
        else
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('r10k::webhook::package') }
          it { is_expected.to contain_class('r10k::webhook::service') }
          it { is_expected.to contain_class('r10k::webhook::config') }
          it { is_expected.to contain_package('webhook-go').with_ensure('present') }
          it { is_expected.to contain_service('webhook-go').with_ensure('running') }
        end
      end

      context 'with params' do
        let :params do
          {
            ensure: true,
            version: '1.0.0',
            service_ensure: 'running',
            service_enabled: true,
            config_ensure: 'file',
            config_path: '/etc/voxpupuli/webhook.yml',
            chatops: {
              enabled: true,
              service: 'slack',
              channel: '#channel',
              user: 'root',
              auth_token: 'ABCDEF123456789',
              server_uri: 'https://webhook.slack.com/endpoint',
            },
            server: {
              protected: true,
              user: 'puppet',
              password: 'puppet',
              port: 4000,
              tls: {
                enabled: true,
                certificate: '/path/to/cert',
                key: '/path/to/key',
              },
              queue: {
                enabled: true,
                max_concurrent_jobs: 10,
                max_history_items: 20,
              }
            },
            r10k: {
              command_path: '/opt/puppetlabs/puppet/bin/r10k',
              config_path: '/etc/puppetlabs/r10k/r10k.yaml',
              default_branch: 'production',
              allow_uppercase: false,
              verbose: true,
              deploy_modules: true,
              generate_types: true,
            }
          }
        end

        content = '---
server:
  protected: true
  user: puppet
  password: puppet
  port: 4000
  tls:
    enabled: true
    certificate: "/path/to/cert"
    key: "/path/to/key"
  queue:
    enabled: true
    max_concurrent_jobs: 10
    max_history_items: 20
chatops:
  enabled: true
  service: slack
  channel: "#channel"
  user: root
  auth_token: ABCDEF123456789
  server_uri: https://webhook.slack.com/endpoint
r10k:
  command_path: "/opt/puppetlabs/puppet/bin/r10k"
  config_path: "/etc/puppetlabs/r10k/r10k.yaml"
  default_branch: production
  allow_uppercase: false
  verbose: true
  deploy_modules: true
  generate_types: true
'
        context 'with default install_method' do
          if %w[archlinux-rolling-x86_64 archlinux-6-x86_64 gentoo-2-x86_64].include?(os)
            it { is_expected.not_to compile }
          else
            it { is_expected.to compile.with_all_deps }
            it { is_expected.to contain_class('r10k::webhook::package') }
            it { is_expected.to contain_class('r10k::webhook::service') }
            it { is_expected.to contain_class('r10k::webhook::config') }
            it { is_expected.to contain_package('webhook-go').with_ensure('present') }
            it { is_expected.to contain_service('webhook-go').with_ensure('running') }
            it { is_expected.to contain_file('webhook.yml').with_content(content) }

            if os_facts[:os]['family'] == 'RedHat'
              it { is_expected.to contain_file('/tmp/webhook-go.rpm') }
              it { is_expected.not_to contain_file('/tmp/webhook-go.deb') }
            elsif os_facts[:os]['family'] == 'Debian'
              it { is_expected.not_to contain_file('/tmp/webhook-go.rpm') }
              it { is_expected.to contain_file('/tmp/webhook-go.deb') }
            end
          end
        end

        context 'with install_method = none' do
          let :params do
            super().merge({ install_method: 'none' })
          end

          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end
end
