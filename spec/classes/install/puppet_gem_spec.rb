require 'spec_helper'
describe 'r10k::install::puppet_gem', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      let :pre_condition do
        'include r10k'
      end

      context 'with defaults' do
        it do
          is_expected.to contain_file('/usr/bin/r10k').with(
            ensure:  'link',
            target:  '/opt/puppetlabs/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
      end
    end
  end
end
