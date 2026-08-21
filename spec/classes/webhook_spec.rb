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
          package_url = 'https://github.com/voxpupuli/webhook-go/releases/download/v2.14.3/webhook-go_2.14.3_linux_amd64'

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('r10k::webhook::package') }
          it { is_expected.to contain_class('r10k::webhook::service') }
          it { is_expected.to contain_class('r10k::webhook::config') }
          it { is_expected.to contain_package('webhook-go').with_ensure('present') }
          it { is_expected.to contain_service('webhook-go.service').with_ensure('running') }

          if os_facts[:os]['family'] == 'RedHat'
            it { is_expected.to contain_file('/tmp/webhook-go.rpm').with_source("#{package_url}.rpm") }
          elsif os_facts[:os]['family'] == 'Debian'
            it { is_expected.to contain_file('/tmp/webhook-go.deb').with_source("#{package_url}.deb") }
          end
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
            },
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
mappings: {}
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
            it { is_expected.to contain_service('webhook-go.service').with_ensure('running') }
            it { is_expected.not_to contain_systemd__dropin_file('user.conf') }
            it { is_expected.to contain_file('webhook.yml').with_content(content) }

            package_url = 'https://github.com/voxpupuli/webhook-go/releases/download/v1.0.0/webhook-go_1.0.0_linux_amd64'

            if os_facts[:os]['family'] == 'RedHat'
              it { is_expected.to contain_file('/tmp/webhook-go.rpm').with(ensure: 'file', source: "#{package_url}.rpm") }
              it { is_expected.not_to contain_file('/tmp/webhook-go.deb') }
              it { is_expected.to contain_package('webhook-go').with(source: '/tmp/webhook-go.rpm', provider: 'rpm') }
            elsif os_facts[:os]['family'] == 'Debian'
              it { is_expected.not_to contain_file('/tmp/webhook-go.rpm') }
              it { is_expected.to contain_file('/tmp/webhook-go.deb').with(ensure: 'file', source: "#{package_url}.deb") }
              it { is_expected.to contain_package('webhook-go').with(source: '/tmp/webhook-go.deb', provider: 'dpkg') }
            end
          end
        end

        context 'with install_method = none' do
          let :params do
            super().merge({ install_method: 'none' })
          end

          it { is_expected.to compile.with_all_deps }
        end

        context 'with service_user = puppet' do
          let :params do
            super().merge({ service_user: 'puppet' })
          end

          if %w[archlinux-rolling-x86_64 archlinux-6-x86_64 gentoo-2-x86_64].include?(os)
            it { is_expected.not_to compile }
          else
            it { is_expected.to contain_systemd__dropin_file('user.conf').with_content("[Service]\nUser=puppet\n") }
          end
        end
      end
    end
  end

  context 'on Debian aarch64' do
    let :facts do
      os_facts = on_supported_os['debian-12-x86_64']
      os_facts.merge(os: os_facts[:os].merge('architecture' => 'aarch64'))
    end

    it { is_expected.to compile.with_all_deps }

    it do
      is_expected.to contain_file('/tmp/webhook-go.deb').with_source(
        'https://github.com/voxpupuli/webhook-go/releases/download/v2.14.3/webhook-go_2.14.3_linux_arm64.deb',
      )
    end
  end

  context 'on RedHat with the dnf package provider' do
    let :facts do
      on_supported_os['redhat-9-x86_64'].merge(package_provider: 'dnf')
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_file('/tmp/webhook-go.rpm') }

    it do
      is_expected.to contain_package('webhook-go').with(
        ensure: 'present',
        source: 'https://github.com/voxpupuli/webhook-go/releases/download/v2.14.3/webhook-go_2.14.3_linux_amd64.rpm',
      )
    end
  end
end
