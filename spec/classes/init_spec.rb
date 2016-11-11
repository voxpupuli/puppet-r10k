require 'spec_helper'
describe 'r10k' do
  context 'On RedHat with PE with default values for params' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystemrelease: '5',
        operatingsystem: 'Centos',
        is_pe: 'true'
      }
    end
    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_class('r10k::prerun_command') }
    it { is_expected.not_to contain_class('r10k::postrun_command') }
  end
  context 'On OpenBSD with Puppet FOSS with default values for params' do
    let(:facts) do
      {
        osfamily: 'OpenBSD',
        is_pe: 'false'
      }
    end
    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_class('r10k::prerun_command') }
    it { is_expected.not_to contain_class('r10k::postrun_command') }
  end
  context 'when manage_ruby_dependency has an invalid value' do
    let(:params) { { 'manage_ruby_dependency' => 'BOGON' } }
    it 'fails' do
      expect { catalogue }.to raise_error(Puppet::Error, %r{"BOGON" does not match})
    end
  end

  ['true', true].each do |value|
    context "On RedHat with PE with param include_prerun_command set to #{value}" do
      let(:params) { { include_prerun_command: value } }
      let(:facts) do
        {
          osfamily: 'RedHat',
          operatingsystemrelease: '5',
          operatingsystem: 'Centos',
          is_pe: 'true'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('r10k::prerun_command') }
    end
    context "On OpenBSD with Puppet FOSS with param include_prerun_command set to #{value}" do
      let(:params) { { include_prerun_command: value } }
      let(:facts) do
        {
          osfamily: 'OpenBSD',
          is_pe: 'false'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('r10k::prerun_command') }
    end
  end

  ['false', false].each do |value|
    context "On RedHat with PE with param include_prerun_command set to #{value}" do
      let(:params) { { include_prerun_command: value } }
      let(:facts) do
        {
          osfamily: 'RedHat',
          operatingsystemrelease: '5',
          operatingsystem: 'Centos',
          is_pe: 'true'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.not_to contain_class('r10k::prerun_command') }
    end
    context "On OpenBSD with Puppet FOSS with param include_prerun_command set to #{value}" do
      let(:params) { { include_prerun_command: value } }
      let(:facts) do
        {
          osfamily: 'OpenBSD',
          is_pe: 'false'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.not_to contain_class('r10k::prerun_command') }
    end
  end

  ['true', true].each do |value|
    context "On RedHat with PE with param include_postrun_command set to #{value}" do
      let(:params) { { include_postrun_command: value } }
      let(:facts) do
        {
          osfamily: 'RedHat',
          operatingsystemrelease: '5',
          operatingsystem: 'Centos',
          is_pe: 'true'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('r10k::postrun_command') }
    end
    context "On OpenBSD with Puppet FOSS with param include_postrun_command set to #{value}" do
      let(:params) { { include_postrun_command: value } }
      let(:facts) do
        {
          osfamily: 'OpenBSD',
          is_pe: 'false'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('r10k::postrun_command') }
    end
  end

  ['false', false].each do |value|
    context "On RedHat with PE with param include_postrun_command set to #{value}" do
      let(:params) { { include_postrun_command: value } }
      let(:facts) do
        {
          osfamily: 'RedHat',
          operatingsystemrelease: '5',
          operatingsystem: 'Centos',
          is_pe: 'true'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.not_to contain_class('r10k::postrun_command') }
    end
    context "On OpenBSD with Puppet FOSS with param include_postrun_command set to #{value}" do
      let(:params) { { include_postrun_command: value } }
      let(:facts) do
        {
          osfamily: 'OpenBSD',
          is_pe: 'false'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.not_to contain_class('r10k::postrun_command') }
    end
  end
end
