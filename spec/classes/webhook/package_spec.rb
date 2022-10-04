# frozen_string_literal: true

require 'spec_helper'
describe 'r10k::webhook::package', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :ruby_version do
        if facts[:aio_agent_version]
          # If the facts come from some kind of AIO puppet, match the version
          # of Ruby corresponding to the version of puppet we simulate.
          if puppetversion[0] == '6'
            '2.5.0'
          else
            '2.7.0'
          end
        else
          # Otherwise, assume a recent Ruby
          '3.0.0'
        end
      end
      let :facts do
        facts.merge(
          is_pe: is_pe,
          puppetversion: puppetversion,
          ruby: {
            version: ruby_version
          }
        )
      end

      let :pre_condition do
        "service { 'webhook.service': ensure => 'running'}"
      end

      context 'package provider' do
        let(:is_pe) { false }
        let(:puppetversion) { '7.10.0' }

        provider = case facts[:os]['name']
                   when 'Archlinux'
                     'pacman'
                   when 'Gentoo'
                     'portage'
                   else
                     'puppet_gem'
                   end
        it { is_expected.to contain_package('sinatra').with(provider: provider) }
      end

      context 'Puppet Enterprise 2019.8.7' do
        let :params do
          {
            is_pe_server: true
          }
        end
        let :facts do
          facts.merge(
            pe_server_version: '2019.8.7'
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.not_to contain_package('webrick') }
        it { is_expected.not_to contain_package('json') }
      end

      context 'Puppet FOSS 6' do
        let(:puppetversion) { '6.24.0' }
        let(:is_pe) { false }

        it { is_expected.to compile.with_all_deps }

        case facts[:os]['name']
        when 'Archlinux', 'Gentoo'
          it { is_expected.to contain_package('sinatra').with(ensure: 'installed') }
        else
          it { is_expected.to contain_package('sinatra').with(ensure: '~> 2.0') }
        end
        it { is_expected.to contain_package('webrick').with(ensure: 'installed') }
        it { is_expected.to contain_package('json').with(ensure: 'installed') }
      end

      context 'Puppet FOSS 7' do
        let(:puppetversion) { '7.10.0' }
        let(:is_pe) { false }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('sinatra').with(ensure: 'installed') }
        it { is_expected.to contain_package('webrick').with(ensure: 'installed') }
        it { is_expected.to contain_package('json').with(ensure: 'installed') }
      end
    end
  end
end
