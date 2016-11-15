Facter.add(:r10k_path) do
  confine :kernel => :linux # rubocop:disable Style/HashSyntax
  setcode do
    Facter::Util::Resolution.exec('which r10k 2> /dev/null')
  end
end
