class r10k::ruby(
  $version,
) {
  # Breaking up my chaining a little here
  Class['::ruby'] -> Class['ruby::dev'] -> Package['gcc']

  # rubygems_update => false
  # https://projects.puppetlabs.com/issues/19741
  class {'::ruby':
    rubygems_update => false,
  }
  class { 'ruby::dev':
    tag => 'amineeded',
  }

  # I am not sure this is required as I assumed the
  # ruby::dev class would have taken care of it
  Package['gcc'] -> Package['make'] -> Package['r10k']

  # Install the r10k gem & dependacies
  # Check for gcc and make as they might already be in the catalog
  if ! defined(Package['gcc']) {
    package { 'gcc':
      ensure => installed,
    }
  }

  if ! defined(Package['make']) {
    package { 'make':
      ensure => present,
    }
  }

  package { 'r10k':
    ensure   => $version,
    provider => 'gem',
  }
}
