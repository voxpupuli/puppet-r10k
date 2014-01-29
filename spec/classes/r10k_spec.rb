require 'spec_helper'
describe 'r10k' , :type => 'class' do
  context "on a RedHat 5 OS" do
    let :params do
      { :remote => 'git@github.com:someuser/puppet.git' }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
      }
    end
    it { should contain_class('r10k::params') }
    it { should contain_class('r10k::install') }
    it { should contain_class('r10k::config') }
    it { should_not contain_class('r10k::mcollective') }
  end

  context 'with mcollective' do
    let(:params) do
      { :mcollective => true }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
      }
    end
    it { should contain_class('r10k::mcollective') }
  end
end

