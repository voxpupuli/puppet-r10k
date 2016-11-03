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
    it { should contain_class('r10k::params')}

    it "Should not contain any resources" do
      expect(catalogue.resources.size).to eq(4)
    end
  end
  context "Puppet FOSS on OpenBSD" do
    let :facts do
      {
        :osfamily               => 'OpenBSD',
        :is_pe                  => 'false'
      }
    end
    it { should contain_class('r10k::params')}

    it "Should not contain any resources" do
      expect(catalogue.resources.size).to eq(4)
    end
  end
end
