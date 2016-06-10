require 'spec_helper'
describe 'r10k::webhook::config' , :type => 'class' do
  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :pe_version             => '3.7.0'
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
access_logfile: \"/var/log/webhook/access.log\"
allow_uppercase: true
bind_address: \"0.0.0.0\"
certname: \"peadmin\"
certpath: \"/var/lib/peadmin/.mcollective.d\"
client_cfg: \"/var/lib/peadmin/.mcollective\"
client_timeout: \"120\"
command_prefix: \"umask 0022;\"
discovery_timeout: \"10\"
enable_mutex_lock: false
enable_ssl: true
pass: \"peadmin\"
port: \"8088\"
prefix: false
prefix_command: \"/bin/echo example\"
private_key_path: \"/var/lib/peadmin/.mcollective.d/peadmin-private.pem\"
protected: true
public_key_path: \"/var/lib/peadmin/.mcollective.d/peadmin-cert.pem\"
r10k_deploy_arguments: \"-pv\"
server_software: \"WebHook\"
use_mco_ruby: false
use_mcollective: true
user: \"peadmin\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end
  context 'FOSS 4.0 on a RedHat 6 installing webhook' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :operatingsystem        => 'Centos',
        :pe_version             => '4.2.0'
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
access_logfile: \"/var/log/webhook/access.log\"
allow_uppercase: true
bind_address: \"0.0.0.0\"
client_cfg: \"/var/lib/peadmin/.mcollective\"
client_timeout: \"120\"
command_prefix: \"umask 0022;\"
discovery_timeout: \"10\"
enable_mutex_lock: false
enable_ssl: true
pass: \"puppet\"
port: \"8088\"
prefix: false
prefix_command: \"/bin/echo example\"
protected: true
r10k_deploy_arguments: \"-pv\"
server_software: \"WebHook\"
use_mco_ruby: false
use_mcollective: true
user: \"puppet\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end

    context 'FOSS 4.0 on a RedHat 6 installing webhook with mutex lock enabled' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :operatingsystem        => 'Centos',
        :pe_version             => '4.2.0'
      }
    end
    let(:params) do
      {
        :enable_mutex_lock => true,
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
access_logfile: \"/var/log/webhook/access.log\"
allow_uppercase: true
bind_address: \"0.0.0.0\"
client_cfg: \"/var/lib/peadmin/.mcollective\"
client_timeout: \"120\"
command_prefix: \"umask 0022;\"
discovery_timeout: \"10\"
enable_mutex_lock: true
enable_ssl: true
pass: \"puppet\"
port: \"8088\"
prefix: false
prefix_command: \"/bin/echo example\"
protected: true
r10k_deploy_arguments: \"-pv\"
server_software: \"WebHook\"
use_mco_ruby: false
use_mcollective: true
user: \"puppet\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end


    context 'FOSS 4.0 on a RedHat 7 installing webhook with mutex lock enabled' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '7',
        :operatingsystem        => 'Centos',
        :pe_version             => '4.2.0'
      }
    end
    let(:params) do
      {
        :enable_mutex_lock => true,
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
access_logfile: \"/var/log/webhook/access.log\"
allow_uppercase: true
bind_address: \"0.0.0.0\"
client_cfg: \"/var/lib/peadmin/.mcollective\"
client_timeout: \"120\"
command_prefix: \"umask 0022;\"
discovery_timeout: \"10\"
enable_mutex_lock: true
enable_ssl: true
pass: \"puppet\"
port: \"8088\"
prefix: false
prefix_command: \"/bin/echo example\"
protected: true
r10k_deploy_arguments: \"-pv\"
server_software: \"WebHook\"
use_mco_ruby: false
use_mcollective: true
user: \"puppet\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end

  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook with events defined' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :pe_version             => '3.7.0'
      }
    end
    let(:params) do
      {
        :repository_events => ['merge','release'],
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
access_logfile: \"/var/log/webhook/access.log\"
allow_uppercase: true
bind_address: \"0.0.0.0\"
certname: \"peadmin\"
certpath: \"/var/lib/peadmin/.mcollective.d\"
client_cfg: \"/var/lib/peadmin/.mcollective\"
client_timeout: \"120\"
command_prefix: \"umask 0022;\"
discovery_timeout: \"10\"
enable_mutex_lock: false
enable_ssl: true
pass: \"peadmin\"
port: \"8088\"
prefix: false
prefix_command: \"/bin/echo example\"
private_key_path: \"/var/lib/peadmin/.mcollective.d/peadmin-private.pem\"
protected: true
public_key_path: \"/var/lib/peadmin/.mcollective.d/peadmin-cert.pem\"
r10k_deploy_arguments: \"-pv\"
repository_events: [\"merge\", \"release\"]
server_software: \"WebHook\"
use_mco_ruby: false
use_mcollective: true
user: \"peadmin\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end

  context 'FOSS 4.0 on a RedHat 7 installing webhook with github secret enabled' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '7',
        :operatingsystem        => 'Centos',
        :pe_version             => '4.2.0'
      }
    end
    let(:params) do
      {
        :github_secret => 'secret',
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
access_logfile: \"/var/log/webhook/access.log\"
allow_uppercase: true
bind_address: \"0.0.0.0\"
client_cfg: \"/var/lib/peadmin/.mcollective\"
client_timeout: \"120\"
command_prefix: \"umask 0022;\"
discovery_timeout: \"10\"
enable_mutex_lock: false
enable_ssl: true
github_secret: \"secret\"
pass: \"puppet\"
port: \"8088\"
prefix: false
prefix_command: \"/bin/echo example\"
protected: true
r10k_deploy_arguments: \"-pv\"
server_software: \"WebHook\"
use_mco_ruby: false
use_mcollective: true
user: \"puppet\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end

  context 'Puppet Enterprise 2015.3.1 on a RedHat 6 Removing Webhook Config' do
    let :params do
      {
        :ensure => false,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :pe_server_build        => '2015.3.1'
      }
    end
    it { should contain_file('webhook.yaml').with(
        'ensure' => 'absent',
        'path'   => '/etc/webhook.yaml'
      )
    }
  end

  context 'FOSS on RedHat 7 installing with custom permissions for webhook.yaml' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '7',
        :operatingsystem        => 'Centos',
      }
    end
    let(:params) do
      {
        :configfile_owner => 'r10k',
        :configfile_group => 'r10k',
        :configfile_mode  => '0600',
      }
    end
    it { should contain_file('webhook.yaml').with(
        'path'   => '/etc/webhook.yaml',
        'ensure' => 'file',
        'owner'  => 'r10k',
        'group'  => 'r10k',
        'mode'   => '0600',
        'notify' => 'Service[webhook]'
      )
    }
  end
 
end
