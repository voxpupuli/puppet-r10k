# This class creates a github webhoook to allow curl style post-rec scripts
class r10k::webhook(
  $user             = $r10k::params::webhook_user,
  $group            = $r10k::params::webhook_group,
  $bin_template     = $r10k::params::webhook_bin_template,
  $service_template = $r10k::params::webhook_service_template,
  $service_file     = $r10k::params::webhook_service_file,
  $use_mcollective  = $r10k::params::webhook_use_mcollective,
  $manage_packages  = true,
) inherits r10k::params {
  
  $is_pe_server = $r10k::params::is_pe_server

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
    include r10k::webhook::package
  }

  # Only managed this file if you are using mcollective mode
  if $use_mcollective {
    if $is_pe_server and versioncmp($::puppetversion, '3.7.0') >= 0 {
      # 3.7 does not place the certificate in peadmin's ~
      # This places it there as if it was an upgrade
      file { 'peadmin-cert.pem':
        ensure  => 'file',
        path    => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        owner   => 'peadmin',
        group   => 'peadmin',
        mode    => '0644',
        content => file("${r10k::params::puppetconf_path}/certs/pe-internal-peadmin-mcollective-client.pem",'/dev/null'),
        notify  => Service['webhook'],
      }
    }
  }
}
