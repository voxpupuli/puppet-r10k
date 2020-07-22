require 'spec_helper'
describe 'r10k::prerun_command', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with Puppet Enterprise' do
        let :facts do
          facts.merge(
            is_pe: true
          )
        end

        context 'adding custom prerun_command' do
          let :params do
            {
              command: 'synchronize',
              ensure:  'present'
            }
          end

          it do
            is_expected.to contain_ini_setting('r10k_prerun_command').with(
              ensure:  'present',
              section: 'agent',
              setting: 'prerun_command',
              value:   '/bin/r10k synchronize'
            )
          end
        end

        context 'removing custom prerun_command' do
          let :params do
            {
              command: 'synchronize',
              ensure:  'absent'
            }
          end

          it do
            is_expected.to contain_ini_setting('r10k_prerun_command').with(
              ensure:  'absent',
              section: 'agent',
              setting: 'prerun_command',
              value:   '/bin/r10k synchronize'
            )
          end
        end
      end

      context 'with Puppet FOSS' do
        context 'default prerun_command' do
          it do
            is_expected.to contain_ini_setting('r10k_prerun_command').with(
              ensure:  'present',
              section: 'agent',
              setting: 'prerun_command',
              value:   '/bin/r10k deploy environment -p'
            )
          end
        end

        context 'adding custom prerun_command' do
          let :params do
            {
              command: 'synchronize',
              ensure:  'present'
            }
          end

          it do
            is_expected.to contain_ini_setting('r10k_prerun_command').with(
              ensure:  'present',
              section: 'agent',
              setting: 'prerun_command',
              value:   '/bin/r10k synchronize'
            )
          end
        end

        context 'removing custom prerun_command' do
          let :params do
            {
              command: 'synchronize',
              ensure:  'absent'
            }
          end

          it do
            is_expected.to contain_ini_setting('r10k_prerun_command').with(
              ensure:  'absent',
              section: 'agent',
              setting: 'prerun_command',
              value:   '/bin/r10k synchronize'
            )
          end
        end
      end
    end
  end
end
