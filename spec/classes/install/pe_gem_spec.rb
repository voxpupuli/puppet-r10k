require 'spec_helper'

describe 'r10k::install::pe_gem', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'via pe_gem for Puppet Enterprise 3.7.1' do
        let :params do
          {
            puppet_master: true
          }
        end
        let :facts do
          facts.merge(
            is_pe:      'true',
            pe_version: '3.7.1'
          )
        end

        it do
          is_expected.to contain_file('/usr/bin/r10k').with(
            ensure:  'link',
            target:  '/opt/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
      end
      context 'via pe_gem for Puppet Enterprise 3.8.1' do
        let :params do
          {
            puppet_master: true
          }
        end
        let :facts do
          facts.merge(
            is_pe:      'true',
            pe_version: '3.8.1'
          )
        end

        it do
          is_expected.not_to contain_file('/usr/bin/r10k').with(
            ensure:  'link',
            target:  '/opt/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
      end
      context 'via pe_gem for Puppet Enterprise 3.8.1 not puppet master' do
        let :params do
          {
            puppet_master: false
          }
        end
        let :facts do
          facts.merge(
            is_pe:      'true',
            pe_version: '3.8.1'
          )
        end

        it do
          is_expected.to contain_file('/usr/bin/r10k').with(
            ensure:  'link',
            target:  '/opt/puppet/bin/r10k',
            require: 'Package[r10k]'
          )
        end
      end
    end
  end
end
