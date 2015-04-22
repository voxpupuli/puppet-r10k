require 'spec_helper'
describe 'r10k::webhook' , :type => 'class' do
  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook' do
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
    it { should contain_file('peadmin-cert.pem').with(
        'path'   => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        'ensure'  => 'file',
        'owner'   => 'peadmin',
        'group'   => 'peadmin',
        'mode'    => '0644'
      )
    }
  end
  context 'Puppet 2.7.0 FOSS on a RedHat 5 installing webhook' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :puppetversion          => '2.7.0'
      }
    end

    it { should contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'gem'
      )
    }

    it { should_not contain_package('rack').with(
        'ensure'   => 'installed'
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
end
