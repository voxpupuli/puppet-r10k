require 'spec_helper'
describe 'r10k', type: 'class' do
  context 'on a RedHat 5 OS' do
    let(:params) do
      { remote: 'git@github.com:someuser/puppet.git' }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it { is_expected.to contain_class('r10k::install') }
    it { is_expected.to contain_class('r10k::config') }
    it { is_expected.not_to contain_class('r10k::mcollective') }
  end

  context 'with mcollective' do
    let(:params) do
      { mcollective: true }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: '5'
      }
    end
    it { is_expected.to contain_class('r10k::mcollective') }
  end
  context 'on OpenBSD' do
    let(:params) do
      { remote: 'git@github.com:someuser/puppet.git' }
    end
    let(:facts) do
      {
        osfamily: 'OpenBSD'
      }
    end
    it { is_expected.to contain_class('r10k::params') }
    it { is_expected.to contain_class('r10k::install') }
    it { is_expected.to contain_class('r10k::config') }
    it { is_expected.not_to contain_class('r10k::mcollective') }
  end

  context 'with mcollective' do
    let(:params) do
      { mcollective: true }
    end
    let(:facts) do
      {
        osfamily: 'OpenBSD'
      }
    end
    it { is_expected.to contain_class('r10k::mcollective') }
  end
end
