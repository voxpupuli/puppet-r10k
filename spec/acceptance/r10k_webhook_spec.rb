# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'r10k::webhook tests' do
  context 'when defaults used' do
    it 'applies' do
      pp = <<-MANIFEST
        class { 'r10k': }
        -> class { 'r10k::webhook': }
      MANIFEST

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('webhook-go') do
      it { is_expected.to be_installed }
    end

    describe file('/etc/voxpupuli/webhook.yml') do
      it 'exists and has content' do
        expect(subject).to exist
        expect(subject).to be_owned_by 'root'
        expect(subject).to be_grouped_into 'root'
        expect(subject).to contain "---\nserver:\n  protected: true\n  user: puppet\n  password: puppet\n"
      end
    end

    describe service('webhook-go') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
