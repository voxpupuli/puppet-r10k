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

      context 'with PE 3.8.0 and default values' do
        let :facts do
          facts.merge(
            is_pe:      true,
            pe_version: '3.8.0'
          )
        end

        it { is_expected.to compile }
      end

      context 'when manage_ruby_dependency has an invalid value' do
        let :params do
          {
            manage_ruby_dependency: 'BOGON'
          }
        end

        it { expect { catalogue }.to raise_error(Puppet::Error, %r{"BOGON" does not match}) }
      end

      ['true', true].each do |value|
        context "with param include_prerun_command set to #{value}" do
          let :params do
            {
              include_prerun_command: value
            }
          end

          it { is_expected.to compile }
          it { is_expected.to contain_class('r10k::prerun_command') }
        end
      end

      ['false', false].each do |value|
        context "with param include_prerun_command set to #{value}" do
          let :params do
            {
              include_prerun_command: value
            }
          end

          it { is_expected.to compile }
          it { is_expected.not_to contain_class('r10k::prerun_command') }
        end
      end

      ['true', true].each do |value|
        context "with param include_postrun_command set to #{value}" do
          let :params do
            {
              include_postrun_command: value
            }
          end

          it { is_expected.to compile }
          it { is_expected.to contain_class('r10k::postrun_command') }
        end
      end

      ['false', false].each do |value|
        context "with param include_postrun_command set to #{value}" do
          let :params do
            {
              include_postrun_command: value
            }
          end

          it { is_expected.to compile }
          it { is_expected.not_to contain_class('r10k::postrun_command') }
        end
      end
    end
  end
end
