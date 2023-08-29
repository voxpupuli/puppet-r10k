# Class: r10k::webhook::package
#
#
class r10k::webhook::package () {
  case $r10k::webhook::install_method { # lint:ignore:case_without_default
    'package': {
      case $facts['os']['family'] {
        'RedHat': {
          $provider = 'rpm'
          $pkg_file = '/tmp/webhook-go.rpm'
          $package_url = "https://github.com/voxpupuli/webhook-go/releases/download/v${r10k::webhook::version}/webhook-go_${r10k::webhook::version}_linux_amd64.rpm"
        }
        'Debian', 'Ubuntu': {
          $provider = 'dpkg'
          $pkg_file = '/tmp/webhook-go.deb'
          $package_url = "https://github.com/voxpupuli/webhook-go/releases/download/v${r10k::webhook::version}/webhook-go_${r10k::webhook::version}_linux_amd64.deb"
        }
        default: {
          fail("Operating system ${facts['os']['name']} not supported for packages")
        }
      }

      file { $pkg_file:
        ensure => file,
        source => $package_url,
        before => Package['webhook-go'],
      }

      package { 'webhook-go':
        ensure   => 'present',
        source   => $pkg_file,
        provider => $provider,
      }
    }
    'repo': {
      warning('webhook-go: configuring a repo is not implemented yet')
    }
    # none = people configure a repo on their own
    'none': {
      package { 'webhook-go':
        ensure => 'installed',
      }
    }
  }
}
