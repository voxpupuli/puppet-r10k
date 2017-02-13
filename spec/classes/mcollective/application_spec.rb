require 'spec_helper'
describe 'r10k::mcollective::application', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'Puppet Enterprise 2016.4.2' do
        let :facts do
          facts.merge(
            pe_build: '2016.4.2'
          )
        end

        it { is_expected.to contain_class('r10k::params') }
        it do
          is_expected.to contain_file('mcollective_application_exec').with(
            ensure: 'present',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            source: 'puppet:///modules/r10k/application/r10k.rb'
          )
        end
        it do
          is_expected.to contain_file('mcollective_application_ddl').with(
            ensure: 'present',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            source: 'puppet:///modules/r10k/agent/r10k.ddl'
          )
        end
      end

      context 'Puppet FOSS' do
        it { is_expected.to contain_class('r10k::params') }
        it do
          is_expected.to contain_file('mcollective_application_exec').with(
            ensure: 'present',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            source: 'puppet:///modules/r10k/application/r10k.rb'
          )
        end
        it do
          is_expected.to contain_file('mcollective_application_ddl').with(
            ensure: 'present',
            owner:  'root',
            group:  'root',
            mode:   '0644',
            source: 'puppet:///modules/r10k/agent/r10k.ddl'
          )
        end
      end
    end
  end
end
