require 'spec_helper'
describe 'r10k::prerun_command' , :type => 'class' do
  context "Puppet Enterprise on a RedHat 5 OS installing adding custom prerun_command" do
    let :params do
      {
        :command               => 'r10k synchronize',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_ini_setting("r10k_prerun_command").with(
        'ensure'  => 'present',
        'section' => 'agent',
        'setting' => 'prerun_command',
        'value'   => 'r10k synchronize',
        'path'    => '/etc/puppetlabs/puppet/puppet.conf'
      )
    }
  end
end
