#
# @summary Set up the root r10k config file (/etc/r10k.yaml).
#
# @see https://github.com/adrienthebo/r10k#dynamic-environment-configuration
#
# @api private
#
# @author Charlie Sharpsteen <source@sharpsteen.net>
# @author Zack Smith <zack@puppetlabs.com>
#
class r10k::config {
  assert_private()
  if $r10k::sources {
    $r10k_sources = $r10k::sources
    $source_keys = keys($r10k_sources)
  } else {
    $r10k_sources  = {
      'puppet' => {
        'basedir' => $r10k::r10k_basedir,
        'remote'  => $r10k::remote,
      },
    }
    $source_keys = keys($r10k_sources)
  }

  if $r10k::configfile == '/etc/puppetlabs/r10k/r10k.yaml' {
    file { '/etc/puppetlabs/r10k':
      ensure => 'directory',
      owner  => $r10k::root_user,
      group  => $r10k::root_group,
      mode   => '0755',
    }
  }

  $config = {
    'pool_size' => $r10k::pool_size,
    'proxy'     => $r10k::proxy,
    'forge'     => $r10k::forge_settings,
    'git'       => $r10k::git_settings,
    'deploy'    => $r10k::deploy_settings,
    'cachedir'  => $r10k::cachedir,
    'postrun'   => $r10k::postrun,
    'sources'   => $r10k_sources,
  }.delete_undef_values
  file { 'r10k.yaml':
    ensure  => file,
    owner   => $r10k::root_user,
    group   => $r10k::root_group,
    mode    => '0644',
    path    => $r10k::configfile,
    content => stdlib::to_yaml($config),
  }

  if $r10k::manage_configfile_symlink {
    file { 'symlink_r10k.yaml':
      ensure => 'link',
      path   => $r10k::configfile_symlink,
      target => $r10k::configfile,
    }
  }

  if $r10k::manage_modulepath {
    ini_setting { 'R10k Modulepath':
      ensure  => present,
      path    => "${r10k::puppetconf_path}/puppet.conf",
      section => 'main',
      setting => 'modulepath',
      value   => $r10k::modulepath,
    }
  }
}
