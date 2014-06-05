# This class creates a github webhoook to allow curl style post-rec scripts
class r10k::webhook(
  $owner = 'root',
  $group = '0',
  $git_server = 'localhost',
) {
  require r10k::webhook::config

  File {
    ensure => file,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }

  file { '/var/log/webhook':
      ensure => 'directory',
      owner  => 'peadmin',
      group  => 'peadmin',
      before => File['webhook_bin'],
  }

  file { 'webhook_init_script':
    content => template('r10k/webhook.init.erb'),
    path    => '/etc/init.d/webhook',
    require => Package['sinatra'],
    before  => File['webhook_bin'],
  }
  file { 'webhook_bin':
    source  => 'puppet:///modules/r10k/webhook',
    path    => '/usr/local/bin/webhook',
    notify  => Service['webhook'],
  }

  service { 'webhook':
    ensure    => 'running',
    pattern   => '.*ruby.*webhoo[k]',
    hasstatus => false,
  }

  package { 'sinatra':
    ensure   => installed,
    provider => 'pe_gem',
  }
}
