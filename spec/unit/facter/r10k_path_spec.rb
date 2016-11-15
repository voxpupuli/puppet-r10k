require 'spec_helper'
require 'facter/r10k_path'

describe 'r10k_path fact specs', type: :fact do
  before { Facter.clear }

  describe 'r10k_path' do
    before do
      Facter.fact(:kernel).stubs(:value).returns 'Linux'
      Facter::Util::Resolution.expects(:exec).with('which r10k 2> /dev/null').returns('/usr/local/bin/r10k')
    end

    it 'defaults to /usr/local/bin/r10k' do
      expect(Facter.fact(:r10k_path).value).to eq('/usr/local/bin/r10k')
    end
  end
end
