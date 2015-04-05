require 'spec_helper'
describe 'r10k::webhook' , :type => 'class' do
  context "Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :pe_version             => '3.7.0'
      }
    end
    it { should contain_package("rack").with(
        'ensure'   => 'present',
      )
    }
    it { should contain_file("peadmin-cert.pem").with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        'ensure'  => 'file',
        'owner'   => 'peadmin',
        'group'   => 'peadmin',
        'mode'    => '0644',
      )
    }
  end
  context "Puppet Enterprise 3.7.x on a RedHat 5 installing webhook" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => '',
        :pe_version             => '3.7.1'
      }
    end
    it { should contain_package("rack").with(
        'ensure'   => 'present',
      )
    }
    it { should contain_file("peadmin-cert.pem").with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        'ensure'  => 'file',
        'owner'   => 'peadmin',
        'group'   => 'peadmin',
        'mode'    => '0644',
      )
    }
  end
  context "Puppet Enterprise 3.3.x on a RedHat 5 installing webhook" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => '',
        :pe_version             => '3.3.1'
      }
    end
    it { should_not contain_package("rack").with(
        'ensure'   => 'present',
      )
    }
    it { should_not contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
      )
    }
  end
end
