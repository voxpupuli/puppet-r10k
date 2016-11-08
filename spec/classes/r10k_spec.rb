require 'spec_helper'
describe 'r10k', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with a github remote' do
        let :params do
          {
            remote: 'git@github.com:someuser/puppet.git'
          }
        end

        it { is_expected.to contain_class('r10k::params') }
        it { is_expected.to contain_class('r10k::install') }
        it { is_expected.to contain_class('r10k::config') }
        it { is_expected.not_to contain_class('r10k::mcollective') }
      end

      context 'with mcollective' do
        let :params do
          {
            mcollective: true
          }
        end

        it { is_expected.to contain_class('r10k::mcollective') }
      end
    end
  end
end
