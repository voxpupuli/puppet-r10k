require 'puppet'
Facter.add('r10k_environment') do
  setcode do
    Puppet[:environment].to_s
  end
end
