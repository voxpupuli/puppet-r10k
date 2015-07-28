require "spec_helper"

describe "Facter::Util::Fact" do
  before {
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return("Linux")
  }

  describe "r10k_path" do
    it do
      allow(Facter::Util::Resolution).to receive(:exec).with("which r10k").
      and_return("/usr/local/bin/r10k")
      Facter.fact(:r10k_path).value.should == "/usr/local/bin/r10k"
    end
  end
end
