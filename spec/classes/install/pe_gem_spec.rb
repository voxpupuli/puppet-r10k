require 'spec_helper'
describe 'r10k::install::pe_gem' , :type => 'class' do
  context "on a RedHat 5 OS installing 1.1.0 via pe_gem for Puppet Enterprise" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '2.7.19',
        :operatingsystemrelease => '5',
        :is_pe                  => 'true'
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
