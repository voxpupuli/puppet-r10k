require 'spec_helper'
describe 'r10k::install::bundle' , :type => 'class' do
  context "Puppet Enterprise on a RedHat 5 OS installing with bundle & no params" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :path                   => '/usr/bin/usr/local/bin:/usr/sbin'
      }
    end
    it { should contain_package("r10k-bundle").with(
        'ensure'     => 'installed',
        'name'       => 'bundler',
        'provider'   => 'gem'
      )
    }
    it { should contain_vcsrepo("r10k-r10k-github").with(
        'ensure'   => 'latest',
        'provider' => 'git',
        'path'     => '/tmp/r10k',
        'source'   => 'https://github.com/adrienthebo/r10k.git',
        'revision' => 'master'
      )
    }
    it { should contain_exec("r10k-install-via-bundle").with(
        'command' => 'bundle && bundle install --path /opt/ --binstubs /usr/local/bin/',
        'cwd'     => '/tmp/r10k',
        'unless'  => 'bundle list | grep -q " r10k "',
        'path'    => '/usr/bin/usr/local/bin:/usr/sbin'
      )
    }
  end
  context "Puppet Enterprise on a RedHat 5 OS installing with bundle & custom params" do
    let :params do
      {
        :revision => 'new_feature',
        :source   => 'https://github.com/acidprime/r10k-fork.git'
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true',
        :path                   => '/usr/bin/usr/local/bin:/usr/sbin'
      }
    end
    it { should contain_package("r10k-bundle").with(
        'ensure'     => 'installed',
        'name'       => 'bundler',
        'provider'   => 'gem'
      )
    }
    it { should contain_vcsrepo("r10k-r10k-github").with(
        'ensure'   => 'latest',
        'provider' => 'git',
        'path'     => '/tmp/r10k',
        'source'   => 'https://github.com/acidprime/r10k-fork.git',
        'revision' => 'new_feature'
      )
    }
    it { should contain_exec("r10k-install-via-bundle").with(
        'command' => 'bundle && bundle install --path /opt/ --binstubs /usr/local/bin/',
        'cwd'     => '/tmp/r10k',
        'unless'  => 'bundle list | grep -q " r10k "',
        'path'    => '/usr/bin/usr/local/bin:/usr/sbin'
      )
    }
  end
end
