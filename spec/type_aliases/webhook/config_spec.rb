# frozen_string_literal: true

require 'spec_helper'

describe 'R10k::Webhook::Config' do
  context 'full valid configuration' do
    let(:data) do
      {
        server: {
          protected: true,
          user: 'foo',
          password: 'bar',
          port: 4000,
          tls: {
            enabled: true,
            certificate: '/some/path/to/cert.pem',
            key: '/some/path/to/key.pem',
          },
          queue: {
            enabled: true,
            max_concurrent_jobs: 10,
            max_history_items: 20,
          },
        },
        chatops: {
          enabled: true,
          service: 'slack',
          channel: '#deploy',
          user: 'baz',
          auth_token: 'abcde',
          server_uri: 'https://test.com/slack',
        },
        r10k: {
          command_path: '/some/path/to/r10k',
          config_path: '/some/path/to/r10k.yaml',
          default_branch: 'main',
          prefix: 'prefix',
          allow_uppercase: false,
          verbose: true,
          deploy_modules: true,
          generate_types: true,
        }
      }
    end

    it { is_expected.to allow_value(data) }
  end
end
