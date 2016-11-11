require 'spec_helper'
describe 'r10k::prerun_command', type: 'class' do
  context 'Puppet Enterprise on a RedHat 5 OS' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true'
      }
    end
    context 'adding custom prerun_command' do
      let(:params) do
        {
          command: 'r10k synchronize',
          ensure: 'present'
        }
      end
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'present',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k synchronize',
          'path'    => '/etc/puppetlabs/puppet/puppet.conf'
        )
      end
    end
    context 'removing custom prerun_command' do
      let(:params) do
        {
          command: 'r10k synchronize',
          ensure: 'absent'
        }
      end
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'absent',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k synchronize',
          'path'    => '/etc/puppetlabs/puppet/puppet.conf'
        )
      end
    end
  end
  context 'Puppet FOSS on OpenBSD 5.7' do
    let(:facts) do
      {
        osfamily: 'OpenBSD',
        kernelversion: '5.7',
        is_pe: 'false'
      }
    end
    context 'default prerun_command' do
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'present',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k21 deploy environment -p',
          'path'    => '/etc/puppet/puppet.conf'
        )
      end
    end
    context 'adding custom prerun_command' do
      let(:params) do
        {
          command: 'r10k21 synchronize',
          ensure: 'present'
        }
      end
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'present',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k21 synchronize',
          'path'    => '/etc/puppet/puppet.conf'
        )
      end
    end
    context 'removing custom prerun_command' do
      let(:params) do
        {
          command: 'r10k21 synchronize',
          ensure: 'absent'
        }
      end
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'absent',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k21 synchronize',
          'path'    => '/etc/puppet/puppet.conf'
        )
      end
    end
  end
  context 'Puppet FOSS on OpenBSD 5.8' do
    let(:facts) do
      {
        osfamily: 'OpenBSD',
        kernelversion: '5.8',
        is_pe: 'false'
      }
    end
    context 'default prerun_command' do
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'present',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k22 deploy environment -p',
          'path'    => '/etc/puppet/puppet.conf'
        )
      end
    end
    context 'adding custom prerun_command' do
      let(:params) do
        {
          command: 'r10k22 synchronize',
          ensure: 'present'
        }
      end
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'present',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k22 synchronize',
          'path'    => '/etc/puppet/puppet.conf'
        )
      end
    end
    context 'removing custom prerun_command' do
      let(:params) do
        {
          command: 'r10k22 synchronize',
          ensure: 'absent'
        }
      end
      it { is_expected.to contain_class('r10k::params') }
      it do
        is_expected.to contain_ini_setting('r10k_prerun_command').with(
          'ensure'  => 'absent',
          'section' => 'agent',
          'setting' => 'prerun_command',
          'value'   => 'r10k22 synchronize',
          'path'    => '/etc/puppet/puppet.conf'
        )
      end
    end
  end
end
