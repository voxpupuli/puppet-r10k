# frozen_string_literal: true

require 'spec_helper'

describe 'r10k::webhook' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

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
      if %w[archlinux-rolling-x86_64 gentoo-2-x86_64].include?(os)
        it { is_expected.not_to compile }
      else
        it { is_expected.to compile }
        it { is_expected.to contain_class('r10k::webhook::package') }
        it { is_expected.to contain_class('r10k::webhook::service') }
        it { is_expected.to contain_class('r10k::webhook::config') }
        it { is_expected.to contain_package('webhook-go').with_ensure('present') }
        it { is_expected.to contain_service('webhook-go').with_ensure('running') }
        it { is_expected.to contain_file('webhook.yml').with_content(content) }
      end
    end
  end
end
