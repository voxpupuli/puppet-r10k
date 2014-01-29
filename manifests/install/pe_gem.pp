# This class links the r10k binary for PE
class r10k::install::pe_gem {

  require git

  file { '/usr/bin/r10k':
    ensure  => link,
    target  => '/opt/puppet/bin/r10k',
    require => Package['r10k'],
  }
}
