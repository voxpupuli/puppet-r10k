require 'spec_helper'
describe 'r10k::postrun_command' , :type => 'class' do
  context 'Puppet Enterprise on a RedHat 5 OS install' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end
    context "adding custom postrun_command" do
      let :params do
        {
          :command               => 'r10k synchronize',
          :ensure                => 'present',
        }
      end
      it { should contain_class("r10k::params") }
      it { should contain_ini_setting("r10k_postrun_command").with(
        'ensure'  => 'present',
        'section' => 'agent',
        'setting' => 'postrun_command',
        'value'   => 'r10k synchronize',
        'path'    => '/etc/puppetlabs/puppet/puppet.conf'
      )
      }
    end
    context "removing custom postrun_command" do
      let :params do
        {
          :command               => 'r10k synchronize',
          :ensure                => 'absent',
        }
      end
      it { should contain_class("r10k::params") }
      it { should contain_ini_setting("r10k_postrun_command").with(
        'ensure'  => 'absent',
        'section' => 'agent',
        'setting' => 'postrun_command',
        'value'   => 'r10k synchronize',
        'path'    => '/etc/puppetlabs/puppet/puppet.conf'
      )
      }
    end
  end
  context 'Puppet FOSS on a OpenBSD install' do
    let :facts do
      {
        :osfamily               => 'OpenBSD',
        :is_pe                  => 'false'
      }
    end
    context "adding custom postrun_command" do
      let :params do
        {
          :command               => 'r10k21 synchronize',
          :ensure                => 'present',
        }
      end
      it { should contain_class("r10k::params") }
      it { should contain_ini_setting("r10k_postrun_command").with(
        'ensure'  => 'present',
        'section' => 'agent',
        'setting' => 'postrun_command',
        'value'   => 'r10k21 synchronize',
        'path'    => '/etc/puppet/puppet.conf'
      )
      }
    end
    context "removing custom postrun_command" do
      let :params do
        {
          :command               => 'r10k21 synchronize',
          :ensure                => 'absent',
        }
      end
      it { should contain_class("r10k::params") }
      it { should contain_ini_setting("r10k_postrun_command").with(
        'ensure'  => 'absent',
        'section' => 'agent',
        'setting' => 'postrun_command',
        'value'   => 'r10k21 synchronize',
        'path'    => '/etc/puppet/puppet.conf'
      )
      }
    end
  end
end
