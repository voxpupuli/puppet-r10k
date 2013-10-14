class r10k::install::bundle {
  # The bundle install has prefix support as of writing this, I want bleeding edge.
  class { 'git': }
  package { "${module_name}-bundle":
    ensure   => installed,
    name     => 'bundle',
    provider => gem,
  }
  vcsrepo { "${module_name}-r10k-github":
    ensure   => latest,
    provider => git,
    path     => '/tmp/r10k',
    source   => 'https://github.com/adrienthebo/r10k.git',
    revision => 'master',
    require  => Class['git'],
  }
  exec { "${module_name}-install-via-bundle":
    command => 'bundle && bundle install --path /opt/ --binstubs /usr/local/bin/',
    cwd     => '/tmp/r10k',
    require => [ Package["${module_name}-bundle"] , Vcsrepo["${module_name}-r10k-github"] ],
    unless  => 'bundle list | grep -q " r10k "',
    path    => '/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin:/sbin:/bin',
  }
}
