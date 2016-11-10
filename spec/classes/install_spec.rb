require 'spec_helper'
describe 'r10k::install', type: 'class' do
  context 'on a RedHat 5 OS installing 1.1.0 with gem provider' do
    let(:params) do
      {
        install_options: '',
        keywords: '',
        manage_ruby_dependency: 'declare',
        package_name: 'r10k',
        provider: 'gem',
        version: '1.1.0',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.to contain_class('git') }

    # New versions of this gem do not require these packages
    it { is_expected.not_to contain_class('make') }
    it { is_expected.not_to contain_package('gcc') }

    it do
      is_expected.to contain_class('r10k::install::gem').with(
        'version' => '1.1.0'
      )
    end
    it do
      is_expected.to contain_package('r10k').with(
        'ensure'   => '1.1.0',
        'provider' => 'gem'
      )
    end
  end
  context 'on a RedHat 5 OS installing 0.0.9 with gem provider' do
    let(:params) do
      {
        install_options: '',
        keywords: '',
        manage_ruby_dependency: 'declare',
        package_name: 'r10k',
        provider: 'gem',
        version: '0.0.9',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystem: 'Centos',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.to contain_class('git') }

    # On older versions of r10k we need gcc & make
    it { is_expected.to contain_class('gcc') }
    it { is_expected.to contain_class('make') }

    it do
      is_expected.to contain_class('r10k::install::gem').with(
        'version' => '0.0.9'
      )
    end
    it do
      is_expected.to contain_package('r10k').with(
        'ensure'   => '0.0.9',
        'provider' => 'gem'
      )
    end
  end
  context 'on a RedHat 5 OS installing 1.1.0 with pe_gem provider' do
    let(:params) do
      {
        package_name: 'r10k',
        version: '1.1.0',
        provider: 'pe_gem',
        keywords: '',
        manage_ruby_dependency: 'declare',
        install_options: '',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.to contain_class('git') }
    it { is_expected.to contain_class('r10k::install::pe_gem') }
    it do
      is_expected.to contain_package('r10k').with(
        'ensure'   => '1.1.0',
        'provider' => 'pe_gem'
      )
    end
  end
  context 'on a RedHat 5 OS installing 1.1.0 with bundle provider' do
    let(:params) do
      {
        package_name: 'r10k',
        version: '1.1.0',
        provider: 'bundle',
        manage_ruby_dependency: 'declare',
        keywords: '',
        install_options: '',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.to contain_class('git') }
    it { is_expected.to contain_class('r10k::install::bundle') }
    it { is_expected.not_to contain_package('r10k') }
  end
  context 'on a RedHat 5 OS installing latest with yum provider' do
    let(:params) do
      {
        install_options: '',
        keywords: '',
        manage_ruby_dependency: 'declare',
        package_name: 'rubygem-r10k',
        provider: 'yum',
        version: 'latest',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.not_to contain_class('git') }
    it { is_expected.to contain_package('rubygem-r10k') }
  end
  context 'on a SLES 11.3 OS installing latest with zypper provider' do
    let(:params) do
      {
        install_options: '',
        keywords: '',
        manage_ruby_dependency: 'declare',
        package_name: 'r10k',
        provider: 'zypper',
        version: 'latest',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'Suse',
        operatingsystemrelease: '11.3'
      }
    end
    it { is_expected.not_to contain_class('git') }
    it { is_expected.to contain_package('r10k') }
  end
  context 'on a Gentoo OS installing 1.1.0 with portage provider' do
    let(:params) do
      {
        install_options: '',
        keywords: ['~amd64', '~x86'],
        manage_ruby_dependency: 'declare',
        package_name: 'app-admin/r10k',
        provider: 'portage',
        version: '1.1.0',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'Gentoo',
        operatingsystemrelease: '2.1'
      }
    end
    it { is_expected.not_to contain_class('git') }
    it do
      is_expected.to contain_class('r10k::install::portage').with(
        package_name: 'app-admin/r10k',
        keywords: ['~amd64', '~x86'],
        version: '1.1.0'
      )
    end
    it do
      is_expected.to contain_package_keywords('dev-ruby/cri').with(
        keywords: ['~amd64', '~x86'],
        target: 'puppet'
      )
    end
    it do
      is_expected.to contain_portage__package('app-admin/r10k').with(
        keywords: ['~amd64', '~x86'],
        ensure: '1.1.0',
        target: 'puppet'
      )
    end
    it { is_expected.to contain_package('app-admin/r10k') }
    it { is_expected.not_to contain_package('r10k') }
  end
  context 'Puppet Enterprise 3.8.x on a RedHat 5 installing via pe_gem' do
    let(:params) do
      {
        manage_ruby_dependency: 'declare',
        install_options: '',
        package_name: 'r10k',
        provider: 'pe_gem',
        version: '1.1.0',
        keywords: '',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'CentOS',
        is_pe: true,
        pe_version: '3.8.1',
        puppetversion: '3.8.1 (Puppet Enterprise 3.8.1)'
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it do
      is_expected.not_to contain_package('r10k').with(
        ensure: '1.1.0',
        provider: 'pe_gem'
      )
    end

    it do
      is_expected.not_to contain_file('/usr/bin/r10k').with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    end
  end
  context 'Puppet Enterprise 3.8.x on a RedHat 5 installing via pe_gem not a master' do
    let(:params) do
      {
        manage_ruby_dependency: 'declare',
        install_options: '',
        package_name: 'r10k',
        provider: 'pe_gem',
        version: '1.1.0',
        keywords: '',
        puppet_master: false
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos',
        is_pe: true,
        pe_version: '3.8.1'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.1.0',
        provider: 'pe_gem'
      )
    end
    it do
      is_expected.to contain_file('/usr/bin/r10k').with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    end
  end
  context 'Puppet Enterprise 3.7.x on a RedHat 5 installing via pe_gem' do
    let(:params) do
      {
        manage_ruby_dependency: 'declare',
        install_options: '',
        package_name: 'r10k',
        provider: 'pe_gem',
        version: '1.1.0',
        keywords: '',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos',
        is_pe: '',
        pe_version: '3.7.0',
        puppetversion: '3.7.0 (Puppet Enterprise 3.7.0)'
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.1.0',
        provider: 'pe_gem'
      )
    end
    it do
      is_expected.to contain_file('/usr/bin/r10k').with(
        'ensure'  => 'link',
        'target'  => '/opt/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    end
  end
  context 'Puppet Enterprise 3.7.x on a RedHat 5 installing via pe_gem with empty install_options' do
    let(:params) do
      {
        manage_ruby_dependency: 'BOGON',
        package_name: 'r10k',
        provider: 'pe_gem',
        version: '1.5.0',
        keywords: '',
        install_options: [],
        puppet_master: true
      }
    end
    let(:facts) do
      {
        manage_ruby_dependency: 'BOGON',
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos',
        is_pe: '',
        pe_version: '3.7.0'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.5.0',
        provider: 'pe_gem',
        install_options: ['--no-ri', '--no-rdoc']
      )
    end
  end
  context 'On a RedHat 5 installing via gem with empty install_options' do
    let(:params) do
      {
        manage_ruby_dependency: 'include',
        package_name: 'r10k',
        provider: 'gem',
        version: '1.5.0',
        keywords: '',
        install_options: [],
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.5.0',
        provider: 'gem',
        install_options: ['--no-ri', '--no-rdoc']
      )
    end
  end
  context 'On a RedHat 5 installing via gem with populated install_options' do
    let(:params) do
      {
        manage_ruby_dependency: 'include',
        package_name: 'r10k',
        provider: 'gem',
        version: '1.5.0',
        keywords: '',
        install_options: ['BOGON'],
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.5.0',
        provider: 'gem',
        install_options: ['BOGON']
      )
    end
  end
  context 'On a RedHat 5 installing via yum with populated install_options' do
    let(:params) do
      {
        manage_ruby_dependency: 'include',
        package_name: 'r10k',
        provider: 'yum',
        version: '1.5.0',
        keywords: '',
        install_options: ['BOGON'],
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.5.0',
        provider: 'yum',
        install_options: ['BOGON']
      )
    end
  end
  context 'On OpenBSD 5.7 installing via packages' do
    let(:params) do
      {
        install_options: '',
        keywords: '',
        manage_ruby_dependency: 'declare',
        package_name: 'ruby21-r10k',
        provider: 'openbsd',
        version: 'latest',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'OpenBSD',
        kernelversion: '5.7'
      }
    end
    it { is_expected.not_to contain_class('git') }
    it { is_expected.to contain_package('ruby21-r10k') }
  end
  context 'On OpenBSD 5.8 installing via packages' do
    let(:params) do
      {
        install_options: '',
        keywords: '',
        manage_ruby_dependency: 'declare',
        package_name: 'ruby22-r10k',
        provider: 'openbsd',
        version: 'latest',
        puppet_master: true
      }
    end
    let(:facts) do
      {
        osfamily: 'OpenBSD',
        kernelversion: '5.8'
      }
    end
    it { is_expected.not_to contain_class('git') }
    it { is_expected.to contain_package('ruby22-r10k') }
  end
  context 'on a RedHat 6 OS installing 1.5.1 with puppet_gem provider' do
    let(:params) do
      {
        package_name: 'r10k',
        version: '1.5.1',
        provider: 'puppet_gem',
        keywords: '',
        manage_ruby_dependency: 'declare',
        install_options: ''
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6'
      }
    end
    it { is_expected.to contain_class('git') }
    it { is_expected.to contain_class('r10k::install::puppet_gem') }
    it do
      is_expected.to contain_package('r10k').with(
        'ensure'   => '1.5.1',
        'provider' => 'puppet_gem'
      )
    end
  end
  context 'Puppet FOSS 4.2.x on a RedHat 6 installing via puppet_gem' do
    let(:params) do
      {
        manage_ruby_dependency: 'declare',
        install_options: '',
        package_name: 'r10k',
        provider: 'puppet_gem',
        version: '1.5.1',
        keywords: ''
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem: 'Centos',
        is_pe: false,
        puppetversion: '4.2.1'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.5.1',
        provider: 'puppet_gem'
      )
    end

    it do
      is_expected.to contain_file('/usr/bin/r10k').with(
        'ensure'  => 'link',
        'target'  => '/opt/puppetlabs/puppet/bin/r10k',
        'require' => 'Package[r10k]'
      )
    end
  end
  context 'Puppet FOSS 4.2.x on a RedHat 6 installing via puppet_gem with empty install_options' do
    let(:params) do
      {
        manage_ruby_dependency: 'BOGON',
        package_name: 'r10k',
        provider: 'puppet_gem',
        version: '1.5.1',
        keywords: '',
        install_options: []
      }
    end
    let(:facts) do
      {
        manage_ruby_dependency: 'BOGON',
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem: 'Centos',
        is_pe: '',
        puppet_version: '4.2.1'
      }
    end
    it do
      is_expected.to contain_package('r10k').with(
        ensure: '1.5.1',
        provider: 'puppet_gem',
        install_options: ['--no-ri', '--no-rdoc']
      )
    end
  end
end
