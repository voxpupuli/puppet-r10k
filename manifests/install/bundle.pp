# This class installs the r10k bundle
class r10k::install::bundle(
  $revision = 'master',
  $source   = 'https://github.com/adrienthebo/r10k.git',
){

  require ::git

  # The bundle install has prefix support as of writing this, I want bleeding edge.
  package { "${module_name}-bundle":
    ensure   => installed,
    name     => 'bundler',
    provider => 'gem',
  }
  vcsrepo { "${module_name}-r10k-github":
    ensure   => latest,
    provider => 'git',
    path     => '/tmp/r10k',
    source   => $source,
    revision => $revision,
  }
  exec { "${module_name}-install-via-bundle":
    command => 'bundle && bundle install --path /opt/ --binstubs /usr/local/bin/',
    cwd     => '/tmp/r10k',
    require => [ Package["${module_name}-bundle"] , Vcsrepo["${module_name}-r10k-github"] ],
    unless  => 'bundle list | grep -q " r10k "',
    path    => $::path,
  }
}
