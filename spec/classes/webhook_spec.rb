require 'spec_helper'
describe 'r10k::webhook' , :type => 'class' do
  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook' do
    let :params do
      {
        :use_mcollective => true,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'CentOS',
        :is_pe                  => true,
        :pe_version             => '3.7.0',
        :puppetversion          => '3.7.0 (Puppet Enterprise 3.7.0)',
      }
    end

    it { should contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'pe_gem'
      )
    }
    it { should contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        'ensure'  => 'file',
        'owner'   => 'peadmin',
        'group'   => 'peadmin',
        'mode'    => '0644'
      )
    }
  end

  context 'Puppet Enterprise 2015.3.1 on a RedHat 6 Removing Webhook' do
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
        :is_pe                  => 'true',
        :pe_server_build        => '2015.3.1'
      }
    end
    it { should contain_file('/var/log/webhook/access.log').with(
        'ensure' => 'absent',
        'path'   => '/var/log/webhook/access.log'
      )
    }
    it { should contain_file('/var/log/webhook').with(
        'ensure' => 'absent',
        'path'   => '/var/log/webhook'
      )
    }
    it { should contain_file('/var/run/webhook').with(
        'ensure' => 'absent',
        'path'   => '/var/run/webhook'
      )
    }
    it { should contain_file('webhook_init_script').with(
        'ensure' => 'absent',
        'path'   => '/etc/init.d/webhook'
      )
    }
  end

  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook no mco' do
    let :params do
      {
        :use_mcollective => false,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :pe_version             => '3.7.0'
      }
    end
    it { should contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'pe_gem'
      )
    }

    it { should contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'pe_gem'
      )
    }
    it { should_not contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    }
  end
  context 'Puppet FOSS 4.2.1 a RedHat 6 installing webhook' do
    let :params do
      {
        :use_mcollective => true,
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :operatingsystem        => 'Centos',
        :puppetversion          => '4.2.1'
      }
    end
    it { should contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    }

    it { should contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'puppet_gem'
      )
    }
    it { should_not contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    }
  end
  context 'Puppet FOSS 4.2.x on a RedHat 6 installing webhook' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'false',
        :puppetversion          => '4.2.1'
      }
    end
    it { should contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    }
  end
  context 'Puppet FOSS 3.7.1  on a RedHat 5 installing webhook' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :puppetversion          => '3.7.1'
      }
    end

    it { should contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'gem'
      )
    }

    it { should contain_package('webrick').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    }

    it { should contain_package('rack').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    }

    it { should contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    }

    it { should contain_package('json').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    }

    it { should_not contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    }
  end
  context 'Puppet FOSS 3.2.1 on a RedHat 5 installing webhook' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :puppetversion          => '3.2.1'
      }
    end
    it { should_not contain_package('rack').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    }
    it { should_not contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    }
  end
  context 'Enterprise Linux 7 host with systemd' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '7',
        :operatingsystem           => 'Centos',
        :is_pe                     => 'true',
        :pe_version                => '3.7.0'
      }
    end
    it { should contain_file('webhook_init_script').with(
         :path => '/usr/lib/systemd/system/webhook.service',
         :content => /\[Unit\]/
      )
    }
  end
  context 'Non Enteprise Linux 7 host' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '6',
        :operatingsystem           => 'Centos',
        :is_pe                     => 'true',
        :pe_version                => '3.7.0'
      }
    end
    it { should contain_file('webhook_init_script').with(
         :path => '/etc/init.d/webhook',
         :content => /#!\/bin\/bash/
      )
    }
  end
end
