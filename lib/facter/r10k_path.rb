Facter.add(:r10k_path) do
  confine :kernel => :linux
  setcode do
    path = Facter::Util::Resolution.exec("which r10k")
    if path
      path.to_s
    else
      nil
    end
  end
end
