# This class is used by the ruby or pe_ruby class
class r10k::install (
  $version,
  $provider,
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

  case $provider {
    'bundle': {
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
    'pe_gem', 'gem': {
      if $provider == 'gem' {
        class { 'r10k::install::gem': version => $version; }
      }
      package { 'r10k':
        ensure   => $version,
        provider => $provider,
      }
    }
    default: { fail("$provider is not supported. Valid values are: 'gem', 'pe_gem', 'bundle'") }
  }
}
