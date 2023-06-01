# Class: r10k::webhook::package
#
#
class r10k::webhook::package () {
  case $facts['os']['family'] {
    'RedHat': {
      $provider = 'rpm'
      $package_url = "https://github.com/voxpupuli/webhook-go/releases/download/v${r10k::webhook::version}/webhook-go_${r10k::webhook::version}_linux_amd64.rpm"
    }
    'Debian', 'Ubuntu': {
      $provider = 'dpkg'
      $package_url = "https://github.com/voxpupuli/webhook-go/releases/download/v${r10k::webhook::version}/webhook-go_${r10k::webhook::version}_linux_amd64.deb"
    }
    default: {
      fail("Operating system ${facts['os']['name']} not supported for packages")
    }
  }

  package { 'webhook-go':
    ensure   => 'present',
    source   => $package_url,
    provider => $provider,
  }
}
