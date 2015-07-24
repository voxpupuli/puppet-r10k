require 'spec_helper'
describe 'r10k::install::puppet_gem' , :type => 'class' do
  context "on a RedHat 6 OS installing 1.5.1 via puppet_gem for Puppet FOSS 4.x" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '4.2.1',
        :operatingsystemrelease => '6',
        :is_pe                  => 'false'
      }
    end
    it { should contain_file("/usr/bin/r10k").with(
        'ensure'  => 'link',
        'target'  => '/opt/puppetlabs/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    }
  end
end
