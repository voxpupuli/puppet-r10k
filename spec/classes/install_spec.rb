require 'spec_helper'
describe 'r10k::install' , :type => 'class' do
  context "on a RedHat 5 OS installing 1.1.0 with gem provider" do
    let :params do
      {
        :install_options        => '',
        :keywords               => '',
        :manage_ruby_dependency => 'declare',
        :package_name           => 'r10k',
        :provider               => 'gem',
        :version                => '1.1.0',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
      }
    end
    it { should contain_class("git") }

    # New versions of this gem do not require these packages
    it { should_not contain_class("make")}
    it { should_not contain_package("gcc")}

    it { should contain_class("r10k::install::gem").with(
       'version' => '1.1.0'
      )
    }
    it { should contain_package("r10k").with(
      'ensure'   => '1.1.0',
      'provider' => 'gem'
      )
    }
  end
  context "on a RedHat 5 OS installing 0.0.9 with gem provider" do
    let :params do
      {
        :install_options        => '',
        :keywords               => '',
        :manage_ruby_dependency => 'declare',
        :package_name           => 'r10k',
        :provider               => 'gem',
        :version                => '0.0.9',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystem        => 'Centos',
        :operatingsystemrelease => '5',
      }
    end
    it { should contain_class("git") }

    # On older versions of r10k we need gcc & make
    it { should contain_class("gcc") }
    it { should contain_class("make") }

    it { should contain_class("r10k::install::gem").with(
       'version' => '0.0.9'
      )
    }
    it { should contain_package("r10k").with(
      'ensure'   => '0.0.9',
      'provider' => 'gem'
      )
    }
  end
  context "on a RedHat 5 OS installing 1.1.0 with pe_gem provider" do
    let :params do
      {
        :package_name           => 'r10k',
        :version                => '1.1.0',
        :provider               => 'pe_gem',
        :keywords               => '',
        :manage_ruby_dependency => 'declare',
        :install_options        => '',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
      }
    end
    it { should contain_class("git") }
    it { should contain_class("r10k::install::pe_gem") }
    it { should contain_package("r10k").with(
      'ensure'   => '1.1.0',
      'provider' => 'pe_gem'
      )
    }
  end
  context "on a RedHat 5 OS installing 1.1.0 with bundle provider" do
    let :params do
      {
        :package_name           => 'r10k',
        :version                => '1.1.0',
        :provider               => 'bundle',
        :manage_ruby_dependency => 'declare',
        :keywords               => '',
        :install_options        => '',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
      }
    end
    it { should contain_class("git") }
    it { should contain_class("r10k::install::bundle") }
    it { should_not contain_package("r10k")}
  end
  context "on a RedHat 5 OS installing latest with yum provider" do
    let :params do
      {
        :install_options        => '',
        :keywords               => '',
        :manage_ruby_dependency => 'declare',
        :package_name           => 'rubygem-r10k',
        :provider               => 'yum',
        :version                => 'latest',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
      }
    end
    it { should_not contain_class("git") }
    it { should contain_package("rubygem-r10k")}
  end
  context "on a SLES 11.3 OS installing latest with zypper provider" do
    let :params do
      {
        :install_options        => '',
        :keywords               => '',
        :manage_ruby_dependency => 'declare',
        :package_name           => 'r10k',
        :provider               => 'zypper',
        :version                => 'latest',
      }
    end
    let :facts do
      {
        :osfamily               => 'SUSE',
        :operatingsystemrelease => '11.3',
      }
    end
    it { should_not contain_class("git") }
    it { should contain_package("r10k")}
  end
  context "on a Gentoo OS installing 1.1.0 with portage provider" do
    let :params do
      {
        :install_options        => '',
        :keywords               => ['~amd64', '~x86'],
        :manage_ruby_dependency => 'declare',
        :package_name           => 'app-admin/r10k',
        :provider               => 'portage',
        :version                => '1.1.0',
      }
    end
    let :facts do
      {
        :osfamily               => 'Gentoo',
        :operatingsystemrelease => '2.1',
      }
    end
    it { should_not contain_class("git") }
    it { should contain_class("r10k::install::portage").with(
        :package_name => 'app-admin/r10k',
        :keywords     => ['~amd64', '~x86'],
        :version      => '1.1.0'
      )
    }
    it { should contain_package_keywords("dev-ruby/cri").with(
        :keywords => ['~amd64', '~x86'],
        :target   => 'puppet'
      )
    }
    it { should contain_portage__package("app-admin/r10k").with(
        :keywords => ['~amd64', '~x86'],
        :ensure   => '1.1.0',
        :target   => 'puppet'
      )
    }
    it { should contain_package("app-admin/r10k")}
    it { should_not contain_package("r10k")}
  end
  context "Puppet Enterprise 3.8.x on a RedHat 5 installing via pe_gem" do
    let :params do
      {
        :manage_ruby_dependency => 'declare',
        :install_options        => '',
        :package_name           => 'r10k',
        :provider               => 'pe_gem',
        :version                => '1.1.0',
        :keywords               => '',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => '',
        :pe_version             => '3.8.1'
      }
    end
    it { should_not contain_package("r10k").with(
        :ensure     => '1.1.0',
        :provider   => 'pe_gem'
      )
    }

   it { should_not contain_file("/usr/bin/r10k").with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    }

  end
  context "Puppet Enterprise 3.7.x on a RedHat 5 installing via pe_gem" do
    let :params do
      {
        :manage_ruby_dependency => 'declare',
        :install_options        => '',
        :package_name           => 'r10k',
        :provider               => 'pe_gem',
        :version                => '1.1.0',
        :keywords               => '',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => '',
        :pe_version             => '3.7.0'
      }
    end
    it { should contain_package("r10k").with(
        :ensure     => '1.1.0',
        :provider   => 'pe_gem'
      )
    }
    it { should contain_file("/usr/bin/r10k").with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    }
  end
  context "Puppet Enterprise 3.7.x on a RedHat 5 installing via pe_gem with empty install_options" do
    let :params do
      {
        :manage_ruby_dependency => 'BOGON',
        :package_name           => 'r10k',
        :provider               => 'pe_gem',
        :version                => '1.5.0',
        :keywords               => '',
        :install_options        => [],
      }
    end
    let :facts do
      {
        :manage_ruby_dependency => 'BOGON',
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => '',
        :pe_version             => '3.7.0'
      }
    end
    it { should contain_package("r10k").with(
        :ensure     => '1.5.0',
        :provider   => 'pe_gem',
        :install_options => ['--no-ri', '--no-rdoc']
      )
    }
  end
  context "On a RedHat 5 installing via gem with empty install_options" do
    let :params do
      {
        :manage_ruby_dependency => 'include',
        :package_name           => 'r10k',
        :provider               => 'gem',
        :version                => '1.5.0',
        :keywords               => '',
        :install_options        => [],
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
      }
    end
    it { should contain_package("r10k").with(
        :ensure     => '1.5.0',
        :provider   => 'gem',
        :install_options => ['--no-ri', '--no-rdoc']
      )
    }
  end
  context "On a RedHat 5 installing via gem with populated install_options" do
    let :params do
      {
        :manage_ruby_dependency => 'include',
        :package_name           => 'r10k',
        :provider               => 'gem',
        :version                => '1.5.0',
        :keywords               => '',
        :install_options        => ['BOGON'],
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
      }
    end
    it { should contain_package("r10k").with(
        :ensure     => '1.5.0',
        :provider   => 'gem',
        :install_options => ['BOGON']
      )
    }
  end
  context "On a RedHat 5 installing via yum with populated install_options" do
    let :params do
      {
        :manage_ruby_dependency => 'include',
        :package_name           => 'r10k',
        :provider               => 'yum',
        :version                => '1.5.0',
        :keywords               => '',
        :install_options        => ['BOGON'],
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
      }
    end
    it { should contain_package("r10k").with(
        :ensure     => '1.5.0',
        :provider   => 'yum',
        :install_options => ['BOGON']
      )
    }
  end
end
