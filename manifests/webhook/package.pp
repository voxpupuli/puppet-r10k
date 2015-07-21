# Private class, do not include it directly.
# Installs the webhook packages
class r10k::webhook::package {
  if $::is_pe == true or $::is_pe == 'true' {
    if !defined(Package['sinatra']) {
      package { 'sinatra':
        ensure   => installed,
        provider => 'pe_gem',
        before   => Service['webhook'],
      }
    }

    if versioncmp($::pe_version, '3.7.0') >= 0 {
      if !defined(Package['rack']) {
        package { 'rack':
          ensure   => installed,
          provider => 'pe_gem',
          before   => Service['webhook'],
        }
      }
    }
  } else {

    # Puppet FOSS 4.2 and up ships a vendor provided ruby.
    # Using puppet_gem uses that instead of the system ruby.
    if (versioncmp($::puppetversion, '4.2.0') >= 0) {
      $provider = 'puppet_gem'
    } else {
      $provider = 'gem'
    }

    if !defined(Package['webrick']) {
      package { 'webrick':
        ensure   => installed,
        provider => $provider,
        before   => Service['webhook'],
      }
    }

    if !defined(Package['json']) {
      package { 'json':
        ensure   => installed,
        provider => $provider,
        before   => Service['webhook'],
      }
    }

    if !defined(Package['sinatra']) {
      package { 'sinatra':
        ensure   => installed,
        provider => $provider,
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
          provider => $provider,
          before   => Service['webhook'],
        }
      }
    }
  }
}
