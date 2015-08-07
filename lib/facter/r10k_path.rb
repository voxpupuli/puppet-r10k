Facter.add(:r10k_path) do
  confine :kernel => :linux
  setcode do
    path = Facter::Util::Resolution.exec("which r10k 2> /dev/null")
    if $?.success?
      path
    else
      nil
    end
  end
end
