# This class creates a github webhoook to allow curl style post-rec scripts
class r10k::webhook(
  $ensure           = true,
  $user             = $r10k::params::webhook_user,
  $group            = $r10k::params::webhook_group,
  $background       = $r10k::params::webhook_background,
  $bin_template     = $r10k::params::webhook_bin_template,
  $service_template = $r10k::params::webhook_service_template,
  $service_file     = $r10k::params::webhook_service_file,
  $use_mcollective  = $r10k::params::webhook_use_mcollective,
  $is_pe_server     = $r10k::params::is_pe_server,
  $root_user        = $r10k::params::root_user,
  $root_group       = $r10k::params::root_group,
  $manage_packages  = true,
  $ruby_bin         = undef,
) inherits r10k::params {

  File {
    ensure => $ensure,
    owner  => $root_user,
    group  => $root_group,
    mode   => '0755',
  }

  # Rewrite the params to style guide in lieu of
  # using the boolean directly...for clarity?
  $ensure_directory = $ensure ? {
    true  => 'directory',
    false => 'absent',
  }

  $ensure_file = $ensure ? {
    true  => 'file',
    false => 'absent',
  }

  $ensure_service = $ensure ? {
    true  => 'running',
    false => 'stopped',
  }

  $server_type = $background ? {
    true  => 'WEBrick::Daemon',
    false => 'WEBrick::SimpleServer',
  }

  file { '/var/log/webhook/access.log':
    ensure => $ensure_file,
    owner  => $user,
    group  => $group,
    mode   => '0644',
    before => File['webhook_bin'],
  }

  file { '/var/log/webhook':
    ensure  => $ensure_directory,
    owner   => $user,
    group   => $group,
    recurse => $ensure,
    force   => $ensure,
    before  => File['webhook_bin'],
  }

  file { '/var/run/webhook':
    ensure => $ensure_directory,
    owner  => $user,
    group  => $group,
    before => File['webhook_init_script'],
  }

  file { 'webhook_init_script':
    ensure  => $ensure_file,
    content => template("r10k/${service_template}"),
    path    => $service_file,
    before  => File['webhook_bin'],
  }

  file { 'webhook_bin':
    ensure  => $ensure_file,
    content => template($bin_template),
    path    => '/usr/local/bin/webhook',
    notify  => Service['webhook'],
  }

  service { 'webhook':
    ensure => $ensure_service,
    enable => $ensure,
  }

  # We don't remove the packages/ gem as
  # They might be shared dependencies
  if $manage_packages {
    include ::r10k::webhook::package
  }

  # Only managed this file if you are using mcollective mode
  # We don't remove it as its part of PE and this is legacy
  if $use_mcollective {
    if $is_pe_server and versioncmp("${::puppetversion}", '3.7.0') >= 0 { #lint:ignore:only_variable_string
      # 3.7 does not place the certificate in peadmin's ~
      # This places it there as if it was an upgrade
      file { 'peadmin-cert.pem':
        ensure  => 'file',
        path    => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        owner   => 'peadmin',
        group   => 'peadmin',
        mode    => '0644',
        content => file("${r10k::params::puppetconf_path}/ssl/certs/pe-internal-peadmin-mcollective-client.pem",'/dev/null'),
        notify  => Service['webhook'],
      }
    }
  }
}
