# == Class: r10k::config
#
# Set up the root r10k config file (/etc/r10k.yaml).
#
# === Parameters
#
# * [*cachedir*]
#   Path to a directory to be used by r10k for caching data.
#   Default: /var/cache/r10k
# * [*sources*]
#   Hash containing data sources to be used by r10k to create dynamic Puppet
#   environments. Default: {}
# * [*postrun*]
#   **Optional:** Array containing the parts of a system call.
#   Example: ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint']
#   Default: undef
# * [*manage_configfile_symlink*]
#   Boolean to determine if a symlink to the r10k config file is to be managed.
#   Default: false
# * [*configfile_symlink*]
#   Location of symlink that points to configfile. Default: /etc/r10k.yaml
# * [*forge_settings*]
#   Hash containing settings for downloading modules from the Puppet Forge.
#
# === Examples
#
#  class { 'r10k::config':
#    sources => {
#      'somename' => {
#        'remote'  => 'ssh://git@github.com/someuser/somerepo.git',
#        'basedir' => "${::settings::confdir}/environments"
#      },
#      'someothername' => {
#        'remote'  => 'ssh://git@github.com/someuser/someotherrepo.git',
#        'basedir' => '/some/other/basedir'
#      },
#    },
#  }
#
# == Documentation
#
# * https://github.com/adrienthebo/r10k#dynamic-environment-configuration
#
# === Authors
#
# Charlie Sharpsteen <source@sharpsteen.net>
# Zack Smith <zack@puppetlabs.com>
class r10k::config (
  $configfile,
  $cachedir,
  $manage_modulepath,
  $root_user,
  $root_group,
  $modulepath                = undef,
  $remote                    = '',
  $sources                   = 'UNSET',
  $postrun                   = undef,
  $puppetconf_path           = $r10k::params::puppetconf_path,
  $r10k_basedir              = $r10k::params::r10k_basedir,
  $manage_configfile_symlink = $r10k::params::manage_configfile_symlink,
  $configfile_symlink        = '/etc/r10k.yaml',
  $r10k_yaml_template        = 'r10k/r10k.yaml.erb',
  $git_settings              = {},
  $forge_settings            = {},
) inherits r10k::params {

  validate_bool($manage_modulepath)

  if is_string($manage_configfile_symlink) {
    $manage_configfile_symlink_real = str2bool($manage_configfile_symlink)
  } else {
    $manage_configfile_symlink_real = $manage_configfile_symlink
  }
  validate_bool($manage_configfile_symlink_real)

  validate_absolute_path($configfile_symlink)

  if $sources == 'UNSET' {
    $r10k_sources  = {
      'puppet' => {
        'remote'  => $remote,
        'basedir' => $r10k_basedir,
      },
    }
    $source_keys = keys($r10k_sources)
  } else {
    validate_hash($sources)

    $r10k_sources = $sources
    $source_keys = keys($r10k_sources)
  }

  if $postrun != undef {
    validate_array($postrun)
  }

  if $configfile == '/etc/puppetlabs/r10k/r10k.yaml' {
    file {'/etc/puppetlabs/r10k':
      ensure => 'directory',
      owner  => $root_user,
      group  => $root_group,
      mode   => '0755',
    }
  }

  file { 'r10k.yaml':
    ensure  => file,
    owner   => $root_user,
    group   => $root_group,
    mode    => '0644',
    path    => $configfile,
    content => template($r10k_yaml_template),
  }

  if $manage_configfile_symlink_real == true {
    file { 'symlink_r10k.yaml':
      ensure => 'link',
      path   => $configfile_symlink,
      target => $configfile,
    }
  }

  if $manage_modulepath {
    ini_setting { 'R10k Modulepath':
      ensure  => present,
      path    => "${puppetconf_path}/puppet.conf",
      section => 'main',
      setting => 'modulepath',
      value   => $modulepath,
    }
  }
}
