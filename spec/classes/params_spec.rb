require 'spec_helper'
describe 'r10k::params', type: :class do
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

        it { is_expected.to contain_class('r10k::params') }
        it { expect(catalogue.resources.size).to eq(4) }
      end

      context 'with Puppet FOSS' do
        it { is_expected.to contain_class('r10k::params') }
        it { expect(catalogue.resources.size).to eq(4) }
      end
    end
  end
end
