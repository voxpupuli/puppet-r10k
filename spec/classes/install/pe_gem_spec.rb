require 'spec_helper'
describe 'r10k::install::pe_gem' , :type => 'class' do
  context "on a RedHat 5 OS installing 1.1.0 via pe_gem for Puppet Enterprise 3.7.1" do
    let :params do
      {
        :puppet_master => true,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '3.7.1',
        :operatingsystemrelease => '5',
        :is_pe                  => 'true',
        :pe_version             => '3.7.1'
      }
    end
    it { should contain_file("/usr/bin/r10k").with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    }
  end
  context "on a RedHat 5 OS installing 1.1.0 via pe_gem for Puppet Enterprise 3.8.1" do
    let :params do
      {
        :puppet_master => true,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '3.8.1',
        :operatingsystemrelease => '5',
        :is_pe                  => 'true',
        :pe_version             => '3.8.1'
      }
    end
    it { should_not contain_file("/usr/bin/r10k").with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    }
  end
  context "on a RedHat 5 OS installing 1.1.0 via pe_gem for Puppet Enterprise 3.8.1 not puppet master" do
    let :params do
      {
        :puppet_master => false,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '3.8.1',
        :operatingsystemrelease => '5',
        :is_pe                  => 'true',
        :pe_version             => '3.8.1'
      }
    end
    it { should contain_file("/usr/bin/r10k").with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    }
  end
end
