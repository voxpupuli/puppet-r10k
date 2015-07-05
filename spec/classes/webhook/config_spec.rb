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
  user: peadmin
  pass: peadmin
  bind_address: \"0.0.0.0\"
  port: \"8088\"
  certname: peadmin
  client_timeout: \"120\"
  discovery_timeout: \"10\"
  certpath: /var/lib/peadmin/.mcollective.d
  client_cfg: /var/lib/peadmin/.mcollective
  use_mco_ruby: false
  access_logfile: /var/log/webhook/access.log
  protected: true
  prefix: false
  prefix_command: \"/bin/echo example\"
  enable_ssl: true
  use_mcollective: true
  r10k_deploy_arguments: \"-pv\"
  public_key_path: !ruby/sym undef
  private_key_path: !ruby/sym undef
  command_prefix: \"\"
"""
    it { should contain_file('webhook.yaml').with_content(content) }
  end
end
