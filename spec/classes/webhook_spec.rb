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
            enabled: false,
          },
          tls: {
            enabled: false,
          },
          server: {
            protected: true,
            user: 'puppet',
            password: 'puppet',
            port: 4000,
          },
          r10k_settings: {
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
      if os == 'archlinux-rolling-x86_64' || os == 'gentoo-2-x86_64'
        it { is_expected.not_to compile }
      else
        it { is_expected.to compile }
      end
    end
  end
end
