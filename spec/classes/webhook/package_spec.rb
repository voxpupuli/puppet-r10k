require 'spec_helper'
describe 'r10k::webhook::package', type: 'class' do
  context 'Puppet Enterprise 2015.x on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true',
        puppetversion: '4.2.0'
      }
    end
    let(:params) do
      {
        is_pe_server: true
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    end
    it do
      is_expected.to contain_package('rack').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('webrick').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('json').with(
        'ensure' => 'installed'
      )
    end
  end
  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true',
        puppetversion: '3.7.0'
      }
    end
    let(:params) do
      {
        is_pe_server: true
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'pe_gem'
      )
    end
    it do
      is_expected.to contain_package('rack').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('webrick').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('json').with(
        'ensure' => 'installed'
      )
    end
  end
  context 'Puppet Enterprise 3.6.0 on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        puppetversion: '3.6.0'
      }
    end
    let(:params) do
      {
        is_pe_server: true
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'pe_gem'
      )
    end
    it do
      is_expected.not_to contain_package('rack').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('webrick').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('json').with(
        'ensure' => 'installed'
      )
    end
  end
  context 'Puppet FOSS 2015.x on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true',
        puppetversion: '4.2.0'
      }
    end
    it do
      is_expected.not_to contain_package('webrick').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    end
    it do
      is_expected.not_to contain_package('json').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem',
        'before' => 'Service[webhook]'
      )
    end
    it do
      is_expected.to contain_package('rack').with(
        'ensure' => 'installed'
      )
    end
    it do
      is_expected.not_to contain_package('webrick').with(
        'ensure' => 'installed'
      )
    end
  end
  context 'Puppet FOSS 3.6.0 on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        puppetversion: '3.6.0'
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end
    it do
      is_expected.to contain_package('webrick').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end
    it do
      is_expected.to contain_package('json').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end
    it do
      is_expected.not_to contain_package('rack').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end
  end
end
