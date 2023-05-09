# Class: r10k::webhook::service
#
#
class r10k::webhook::service {
  service { 'webhook':
    ensure => 'running',
  }
}
