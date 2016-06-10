require 'spec_helper'
describe 'r10k::mcollective' , :type => 'class' do
  context "Puppet Enterprise on a RedHat 5 OS installing mcollective agent & application" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/application/r10k.rb").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }

    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }

    it {
      should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb").
        with_content(/\"GIT_SSL_NO_VERIFY\" => \"0\"/)
    }

  end

  context "Puppet Enterprise on a RedHat 6 OS removing the mcollective agent & application" do
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
        :is_pe                  => 'true'
      }
    end
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/application/r10k.rb").with(
        'ensure'   => 'absent'
      )
    }
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'absent'
      )
    }

    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb").with(
        'ensure'   => 'absent'
      )
    }
  end

  context "Allows you to set git_ssl_no_verify for r10k file" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end

    let :params do
      {
        :git_ssl_no_verify => 1,
      }
    end

    it {
      should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb").
        with_content(/\"GIT_SSL_NO_VERIFY\" => \"1\"/)
    }

  end

    context "Allows you to set git_ssl_verify for r10k file (deprecated - to be removed in major bump)" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end

    let :params do
      {
        :git_ssl_no_verify => 1,
      }
    end

    it {
      should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb").
        with_content(/\"GIT_SSL_NO_VERIFY\" => \"1\"/)
    }

  end

  context "Puppet FOSS on a RedHat 5 OS installing mcollective agent & application" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => ''
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("/usr/libexec/mcollective/mcollective/application/r10k.rb").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }
    it { should contain_file("/usr/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }

    it { should contain_file("/usr/libexec/mcollective/mcollective/agent/r10k.rb").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }
  end
  context "Puppet FOSS on a Debian 6 OS installing mcollective agent & application" do
    let :facts do
      {
        :operatingsystemrelease => '6',
        :operatingsystem        => 'Ubuntu',
        :osfamily               => 'Debian',
        :is_pe                  => ''
      }
    end
    it { should contain_class("r10k::params") }
    it { should_not contain_file("/usr/libexec/mcollective/mcollective/application/r10k.rb") }

    it { should contain_file("/usr/share/mcollective/plugins/mcollective/application/r10k.rb").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }

    it { should contain_file("/usr/share/mcollective/plugins/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }

    it { should contain_file("/usr/share/mcollective/plugins/mcollective/agent/r10k.rb").with(
        'ensure'   => 'file',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644'
      )
    }
  end
end
