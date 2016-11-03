require 'spec_helper'
describe 'r10k::install::gem' , :type => 'class' do
  context "on a RedHat 5 OS installing 1.1.0 via gem with puppet FOSS 3.2.3" do
    let :params do
      {
        :manage_ruby_dependency => 'declare',
        :version                => '1.1.0',
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
      'rubygems_update' => false
      )
    }
    it { should contain_class("ruby::dev") }
    context 'when manage_ruby_dependency is set to "include"' do
      let (:params) {{
        :manage_ruby_dependency => 'include',
        :version                => '1.1.0',
      }}
      it { should contain_class("ruby").with('rubygems_update'   => false)}
      it { should contain_class("ruby::dev") }
    end
    context 'when manage_ruby_dependency is set to "ignore"' do
      let (:params) {{
        :manage_ruby_dependency => 'ignore',
        :version                => '1.1.0',
      }}
      it 'should not declare the ruby or ruby::dev classes' do
        should_not contain_class('ruby')
        should_not contain_class('ruby::dev')
      end
    end
  end
end
