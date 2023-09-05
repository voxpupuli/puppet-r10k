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
        'Debian': {
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
      case $facts['os']['family'] {
        'RedHat': {
          yumrepo { 'voxpupuli-webhook-go':
            descr         => 'A certifiably-awesome open-source package repository curated by Vox Pupuli, hosted by Cloudsmith.',
            baseurl       => "https://dl.cloudsmith.io/public/voxpupuli/webhook-go/rpm/${facts['os']['name']}/\$releasever/\$basearch",
            gpgcheck      => 1,
            repo_gpgcheck => 1,
            enabled       => true,
            gpgkey        => 'https://dl.cloudsmith.io/public/voxpupuli/webhook-go/gpg.FD229D5D47E6F534.key',
          }
        }
        'Debian': {
          include apt
          apt::source { 'voxpupuli-webhook-go':
            comment  => 'A certifiably-awesome open-source package repository curated by Vox Pupuli, hosted by Cloudsmith.',
            location => "https://dl.cloudsmith.io/public/voxpupuli/webhook-go/deb/${facts['os']['name']}",
            repos    => 'main',
            key      => {
              'id'     => 'FD229D5D47E6F534',
              'source' => 'https://dl.cloudsmith.io/public/voxpupuli/webhook-go/gpg.FD229D5D47E6F534.key',
            },
          }
        }
        default: {
          fail("Operating system ${facts['os']['name']} not supported for packages")
        }
      }
      package { 'webhook-go':
        ensure => 'installed',
      }
    }
    # none = people configure a repo on their own
    'none': {
      package { 'webhook-go':
        ensure => 'installed',
      }
    }
  }
}
