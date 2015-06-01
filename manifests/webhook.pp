# This class creates a github webhoook to allow curl style post-rec scripts
class r10k::webhook(
  $user             = $r10k::params::webhook_user,
  $group            = $r10k::params::webhook_group,
  $bin_template     = $r10k::params::webhook_bin_template,
  $service_template = $r10k::params::webhook_service_template,
  $service_file     = $r10k::params::webhook_service_file,
  $manage_packages  = true,
) inherits r10k::params {

  include r10k::webhook::config

  File {
    ensure => file,
    owner  => 'root',
    group  => '0',
    mode   => '0755',
  }

  file { '/var/log/webhook':
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    recurse => true,
    before  => File['webhook_bin'],
  }

  file { '/var/run/webhook':
    ensure => 'directory',
    owner  => $user,
    group  => $group,
    before => File['webhook_init_script'],
  }

  file { 'webhook_init_script':
    content => template("r10k/${service_template}"),
    path    => $service_file,
    before  => File['webhook_bin'],
  }

  file { 'webhook_bin':
    content => template($bin_template),
    path    => '/usr/local/bin/webhook',
    notify  => Service['webhook'],
  }

  service { 'webhook':
    ensure  => 'running',
    enable  => true,
    pattern => '.*ruby.*webhoo[k]$',
  }

  if $manage_packages {
    include webhook::package
  }

  if $::is_pe == true or $::is_pe == 'true' {
    if versioncmp($::pe_version, '3.7.0') >= 0 {
      # 3.7 does not place the certificate in peadmin's ~
      # This places it there as if it was an upgrade
      file { 'peadmin-cert.pem':
          ensure  => 'file',
          path    => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
          owner   => 'peadmin',
          group   => 'peadmin',
          mode    => '0644',
          content => file('/etc/puppetlabs/puppet/ssl/certs/pe-internal-peadmin-mcollective-client.pem','/dev/null'),
          notify  => Service['webhook'],
      }
    }
  }
}
