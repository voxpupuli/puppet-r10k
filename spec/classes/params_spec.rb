require 'spec_helper'
describe 'r10k::params' , :type => 'class' do
  context "Puppet Enterprise on a RedHat 5 OS" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '5',
        :operatingsystem        => 'Centos',
        :is_pe                  => 'true'
      }
    end
    it { should contain_r10k__params }

    it "Should not contain any resources" do
      expect(subject.resources.size).to eq(4) 
    end
  end
end
