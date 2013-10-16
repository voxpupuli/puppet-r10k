class r10k::install::pe_gem {
  file { '/usr/bin/r10k':
    ensure => link,
    target => '/opt/puppet/bin/r10k',
    require => Package['r10k'],
  }
}
