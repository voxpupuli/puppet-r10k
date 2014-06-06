# This class creates a github webhoook to allow curl style post-rec scripts
class r10k::webhook(
  $user  = 'peadmin'
  $group = 'peadmin',
  $git_server = 'localhost',
) {
  require r10k::webhook::config

  File {
    ensure => file,
    owner  => 'root',
    group  => '0',
    mode   => '0755',
  }

  file { '/var/log/webhook':
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      before => File['webhook_bin'],
  }

  file { '/var/run/webhook':
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      before => File['webhook_init_script'],
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
    pattern   => '.*ruby.*webhoo[k]$',
    hasstatus => false,
  }

  package { 'sinatra':
    ensure   => installed,
    provider => 'pe_gem',
  }
}
