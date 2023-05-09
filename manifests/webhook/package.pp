# Class: r10k::webhook::package
#
#
class r10k::webhook::package (
  String $version = '2.0.1',
) {
  case $facts['os']['name'] {
    'RedHat', 'CentOS': {
      $provider = 'rpm'
      $package_url = "https://github.com/voxpupuli/webhook-go/releases/download/v${version}/webhook-go_${version}_linux_amd64.rpm"
    }
    'Debian', 'Ubuntu': {
      $provider = 'dpkg'
      $package_url = "https://github.com/voxpupuli/webhook-go/releases/download/v${version}/webhook-go_${version}_linux_amd64.deb"
    }
    default: {
      fail("Operating system ${facts['os']['name']} not supported for packages")
    }
  }

  package { 'webhook-go':
    ensure   => 'present',
    source   => $package_url,
    proviser => $provider,
  }
}
