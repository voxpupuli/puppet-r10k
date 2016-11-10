require 'spec_helper'
describe 'r10k::mcollective', type: 'class' do
  context 'Puppet Enterprise on a RedHat 5 OS installing mcollective agent & application' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true'
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/application/r10k.rb').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end
    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.ddl').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end

    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end

    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb').
        with_content(%r{\"GIT_SSL_NO_VERIFY\" => \"0\"})
    end
  end

  context 'Puppet Enterprise on a RedHat 6 OS removing the mcollective agent & application' do
    let(:params) do
      {
        ensure: false
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '6',
        operatingsystem: 'Centos',
        is_pe: 'true'
      }
    end
    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/application/r10k.rb').with(
        'ensure' => 'absent'
      )
    end
    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.ddl').with(
        'ensure' => 'absent'
      )
    end

    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb').with(
        'ensure' => 'absent'
      )
    end
  end

  context 'Allows you to set git_ssl_no_verify for r10k file' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true'
      }
    end

    let(:params) do
      {
        git_ssl_no_verify: 1
      }
    end

    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb').
        with_content(%r{\"GIT_SSL_NO_VERIFY\" => \"1\"})
    end
  end

  context 'Allows you to set git_ssl_verify for r10k file (deprecated - to be removed in major bump)' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true'
      }
    end

    let(:params) do
      {
        git_ssl_no_verify: 1
      }
    end

    it do
      is_expected.to contain_file('/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb').
        with_content(%r{\"GIT_SSL_NO_VERIFY\" => \"1\"})
    end
  end

  context 'Puppet FOSS on a RedHat 5 OS installing mcollective agent & application' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: ''
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it do
      is_expected.to contain_file('/usr/libexec/mcollective/mcollective/application/r10k.rb').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end
    it do
      is_expected.to contain_file('/usr/libexec/mcollective/mcollective/agent/r10k.ddl').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end

    it do
      is_expected.to contain_file('/usr/libexec/mcollective/mcollective/agent/r10k.rb').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end
  end
  context 'Puppet FOSS on a Debian 6 OS installing mcollective agent & application' do
    let(:facts) do
      {
        operatingsystemrelease: '6',
        operatingsystem: 'Ubuntu',
        osfamily: 'Debian',
        is_pe: ''
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it { is_expected.not_to contain_file('/usr/libexec/mcollective/mcollective/application/r10k.rb') }

    it do
      is_expected.to contain_file('/usr/share/mcollective/plugins/mcollective/application/r10k.rb').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end

    it do
      is_expected.to contain_file('/usr/share/mcollective/plugins/mcollective/agent/r10k.ddl').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end

    it do
      is_expected.to contain_file('/usr/share/mcollective/plugins/mcollective/agent/r10k.rb').with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => '0',
        'mode'     => '0644'
      )
    end
  end
end
