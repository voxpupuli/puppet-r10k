# Class: r10k::webhook::service
#
#
class r10k::webhook::service () {
  service { 'webhook-go.service':
    ensure => $r10k::webhook::service_ensure,
    enable => $r10k::webhook::service_enabled,
  }

  systemd::dropin_file { 'webhook-go.service-override':
    unit     => 'webhook-go.service',
    filename => 'override.conf',
    content  => epp('r10k/webhook-service-override.epp', {
      'service_user'      => $r10k::webhook::service_user,
      'github_token_path' => $r10k::webhook::github_token_path,
    }),
    require  => Class['r10k::webhook::config'],
    notify   => Service['webhook-go.service'],
  }
}
