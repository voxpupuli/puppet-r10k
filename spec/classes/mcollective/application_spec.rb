require 'spec_helper'
describe 'r10k::mcollective::application' , :type => 'class' do
  context "Puppet Enterprise on a RedHat 5 OS installing mcollective application" do
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
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => '0',
        'mode'   => '0644',
        'source' => 'puppet:///modules/r10k/application/r10k.rb'
      )
    }
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => '0',
        'mode'   => '0644',
        'source' => 'puppet:///modules/r10k/agent/r10k.ddl'
      )
    }

  context "Puppet FOSS on a RedHat 5 OS installing mcollective application" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => false
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("/usr/libexec/mcollective/mcollective/application/r10k.rb").with(
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => '0',
        'mode'   => '0644',
        'source' => 'puppet:///modules/r10k/application/r10k.rb'
      )
    }
    it { should contain_file("/usr/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => '0',
        'mode'   => '0644',
        'source' => 'puppet:///modules/r10k/agent/r10k.ddl'
      )
    }
    end
  end
end
