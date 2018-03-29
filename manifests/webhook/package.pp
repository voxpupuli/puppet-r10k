# Private class, do not include it directly.
# Installs the webhook packages
class r10k::webhook::package (
  $is_pe_server    = $r10k::params::is_pe_server,
  $provider        = $r10k::params::provider,
  $sinatra_version = $r10k::params::webhook_sinatra_version,
  $webrick_version = $r10k::params::webhook_webrick_version,
) inherits r10k::params {
  if !defined(Package['sinatra']) {
    package { 'sinatra':
      ensure   => $sinatra_version,
      provider => $provider,
      notify   => Service['webhook'],
    }
  }
  if (! $is_pe_server) {
    if !defined(Package['webrick']) {
      package { 'webrick':
        ensure   => $webrick_version,
        provider => $provider,
        notify   => Service['webhook'],
      }
    }

    if !defined(Package['json']) {
      package { 'json':
        ensure   => installed,
        provider => $provider,
        notify   => Service['webhook'],
      }
    }
  }
}
