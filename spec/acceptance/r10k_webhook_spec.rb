# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'r10k::webhook tests', if: fact('os.name') != 'Archlinux' do
  context 'when defaults used' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'r10k': }
        -> class { 'r10k::webhook': }
        PUPPET
      end
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

    describe command('systemctl cat webhook-go') do
      its(:stdout) { is_expected.to match(%r{webhook-go}) }
    end
  end

  context 'with external repo' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'r10k': }
        -> class { 'r10k::webhook':
          install_method => 'repo',
        }
        PUPPET
      end
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

    describe command('systemctl cat webhook-go') do
      its(:stdout) { is_expected.to match(%r{webhook-go}) }
    end
  end
end
