# This class links the r10k binary for Puppet FOSS 4.2 and up
class r10k::install::puppet_gem {
  require ::git

  if versioncmp("${::puppetversion}", '4.2.0') >= 0 { #lint:ignore:only_variable_string
    file { '/usr/bin/r10k':
      ensure  => link,
      target  => '/opt/puppetlabs/puppet/bin/r10k',
      require => Package['r10k'],
    }
  }
}
