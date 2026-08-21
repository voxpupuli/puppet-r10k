# Class: r10k::webhook::package
#
#
class r10k::webhook::package () {
  case $r10k::webhook::install_method { # lint:ignore:case_without_default
    'package': {
      # Work out the remote package name
      $pkg_prefix = 'https://github.com/voxpupuli/webhook-go/releases/download'
      $pkg_arch = $facts['os']['architecture'] ? {
        'aarch64' => 'arm64',
        default   => 'amd64',
      }
      $pkg_base = "${pkg_prefix}/v${r10k::webhook::version}/webhook-go_${r10k::webhook::version}_linux_${pkg_arch}"

      case $facts['os']['family'] {
        'RedHat': {
          $pkg_url  = "${pkg_base}.rpm"
          if $facts['package_provider'] == 'dnf' {
            $pkg_file = undef
          } else {
            $provider = 'rpm'
            $pkg_file = '/tmp/webhook-go.rpm'
          }
        }
        'Debian', 'Ubuntu': {
          $provider = 'dpkg'
          $pkg_file = '/tmp/webhook-go.deb'
          $pkg_url  = "${pkg_base}.deb"
        }
        default: {
          fail("Operating system ${facts['os']['name']} not supported for packages")
        }
      }

      if $pkg_file {
        file { $pkg_file:
          ensure => file,
          source => $pkg_url,
          before => Package['webhook-go'],
        }
        package { 'webhook-go':
          ensure   => 'present',
          source   => $pkg_file,
          provider => $provider,
        }
      } else {
        package { 'webhook-go':
          ensure => 'present',
          source => $pkg_url,
        }
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
