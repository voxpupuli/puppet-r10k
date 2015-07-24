# Private class, do not include it directly.
# Installs the webhook packages
class r10k::webhook::package (
) inherits r10k::params {
  
  if $is_pe_server {
    if !defined(Package['sinatra']) {
      package { 'sinatra':
        ensure   => installed,
        provider => 'pe_gem',
        before   => Service['webhook'],
      }
    }

    if versioncmp($::puppetversion, '3.7.0') >= 0 {
      if !defined(Package['rack']) {
        package { 'rack':
          ensure   => installed,
          provider => 'pe_gem',
          before   => Service['webhook'],
        }
      }
    }
  } else {
    if !defined(Package['webrick']) {
      package { 'webrick':
        ensure   => installed,
        provider => 'gem',
        before   => Service['webhook'],
      }
    }

    if !defined(Package['json']) {
      package { 'json':
        ensure   => installed,
        provider => 'gem',
        before   => Service['webhook'],
      }
    }

    if !defined(Package['sinatra']) {
      package { 'sinatra':
        ensure   => installed,
        provider => 'gem',
        before   => [
          Service['webhook'],
          File['webhook_init_script'],
        ],
      }
    }

    if versioncmp($::puppetversion, '3.7.0') >= 0 {
      if !defined(Package['rack']) {
        package { 'rack':
          ensure   => installed,
          provider => 'gem',
          before   => Service['webhook'],
        }
      }
    }
  }
}
