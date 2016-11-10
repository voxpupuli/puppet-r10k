require 'spec_helper'
describe 'r10k::install::gem', type: 'class' do
  context 'on a RedHat 5 OS installing 1.1.0 via gem with puppet FOSS 3.2.3' do
    let(:params) do
      {
        manage_ruby_dependency: 'declare',
        version: '1.1.0'
      }
    end
    let(:facts) do
      {
        osfamily: 'RedHat',
        puppetversion: '3.2.3',
        operatingsystemrelease: '5'
      }
    end
    it do
      is_expected.to contain_class('ruby').with(
        'rubygems_update' => false
      )
    end
    it { is_expected.to contain_class('ruby::dev') }
    context 'when manage_ruby_dependency is set to "include"' do
      let(:params) do
        {
          manage_ruby_dependency: 'include',
          version: '1.1.0'
        }
      end
      it { is_expected.to contain_class('ruby').with('rubygems_update' => false) }
      it { is_expected.to contain_class('ruby::dev') }
    end
    context 'when manage_ruby_dependency is set to "ignore"' do
      let(:params) do
        {
          manage_ruby_dependency: 'ignore',
          version: '1.1.0'
        }
      end
      it 'does not declare the ruby or ruby::dev classes' do
        is_expected.not_to contain_class('ruby')
        is_expected.not_to contain_class('ruby::dev')
      end
    end
  end
end
