# This class is used by the ruby or pe_ruby class
class r10k::install (
  $version,
  $pe_ruby,
  $use_bundle,
) {
  # There are currently bugs in r10k 1.x which make using 0.x desireable in
  # certain circumstances. However, 0.x requires make and gcc. Conditionally
  # include those classes if necessary due to 0.x r10k version usage. When
  # 1.x is just as good or better than 0.x, we can stop supporting 0.x and
  # remove this block.
  if versioncmp('1.0.0', $version) > 0 {
    require gcc
    require make
  }

  if $pe_ruby {
    $provider = 'pe_gem'
  } else {
    $provider = 'gem'
    class { 'r10k::install::ruby': version => $version; }
  }

  if ! $r10k::install::use_bundle {
    package { 'r10k':
      ensure   => $version,
      provider => $provider,
    }
  } else {
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
}
