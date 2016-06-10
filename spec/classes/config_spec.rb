require 'spec_helper'
describe 'r10k::config' , :type => 'class' do
  context "Puppet Enterprise on a RedHat 5 OS configuring r10k with defaults" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => false,
        :root_user         => 'root',
        :root_group        => 'root',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("r10k.yaml").with(
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'path'   => '/etc/r10k.yaml'
      )
    }
    it { should_not contain_ini_setting("R10k Modulepath") }
  end
  context "On OpenBSD configuring r10k with defaults" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => false,
        :root_user         => 'root',
        :root_group        => 'wheel',
      }
    end
    let :facts do
      {
        :osfamily               => 'OpenBSD',
        :is_pe                  => 'false'
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("r10k.yaml").with(
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'wheel',
        'mode'   => '0644',
        'path'   => '/etc/r10k.yaml'
      )
    }
    it { should_not contain_ini_setting("R10k Modulepath") }
  end
  context "Puppet Enterprise on a RedHat 5 OS configuring r10k and managing the modulepath" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => true,
        :root_user         => 'root',
        :root_group        => 'root',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("r10k.yaml").with(
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'path'   => '/etc/r10k.yaml'
      )
    }
    it { should contain_ini_setting("R10k Modulepath").with(
      'ensure'  => 'present',
      'path'    => '/etc/puppetlabs/puppet/puppet.conf',
      'section' => 'main',
      'setting' => 'modulepath'
      )
    }
  end
  context "On OpenBSD configuring r10k and managing the modulepath" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => true,
        :root_user         => 'root',
        :root_group        => 'wheel',
      }
    end
    let :facts do
      {
        :osfamily               => 'OpenBSD',
        :is_pe                  => 'false',
      }
    end
    it { should contain_class("r10k::params") }
    it { should contain_file("r10k.yaml").with(
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'wheel',
        'mode'   => '0644',
        'path'   => '/etc/r10k.yaml'
      )
    }
    it { should contain_ini_setting("R10k Modulepath").with(
      'ensure'  => 'present',
      'path'    => '/etc/puppet/puppet.conf',
      'section' => 'main',
      'setting' => 'modulepath'
      )
    }
  end
  context "Puppet Enterprise on a RedHat 5 OS configuring r10k and forgetting to pass a hash" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => true,
        :sources           => 'i-am-not-a-hash',
        :root_user         => 'root',
        :root_group        => 'root',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
      }
    end
    it 'should fail when sources is not a hash' do
      expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
    end
  end
  context "On OpenBSD configuring r10k and forgetting to pass a hash" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => true,
        :sources           => 'i-am-not-a-hash',
        :root_user         => 'root',
        :root_group        => 'wheel',
      }
    end
    let :facts do
      {
        :osfamily               => 'OpenBSD',
        :is_pe                  => 'false',
      }
    end
    it 'should fail when sources is not a hash' do
      expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
    end
  end
  context "Puppet Enterprise on a RedHat 5 OS configuring r10k and forgetting to pass a bool" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => 'false-i-am-not-a-bool',
        :root_user         => 'root',
        :root_group        => 'root',
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
      }
    end
    it 'should fail when sources is not a boolean' do
      expect { catalogue }.to raise_error(Puppet::Error, /is not a bool/)
    end
  end
  context "On OpenBSD configuring r10k and forgetting to pass a bool" do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => 'false-i-am-not-a-bool',
        :root_user         => 'root',
        :root_group        => 'wheel',
      }
    end
    let :facts do
      {
        :osfamily               => 'OpenBSD',
        :is_pe                  => 'false',
      }
    end
    it 'should fail when sources is not a boolean' do
      expect { catalogue }.to raise_error(Puppet::Error, /is not a bool/)
    end
  end

  describe 'with manage_configfile_symlink' do
    ['true',true].each do |value|
      context "On RedHat with PE set to #{value} with configfile specified and configfile_symlink left at the default value" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'root',
          }
        end
        let :facts do
          {
            :osfamily               => 'RedHat',
            :operatingsystemrelease => '5',
            :operatingsystem        => 'Centos',
            :is_pe                  => 'true',
          }
        end

        it { should contain_file('symlink_r10k.yaml').with({
            'ensure' => 'link',
            'path'   => '/etc/r10k.yaml',
            'target' => '/etc/puppet/r10k.yaml',
          })
        }
      end

      context "On OpenBSD with Puppet FOSS set to #{value} with configfile specified and configfile_symlink left at the default value" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'wheel',
          }
        end
        let :facts do
          {
            :osfamily               => 'OpenBSD',
            :is_pe                  => 'false',
          }
        end

        it { should contain_file('symlink_r10k.yaml').with({
            'ensure' => 'link',
            'path'   => '/etc/r10k.yaml',
            'target' => '/etc/puppet/r10k.yaml',
          })
        }
      end

      context "On RedHat with PE set to #{value} with configfile specified and configfile_symlink specified" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :configfile_symlink        => '/tmp/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'root',
          }
        end
        let :facts do
          {
            :osfamily               => 'RedHat',
            :operatingsystemrelease => '5',
            :operatingsystem        => 'Centos',
            :is_pe                  => 'true',
          }
        end

        it { should contain_file('symlink_r10k.yaml').with({
            'ensure' => 'link',
            'path'   => '/tmp/r10k.yaml',
            'target' => '/etc/puppet/r10k.yaml',
          })
        }
      end

      context "On OpenBSD with Puppet FOSS set to #{value} with configfile specified and configfile_symlink specified" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :configfile_symlink        => '/tmp/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'wheel',
          }
        end
        let :facts do
          {
            :osfamily               => 'OpenBSD',
            :is_pe                  => 'false',
          }
        end

        it { should contain_file('symlink_r10k.yaml').with({
            'ensure' => 'link',
            'path'   => '/tmp/r10k.yaml',
            'target' => '/etc/puppet/r10k.yaml',
          })
        }
      end

      context "On RedHat with PE set to #{value} without configfile_symlink specified" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'root',
          }
        end
        let :facts do
          {
            :osfamily               => 'RedHat',
            :operatingsystemrelease => '5',
            :operatingsystem        => 'Centos',
            :is_pe                  => 'true',
          }
        end
        it { should contain_file('symlink_r10k.yaml').with({
            'ensure' => 'link',
            'path'   => '/etc/r10k.yaml',
            'target' => '/etc/puppet/r10k.yaml',
          })
        }
      end

      context "On OpenBSD with Puppet FOSS set to #{value} without configfile_symlink specified" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'wheel',
          }
        end
        let :facts do
          {
            :osfamily               => 'OpenBSD',
            :is_pe                  => 'false',
          }
        end
        it { should contain_file('symlink_r10k.yaml').with({
            'ensure' => 'link',
            'path'   => '/etc/r10k.yaml',
            'target' => '/etc/puppet/r10k.yaml',
          })
        }
      end
    end

    ['false',false].each do |value|
      context "On RedHat with PE set to #{value}" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'root',
          }
        end
        let :facts do
          {
            :osfamily               => 'RedHat',
            :operatingsystemrelease => '5',
            :operatingsystem        => 'Centos',
            :is_pe                  => 'true',
          }
        end

        it { should_not contain_file('symlink_r10k.yaml') }
      end
      context "On OpenBSD with Puppet FOSS set to #{value}" do
        let :params do
          {
            :manage_configfile_symlink => value,
            :configfile                => '/etc/puppet/r10k.yaml',
            :cachedir                  => '/var/cache/r10k',
            :manage_modulepath         => false,
            :root_user                 => 'root',
            :root_group                => 'wheel',
          }
        end
        let :facts do
          {
            :osfamily               => 'OpenBSD',
            :is_pe                  => 'false',
          }
        end

        it { should_not contain_file('symlink_r10k.yaml') }
      end
    end

    context 'On RedHat with PE set to a non-boolean value' do
      let :params do
        {
          :manage_configfile_symlink => 'invalid',
          :configfile                => '/etc/r10k.yaml',
          :cachedir                  => '/var/cache/r10k',
          :manage_modulepath         => false,
          :root_user                 => 'root',
          :root_group                => 'root',
        }
      end
      let :facts do
        {
          :osfamily               => 'RedHat',
          :operatingsystemrelease => '5',
          :operatingsystem        => 'Centos',
          :is_pe                  => 'true',
        }
      end

      it 'should fail' do
        expect { catalogue }.to raise_error(Puppet::Error)
      end
    end
    context 'On OpenBSD with Puppet FOSS set to a non-boolean value' do
      let :params do
        {
          :manage_configfile_symlink => 'invalid',
          :configfile                => '/etc/r10k.yaml',
          :cachedir                  => '/var/cache/r10k',
          :manage_modulepath         => false,
          :root_user                 => 'root',
          :root_group                => 'wheel',
        }
      end
      let :facts do
        {
          :osfamily               => 'OpenBSD',
          :is_pe                  => 'false',
        }
      end

      it 'should fail' do
        expect { catalogue }.to raise_error(Puppet::Error)
      end
    end
  end

  describe 'with configfile_symlink specified as a non fully qualified path' do
    context 'On RedHat with PE' do
      let :params do
        {
          :manage_configfile_symlink => true,
          :configfile                => '/etc/r10k.yaml',
          :configfile_symlink        => 'invalid/path',
          :cachedir                  => '/var/cache/r10k',
          :manage_modulepath         => false,
          :root_user                 => 'root',
          :root_group                => 'root',
        }
      end
      let :facts do
        {
          :osfamily               => 'RedHat',
          :operatingsystemrelease => '5',
          :operatingsystem        => 'Centos',
          :is_pe                  => 'true',
        }
      end

      it 'should fail' do
        expect { catalogue }.to raise_error(Puppet::Error)
      end
    end
    context 'On OpenBSD with Puppet FOSS' do
      let :params do
        {
          :manage_configfile_symlink => true,
          :configfile                => '/etc/r10k.yaml',
          :configfile_symlink        => 'invalid/path',
          :cachedir                  => '/var/cache/r10k',
          :manage_modulepath         => false,
          :root_user                 => 'root',
          :root_group                => 'wheel',
        }
      end
      let :facts do
        {
          :osfamily               => 'OpenBSD',
          :is_pe                  => 'false',
        }
      end

      it 'should fail' do
        expect { catalogue }.to raise_error(Puppet::Error)
      end
    end
  end

  context 'Managing r10k with rugged turned on via git_settings' do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => false,
        :git_settings      => {'provider' => 'rugged','private_key' => '/root/.ssh/id_dsa'},
        :root_user         => 'root',
        :root_group        => 'root',
      }
    end
    it { should contain_file('r10k.yaml').with_content(%r{git:\n.*private_key: /root/\.ssh/id_dsa\n.*provider: rugged\n}) }
  end

  context 'Manage forge settings of r10k via forge_settings' do
    let :params do
      {
        :configfile        => '/etc/r10k.yaml',
        :cachedir          => '/var/cache/r10k',
        :manage_modulepath => false,
        :forge_settings    => { 'proxy' => 'https://proxy.example.com:3128', 'baseurl' => 'https://forgeapi.puppetlabs.com' },
        :root_user         => 'root',
        :root_group        => 'root',
      }
    end
    it { should contain_file('r10k.yaml').with_content(%r{forge:\n.*baseurl: https:\/\/forgeapi\.puppetlabs\.com\n.*proxy: https:\/\/proxy\.example\.com:3128\n}) }
  end

  describe 'with optional parameter postrun specified' do
    context 'with array of system call "/usr/bin/curl -F deploy=done http://my-app.site/endpoint"' do
      let :params do
        {
          :configfile        => '/etc/r10k.yaml',
          :cachedir          => '/var/cache/r10k',
          :manage_modulepath => false,
          :postrun           => ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint'],
          :root_user         => 'root',
          :root_group        => 'root',
        }
      end
      it { should contain_file('r10k.yaml').with_content(%r{^.*:postrun: \[\"/usr/bin/curl\", \"-F\", \"deploy=done\", \"http://my-app\.site/endpoint\"\]\n.*$}) }
    end

    context 'with postrun left undefined' do
      let :params do
        {
          :configfile        => '/etc/r10k.yaml',
          :cachedir          => '/var/cache/r10k',
          :manage_modulepath => false,
          :root_user         => 'root',
          :root_group        => 'root',
        }
      end
      it { should contain_file('r10k.yaml').without_content(/^:postrun: .*$/) }
    end

    ['string', true, 1, 1.0, {}].each do |value|
      context "with #{value}" do
        let :params do
          {
            :configfile        => '/etc/r10k.yaml',
            :cachedir          => '/var/cache/r10k',
            :manage_modulepath => false,
            :postrun           => value,
            :root_user         => 'root',
            :root_group        => 'root',
          }
        end

        it 'should fail when sources is not an Array' do
          expect { catalogue }.to raise_error(Puppet::Error, /is not an Array/)
        end
      end
    end
  end
end
