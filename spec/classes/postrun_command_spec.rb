require 'spec_helper'
describe 'r10k::postrun_command', type: :class do
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

        context 'adding custom postrun_command' do
          let :params do
            {
              command: 'r10k synchronize',
              ensure:  'present'
            }
          end

          it { is_expected.to contain_class('r10k::params') }
          it do
            is_expected.to contain_ini_setting('r10k_postrun_command').with(
              ensure:  'present',
              section: 'agent',
              setting: 'postrun_command',
              value:   'r10k synchronize'
            )
          end
        end

        context 'removing custom postrun_command' do
          let :params do
            {
              command: 'r10k synchronize',
              ensure:  'absent'
            }
          end

          it { is_expected.to contain_class('r10k::params') }
          it do
            is_expected.to contain_ini_setting('r10k_postrun_command').with(
              ensure:  'absent',
              section: 'agent',
              setting: 'postrun_command',
              value:   'r10k synchronize'
            )
          end
        end
      end

      context 'with Puppet FOSS' do
        context 'adding default postrun_command' do
          it { is_expected.to contain_class('r10k::params') }
          it do
            is_expected.to contain_ini_setting('r10k_postrun_command').with(
              ensure:  'present',
              section: 'agent',
              setting: 'postrun_command',
              value:   'r10k deploy environment -p'
            )
          end
        end

        context 'adding custom postrun_command' do
          let :params do
            {
              command: 'r10k21 synchronize',
              ensure:  'present'
            }
          end

          it { is_expected.to contain_class('r10k::params') }
          it do
            is_expected.to contain_ini_setting('r10k_postrun_command').with(
              ensure:  'present',
              section: 'agent',
              setting: 'postrun_command',
              value:   'r10k21 synchronize'
            )
          end
        end

        context 'removing custom postrun_command' do
          let :params do
            {
              command: 'r10k21 synchronize',
              ensure:  'absent'
            }
          end

          it { is_expected.to contain_class('r10k::params') }
          it do
            is_expected.to contain_ini_setting('r10k_postrun_command').with(
              ensure:  'absent',
              section: 'agent',
              setting: 'postrun_command',
              value:   'r10k21 synchronize'
            )
          end
        end
      end
    end
  end
end
