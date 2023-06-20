# Class: r10k::webhook::config
#
#
class r10k::webhook::config (
) {
  file { 'webhook.yml':
    ensure  => $r10k::webhook::config_ensure,
    path    => $r10k::webhook::config_path,
    content => to_yaml($r10k::webhook::config),
    notify  => Service['webhook-go'],
    require => Package['webhook-go'],
  }
}
