require 'spec_helper'
describe 'r10k::webhook', type: 'class' do
  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook' do
    let(:params) do
      {
        use_mcollective: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'CentOS',
        is_pe: true,
        pe_version: '3.7.0',
        puppetversion: '3.7.0 (Puppet Enterprise 3.7.0)'
      }
    end

    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'pe_gem'
      )
    end
    it do
      is_expected.to contain_file('peadmin-cert.pem').with(
        'path' => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        'ensure'  => 'file',
        'owner'   => 'peadmin',
        'group'   => 'peadmin',
        'mode'    => '0644'
      )
    end
  end

  context 'Puppet Enterprise 2015.3.1 on a RedHat 6 Removing Webhook' do
    let(:params) do
      {
        ensure: false
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem: 'Centos',
        is_pe: 'true',
        pe_server_build: '2015.3.1'
      }
    end
    it do
      is_expected.to contain_file('/var/log/webhook/access.log').with(
        'ensure' => 'absent',
        'path'   => '/var/log/webhook/access.log'
      )
    end
    it do
      is_expected.to contain_file('/var/log/webhook').with(
        'ensure' => 'absent',
        'path'   => '/var/log/webhook'
      )
    end
    it do
      is_expected.to contain_file('/var/run/webhook').with(
        'ensure' => 'absent',
        'path'   => '/var/run/webhook'
      )
    end
    it do
      is_expected.to contain_file('webhook_init_script').with(
        'ensure' => 'absent',
        'path'   => '/etc/init.d/webhook'
      )
    end
  end

  context 'Puppet Enterprise 3.7.0 on a RedHat 5 installing webhook no mco' do
    let(:params) do
      {
        use_mcollective: false
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true',
        pe_version: '3.7.0'
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'pe_gem'
      )
    end

    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'pe_gem'
      )
    end
    it do
      is_expected.not_to contain_file('peadmin-cert.pem').with(
        'path' => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    end
  end
  context 'Puppet FOSS 4.2.1 a RedHat 6 installing webhook' do
    let(:params) do
      {
        use_mcollective: true
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem: 'Centos',
        puppetversion: '4.2.1'
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    end

    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'puppet_gem'
      )
    end
    it do
      is_expected.not_to contain_file('peadmin-cert.pem').with(
        'path' => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    end
  end
  context 'Puppet FOSS 4.2.x on a RedHat 6 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem: 'Centos',
        is_pe: 'false',
        puppetversion: '4.2.1'
      }
    end
    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'   => 'installed',
        'provider' => 'puppet_gem'
      )
    end
  end
  context 'Puppet FOSS 3.7.1  on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos',
        puppetversion: '3.7.1'
      }
    end

    it do
      is_expected.to contain_package('sinatra').with(
        'ensure'    => 'installed',
        'provider'  => 'gem'
      )
    end

    it do
      is_expected.to contain_package('webrick').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end

    it do
      is_expected.to contain_package('rack').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end

    it do
      is_expected.to contain_package('sinatra').with(
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
      is_expected.not_to contain_file('peadmin-cert.pem').with(
        'path' => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    end
  end
  context 'Puppet FOSS 3.2.1 on a RedHat 5 installing webhook' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5',
        operatingsystem: 'Centos',
        puppetversion: '3.2.1'
      }
    end
    it do
      is_expected.not_to contain_package('rack').with(
        'ensure'   => 'installed',
        'provider' => 'gem'
      )
    end
    it do
      is_expected.not_to contain_file('peadmin-cert.pem').with(
        'path' => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
      )
    end
  end
  context 'Enterprise Linux 7 host with systemd' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '7',
        operatingsystem: 'Centos',
        is_pe: 'true',
        pe_version: '3.7.0'
      }
    end
    it do
      is_expected.to contain_file('webhook_init_script').with(
        path: '/usr/lib/systemd/system/webhook.service',
        content: %r{\[Unit\]}
      )
    end
  end
  context 'Non Enteprise Linux 7 host' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '6',
        operatingsystem: 'Centos',
        is_pe: 'true',
        pe_version: '3.7.0'
      }
    end
    it do
      is_expected.to contain_file('webhook_init_script').with(
        path: '/etc/init.d/webhook',
        content: %r{#!/bin/bash}
      )
    end
  end
end
