# This class creates a github webhoook to allow curl style post-rec scripts
class r10k::webhook(
  $user  = 'peadmin',
  $group = 'peadmin',
  $git_server = 'localhost',
) inherits r10k::params {

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
    source => 'puppet:///modules/r10k/webhook',
    path   => '/usr/local/bin/webhook',
    notify => Service['webhook'],
  }

  service { 'webhook':
    ensure    => 'running',
    enable    => true,
    pattern   => '.*ruby.*webhoo[k]$',
    hasstatus => false,
  }

  if !defined(Package['sinatra']) {
    package { 'sinatra':
      ensure   => installed,
      provider => 'pe_gem',
      before   => Service['webhook'],
    }
  }

  if versioncmp($::pe_version, '3.7.0') >= 0{
    if !defined(Package['rack']) {
      package { 'rack':
        ensure   => installed,
        provider => 'pe_gem',
        before   => Service['webhook'],
      }
    }
    # 3.7 does not place the certificate in peadmin's ~
    # This places it there as if it was an upgrade
    file { 'peadmin-cert.pem':
        ensure  => 'file',
        path    => '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem',
        owner   => 'peadmin',
        group   => 'peadmin',
        mode    => '0644',
        content => file('/etc/puppetlabs/puppet/ssl/certs/pe-internal-peadmin-mcollective-client.pem'),
        notify  => Service['webhook'],
    }
  }
}
