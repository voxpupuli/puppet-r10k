# Class: r10k::webhook::service
#
#
class r10k::webhook::service () {
  service { 'webhook-go.service':
    ensure => $r10k::webhook::service_ensure,
    enable => $r10k::webhook::service_enabled,
  }
  if $r10k::webhook::service_user {
    systemd::dropin_file { 'user.conf':
      unit    => 'webhook-go.service',
      content => "[Service]\nUser=${r10k::webhook::service_user}\n",
    }
  }
}
