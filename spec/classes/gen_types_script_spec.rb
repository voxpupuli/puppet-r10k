# frozen_string_literal: true

require 'spec_helper'
describe 'r10k::gen_types_script', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with default params' do
        it { is_expected.to compile }
        it { is_expected.to have_file_resource_count(1) }
        it { is_expected.to contain_file('/usr/libexec/generate-puppet-types.sh') }
      end

      context 'with script path' do
        let(:params) do
          {
            'generate_types_script_location' => '/tmp/path',
          }
        end

        it { is_expected.to compile }
        it { is_expected.to have_file_resource_count(1) }
        it { is_expected.to contain_file('/tmp/path') }
      end
    end
  end
end
