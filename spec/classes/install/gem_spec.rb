require 'spec_helper'

version = '2.0.0'

describe 'r10k::install::gem', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context "installing version '#{version}' via gem" do
        let :params do
          {
            manage_ruby_dependency: 'declare',
            version:                version
          }
        end

        it { is_expected.to contain_class('ruby').with(rubygems_update: false) }
        it { is_expected.to contain_class('ruby::dev') }

        context 'when manage_ruby_dependency is set to "include"' do
          let :params do
            {
              manage_ruby_dependency: 'include',
              version:                version
            }
          end

          it { is_expected.to contain_class('ruby').with(rubygems_update: false) }
          it { is_expected.to contain_class('ruby::dev') }
        end

        context 'when manage_ruby_dependency is set to "ignore"' do
          let :params do
            {
              manage_ruby_dependency: 'ignore',
              version:                version
            }
          end

          it { is_expected.not_to contain_class('ruby') }
          it { is_expected.not_to contain_class('ruby::dev') }
        end
      end
    end
  end
end
