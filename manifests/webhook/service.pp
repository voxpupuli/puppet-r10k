# Class: r10k::webhook::service
#
#
class r10k::webhook::service () {
  service { 'webhook':
    ensure => $r10k::webhook::service_ensure,
    enable => $r10k::webhook::service_enabled,
  }
}
