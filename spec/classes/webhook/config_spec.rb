require 'spec_helper'
describe 'r10k::webhook::config', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      let :pre_condition do
        'include r10k::webhook'
      end

      context 'Puppet Enterprise 2016.4.2 with defaults' do
        let :facts do
          facts.merge(
            pe_server_version: '2016.4.2'
          )
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end
        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
certname: "peadmin"
certpath: "/var/lib/peadmin/.mcollective.d"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
ignore_environments: []
pass: "peadmin"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
private_key_path: "/var/lib/peadmin/.mcollective.d/peadmin-private.pem"
protected: true
public_key_path: "/var/lib/peadmin/.mcollective.d/peadmin-cert.pem"
r10k_deploy_arguments: "-pv"
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "peadmin"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'Puppet Enterprise 2016.4.2 with events defined' do
        let :params do
          {
            repository_events: %w[merge release]
          }
        end
        let :facts do
          facts.merge(
            pe_server_version: '2016.4.2'
          )
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end
        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
certname: "peadmin"
certpath: "/var/lib/peadmin/.mcollective.d"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
ignore_environments: []
pass: "peadmin"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
private_key_path: "/var/lib/peadmin/.mcollective.d/peadmin-private.pem"
protected: true
public_key_path: "/var/lib/peadmin/.mcollective.d/peadmin-cert.pem"
r10k_deploy_arguments: "-pv"
repository_events: ["merge", "release"]
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "peadmin"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'Puppet Enterprise 2016.4.2 removing Webhook Config' do
        let :params do
          {
            ensure: false
          }
        end
        let :facts do
          facts.merge(
            pe_server_version: '2016.4.2'
          )
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            ensure: 'absent',
            path:   '/etc/webhook.yaml'
          )
        end
      end

      context 'FOSS with defaults' do
        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end

        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
ignore_environments: []
pass: "puppet"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
protected: true
r10k_deploy_arguments: "-pv"
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "puppet"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'FOSS with mutex lock enabled' do
        let :params do
          {
            enable_mutex_lock: true
          }
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end

        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: true
enable_ssl: true
generate_types: false
ignore_environments: []
pass: "puppet"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
protected: true
r10k_deploy_arguments: "-pv"
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "puppet"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'FOSS with github secret enabled' do
        let :params do
          {
            github_secret: 'secret'
          }
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end
        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
github_secret: "secret"
ignore_environments: []
pass: "puppet"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
protected: true
r10k_deploy_arguments: "-pv"
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "puppet"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'FOSS with slack webhook enabled' do
        let :params do
          {
            slack_webhook: 'slack_webhook'
          }
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end
        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
ignore_environments: []
pass: "puppet"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
protected: true
r10k_deploy_arguments: "-pv"
server_software: "WebHook"
slack_webhook: "slack_webhook"
use_mco_ruby: false
use_mcollective: true
user: "puppet"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'FOSS with Rocket.Chat webhook enabled' do
        let :params do
          {
            rocketchat_webhook: 'rocketchat_webhook'
          }
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end
        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
ignore_environments: []
pass: "puppet"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
protected: true
r10k_deploy_arguments: "-pv"
rocketchat_webhook: "rocketchat_webhook"
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "puppet"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end

      context 'Puppet Enterprise 2015.3.1 removing Webhook Config' do
        let :params do
          {
            ensure: false
          }
        end
        let :facts do
          facts.merge(
            is_pe:           'true',
            pe_server_version: '2015.3.1'
          )
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            ensure: 'absent',
            path:   '/etc/webhook.yaml'
          )
        end
      end

      context 'FOSS with custom permissions for webhook.yaml' do
        let :params do
          {
            configfile_owner: 'r10k',
            configfile_group: 'r10k',
            configfile_mode:  '0600'
          }
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'r10k',
            group:  'r10k',
            mode:   '0600',
            notify: 'Service[webhook]'
          )
        end
      end

      context 'FOSS with extra mco argument' do
        let :params do
          {
            mco_arguments: '--no-progress'
          }
        end

        it do
          is_expected.to contain_file('webhook.yaml').with(
            path:   '/etc/webhook.yaml',
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            notify: 'Service[webhook]'
          )
        end
        content = '---
access_logfile: "/var/log/webhook/access.log"
allow_uppercase: true
bind_address: "0.0.0.0"
client_cfg: "/var/lib/peadmin/.mcollective"
client_timeout: "120"
command_prefix: "umask 0022;"
default_branch: "production"
discovery_timeout: "10"
enable_mutex_lock: false
enable_ssl: true
generate_types: false
ignore_environments: []
mco_arguments: "--no-progress"
pass: "puppet"
port: "8088"
prefix: false
prefix_command: "/bin/echo example"
protected: true
r10k_deploy_arguments: "-pv"
server_software: "WebHook"
use_mco_ruby: false
use_mcollective: true
user: "puppet"
'
        it { is_expected.to contain_file('webhook.yaml').with_content(content) }
      end
    end
  end
end
