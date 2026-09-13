# frozen_string_literal: true

Facter.add(:r10k_path) do
  confine kernel: :linux
  setcode do
    Facter::Core::Execution.execute('which r10k 2> /dev/null')
  end
end
