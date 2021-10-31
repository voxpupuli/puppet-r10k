# frozen_string_literal: true

require 'spec_helper'
require 'facter/r10k_path'

describe 'r10k_path fact specs', type: :fact do
  before do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
  end

  describe 'r10k_path' do
    before do
      allow(Facter::Util::Resolution).to receive(:exec).with('which r10k 2> /dev/null').and_return('/usr/local/bin/r10k')
    end

    it 'defaults to /usr/local/bin/r10k' do
      expect(Facter.fact(:r10k_path).value).to eq('/usr/local/bin/r10k')
    end
  end
end
