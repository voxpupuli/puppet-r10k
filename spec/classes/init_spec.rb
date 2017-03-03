require 'spec_helper'
describe 'r10k' do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with default values' do
        it { is_expected.to compile }
        it { is_expected.to contain_class('r10k::install') }
        it { is_expected.to contain_class('r10k::config') }
        it { is_expected.not_to contain_class('r10k::mcollective') }
        it { is_expected.not_to contain_class('r10k::prerun_command') }
        it { is_expected.not_to contain_class('r10k::postrun_command') }
      end

      context 'with param include_prerun_command set to true' do
        let :params do
          {
            include_prerun_command: true
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('r10k::prerun_command') }
      end

      context 'with param include_postrun_command set to true' do
        let :params do
          {
            include_postrun_command: true
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('r10k::postrun_command') }
      end
    end
  end
end
