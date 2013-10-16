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
    it { should include_class('r10k::params') }
    it { should include_class('r10k::install') }
    it { should include_class('r10k::config') }
  end
end

