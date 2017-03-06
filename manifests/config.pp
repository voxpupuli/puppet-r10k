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
  $configfile                               = $r10k::params::r10k_config_file,
  $cachedir                                 = $r10k::params::r10k_cache_dir,
  Optional[Hash] $sources                   = $r10k::params::sources,
  $modulepath                               = $r10k::params::modulepath,
  $remote                                   = $r10k::params::remote,
  Boolean $manage_modulepath                = $r10k::params::manage_modulepath,
  Stdlib::Absolutepath $r10k_basedir        = $r10k::params::r10k_basedir,
  Boolean $manage_configfile_symlink        = $r10k::params::manage_configfile_symlink,
  Stdlib::Absolutepath $configfile_symlink  = $r10k::params::configfile_symlink,
  Hash $git_settings                        = $r10k::params::git_settings,
  Hash $forge_settings                      = $r10k::params::forge_settings,
  Hash $deploy_settings                     = $r10k::params::deploy_settings,
  Optional[Array] $postrun                  = undef,
  $root_user                                = $r10k::params::root_user,
  $root_group                               = $r10k::params::root_group,
  Stdlib::Absolutepath $puppetconf_path     = $r10k::params::puppetconf_path,
  String $r10k_yaml_template                = 'r10k/r10k.yaml.erb',
) inherits r10k::params {

  if $sources == undef {
    $r10k_sources  = {
      'puppet' => {
        'remote'  => $remote,
        'basedir' => $r10k_basedir,
      },
    }
    $source_keys = keys($r10k_sources)
  } else {
    $r10k_sources = $sources
    $source_keys = keys($r10k_sources)
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

  if $manage_configfile_symlink {
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
