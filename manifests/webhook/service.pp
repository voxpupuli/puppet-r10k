# Class: r10k::webhook::service
#
#
class r10k::webhook::service () {
  service { 'webhook-go.service':
    ensure => $r10k::webhook::service_ensure,
    enable => $r10k::webhook::service_enabled,
  }
  $dropin_ensure = if $r10k::webhook::service_user and $r10k::webhook::service_ensure {
    'present'
  } else {
    'absent'
  }
  systemd::dropin_file { 'user.conf':
    ensure  => $dropin_ensure,
    unit    => 'webhook-go.service',
    content => "[Service]\nUser=${r10k::webhook::service_user}\n",
  }
}
