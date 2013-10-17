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
    it { should include_class("r10k::params") }
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/application/r10k.rb").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[pe-mcollective]'
      )
    }
    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[pe-mcollective]'
      )
    }

    it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/r10k.rb").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[pe-mcollective]'
      )
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
    it { should include_class("r10k::params") }
    it { should contain_file("/usr/libexec/mcollective/mcollective/application/r10k.rb").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[mcollective]'
      )
    }
    it { should contain_file("/usr/libexec/mcollective/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[mcollective]'
      )
    }
                                                                                                
    it { should contain_file("/usr/libexec/mcollective/mcollective/agent/r10k.rb").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[mcollective]'
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
    it { should include_class("r10k::params") }
    it { should_not contain_file("/usr/libexec/mcollective/mcollective/application/r10k.rb") }

    it { should contain_file("/usr/share/mcollective/plugins/mcollective/application/r10k.rb").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[mcollective]'
      )
    }

    it { should contain_file("/usr/share/mcollective/plugins/mcollective/agent/r10k.ddl").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[mcollective]'
      )
    }

    it { should contain_file("/usr/share/mcollective/plugins/mcollective/agent/r10k.rb").with(
        'ensure'   => 'present',
        'owner'    => 'root',
        'group'    => 'root',
        'mode'     => '0644',
        'notify'   => 'Service[mcollective]'
      )
    }
  end
end
