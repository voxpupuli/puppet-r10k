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
        'group'  => '0',
        'mode'   => '0644',
        'notify' => 'Service[webhook]'
      )
    }

    content = """---
  access_logfile: \"/var/log/webhook/access.log\"
  bind_address: \"0.0.0.0\"
  certname: \"peadmin\"
  certpath: \"/var/lib/peadmin/.mcollective.d\"
  client_cfg: \"/var/lib/peadmin/.mcollective\"
  client_timeout: \"120\"
  command_prefix: \"umask 0022;\"
  discovery_timeout: \"10\"
  enable_ssl: true
  pass: \"peadmin\"
  port: \"8088\"
  prefix: false
  prefix_command: \"/bin/echo example\"
  protected: true
  r10k_deploy_arguments: \"-pv\"
  use_mco_ruby: false
  use_mcollective: true
  user: \"peadmin\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end
end
