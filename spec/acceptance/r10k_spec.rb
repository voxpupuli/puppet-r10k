# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'r10k tests' do
  context 'when defaults used' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        include 'r10k'
        PUPPET
      end
    end

    describe command('r10k version') do
      its(:stdout) { is_expected.to match(%r{r10k 4}) } if fact('puppetversion')[0] == '7'
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe file('//etc/puppetlabs/r10k/r10k.yaml') do
      it 'exists and has content' do
        expect(subject).to exist
        expect(subject).to be_owned_by 'root'
        expect(subject).to be_grouped_into 'root'
      end
    end
  end
end
