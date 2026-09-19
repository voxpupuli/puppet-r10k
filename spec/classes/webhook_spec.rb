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
          it { is_expected.to contain_file('/etc/voxpupuli').with_ensure('directory') }
          it { is_expected.not_to contain_file('/etc/voxpupuli/r10k.gitconfig') }
          it { is_expected.not_to contain_file('/etc/voxpupuli/r10k-git-credential-helper') }

          it do
            is_expected.to contain_systemd__dropin_file('webhook-go.service-override').with(
              filename: 'override.conf',
              content: "[Service]\n",
            )
          end

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

            it do
              is_expected.to contain_systemd__dropin_file('webhook-go.service-override').with(
                filename: 'override.conf',
                content: "[Service]\n",
              )
            end

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
            it do
              is_expected.to contain_systemd__dropin_file('webhook-go.service-override').with(
                filename: 'override.conf',
                content: "[Service]\nUser=puppet\n",
              )
            end
          end
        end

        context 'with github_token_path' do
          let :params do
            super().merge(
              github_token_path: '/etc/voxpupuli/github.token',
              service_user: 'webhook',
            )
          end

          if %w[archlinux-rolling-x86_64 archlinux-6-x86_64 gentoo-2-x86_64].include?(os)
            it { is_expected.not_to compile }
          else
            it { is_expected.to compile.with_all_deps }

            it do
              is_expected.to contain_file('/etc/voxpupuli').with(
                ensure: 'directory',
                owner: 'root',
                group: 'root',
                mode: '0755',
              )
            end

            it do
              is_expected.to contain_file('/etc/voxpupuli/r10k.gitconfig').with(
                ensure: 'file',
                owner: 'root',
                group: 'webhook',
                mode: '0440',
                content: "[credential \"https://github.com\"]\n  helper = /etc/voxpupuli/r10k-git-credential-helper\n",
                require: [
                  'File[/etc/voxpupuli]',
                  'File[/etc/voxpupuli/r10k-git-credential-helper]',
                ],
              )
            end

            it do
              is_expected.to contain_file('/etc/voxpupuli/r10k-git-credential-helper').with(
                ensure: 'file',
                owner: 'root',
                group: 'webhook',
                mode: '0550',
              ).with_content(<<~'SCRIPT')
                #!/bin/sh

                if [ "$1" = 'get' ]; then
                  if [ ! -f /etc/voxpupuli/github.token ]; then
                    printf '%s: %s\n' 'r10k credential helper: token file does not exist or is not a regular file' /etc/voxpupuli/github.token >&2
                    printf 'quit=true\n\n'
                    exit 1
                  elif [ ! -r /etc/voxpupuli/github.token ]; then
                    printf '%s: %s\n' 'r10k credential helper: token file is not readable' /etc/voxpupuli/github.token >&2
                    printf 'quit=true\n\n'
                    exit 1
                  fi

                  printf '%s\n' 'username=x-access-token'
                  printf 'password='
                  cat -- /etc/voxpupuli/github.token
                  printf '\n'
                fi
              SCRIPT
            end

            it do
              is_expected.to contain_systemd__dropin_file('webhook-go.service-override').with(
                unit: 'webhook-go.service',
                filename: 'override.conf',
                content: <<~DROPIN,
                  [Service]
                  User=webhook
                  Environment=GIT_CONFIG_GLOBAL=/etc/voxpupuli/r10k.gitconfig
                  Environment=GIT_TERMINAL_PROMPT=0
                DROPIN
                require: 'Class[R10k::Webhook::Config]',
                notify: 'Service[webhook-go.service]',
              )
            end
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
