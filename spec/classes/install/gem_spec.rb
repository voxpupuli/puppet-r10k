require 'spec_helper'
describe 'r10k::install::gem' , :type => 'class' do
  context "on a RedHat 5 OS installing 1.1.0 via gem with puppet FOSS 2.7.19" do
    let :params do
      {
        :version       => '1.1.0'
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '2.7.19',
        :operatingsystemrelease => '5'
      }
    end
    it { should contain_class("ruby").with(
        'rubygems_update'   => false
      )
    }
    it { should include_class("ruby::dev") }

    it { should_not include_class("gcc") }
    it { should_not include_class("make") }
  end
  context "on a RedHat 5 OS installing 1.1.0 via gem with puppet FOSS 3.2.3" do
    let :params do
      {
        :version       => '1.1.0'
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '3.2.3',
        :operatingsystemrelease => '5'
      }
    end
    it { should contain_class("ruby").with(
      'rubygems_update' => true
      )
    }
    it { should include_class("ruby::dev") }
  end
  context "on a RedHat 5 OS installing 0.0.9 via gem with puppet FOSS 2.7.19" do
    let :params do
      {
        :version       => '0.0.9'
      }
    end
    let :facts do
      {
        :osfamily               => 'RedHat',
        :puppetversion          => '3.2.3',
        :operatingsystemrelease => '5'
      }
    end
    let(:pre_condition) {
      [ 'package { "r10k":
          ensure => present,
        }'
      ]}
    it { should include_class("make") }
    it { should include_class("gcc") }
  end
end
