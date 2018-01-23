require 'spec_helper'
describe 'r10k::mcollective', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'Puppet Enterprise with defaults' do
        let :facts do
          facts.merge(
            is_pe:      true,
            pe_version: '2016.4.2'
          )
        end
        let(:pre_condition) { "service { 'mcollective': }" }

        it { is_expected.to contain_class('r10k::params') }
        it do
          is_expected.to contain_file('mcollective_agent_executable').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it do
          is_expected.to contain_file('mcollective_agent_ddl').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it do
          is_expected.to contain_file('mcollective_application_file').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it { is_expected.to contain_file('mcollective_application_file').with_content(%r{\"GIT_SSL_NO_VERIFY\" => \"0\"}) }
        it do
          is_expected.to contain_service('mcollective').with(
            subscribe: [
              'File[mcollective_agent_executable]',
              'File[mcollective_agent_ddl]',
              'File[mcollective_application_file]'
            ]
          )
        end
      end

      context 'Puppet Enterprise removing the mcollective agent & application' do
        let :params do
          {
            ensure: false
          }
        end
        let :facts do
          facts.merge(
            is_pe:      true,
            pe_version: '2016.4.2'
          )
        end

        it { is_expected.to contain_file('mcollective_agent_executable').with(ensure: 'absent') }
        it { is_expected.to contain_file('mcollective_agent_ddl').with(ensure: 'absent') }
        it { is_expected.to contain_file('mcollective_application_file').with(ensure: 'absent') }
      end

      context 'Allows you to set git_ssl_verify for r10k file (deprecated - to be removed in major bump)' do
        let :params do
          {
            git_ssl_no_verify: 1
          }
        end
        let :facts do
          facts.merge(
            is_pe:      true,
            pe_version: '2016.4.2'
          )
        end

        it { is_expected.to contain_file('mcollective_application_file').with_content(%r{\"GIT_SSL_NO_VERIFY\" => \"1\"}) }
      end

      context 'Puppet FOSS with defaults' do
        let(:pre_condition) { "service { 'mcollective': }" }

        it { is_expected.to contain_class('r10k::params') }
        it do
          is_expected.to contain_file('mcollective_agent_executable').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it do
          is_expected.to contain_file('mcollective_agent_ddl').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it do
          is_expected.to contain_file('mcollective_application_file').with(
            ensure: 'file',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it do
          is_expected.to contain_service('mcollective').with(
            subscribe: [
              'File[mcollective_agent_executable]',
              'File[mcollective_agent_ddl]',
              'File[mcollective_application_file]'
            ]
          )
        end
      end
    end
  end
end
