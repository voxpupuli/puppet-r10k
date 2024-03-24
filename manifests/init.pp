# @summary This class configures r10k
#
# @param remote
# @param configfile
# @param version
# @param puppet_master
# @param modulepath
# @param manage_modulepath
# @param manage_ruby_dependency
# @param r10k_basedir
# @param package_name
# @param provider
# @param gentoo_keywords
# @param install_options
# @param mcollective
# @param git_settings
# @param deploy_settings
# @param root_user
# @param gem_source
# @param root_group
# @param include_prerun_command
# @param include_postrun_command
# @param puppetconf_path
# @param cachedir
#   Path to a directory to be used by r10k for caching data
# @param sources 
#   Hash containing data sources to be used by r10k to create dynamic Puppet environments
# @param postrun
#   Array containing the parts of a system call Example: ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint']
# @param manage_configfile_symlink
#   determine if a symlink to the r10k config file is to be managed
# @param configfile_symlink
#   Location of symlink that points to configfile
# @param forge_settings
#   Hash containing settings for downloading modules from the Puppet Forge
# @param proxy
#   String containing proxy setting for r10k.yaml
# @param pool_size
#   Integer defining how many threads should be spawn while updating modules
# @param ensure
#   if r10k should be installed or purged
class r10k (
  $remote                                                     = $r10k::params::remote,
  Optional[Hash] $sources                                     = undef,
  Stdlib::Absolutepath $cachedir                              = "${facts['puppet_vardir']}/r10k",
  Stdlib::Absolutepath $configfile                            = '/etc/puppetlabs/r10k/r10k.yaml',
  $version                                                    = $r10k::params::version,
  $puppet_master                                              = $r10k::params::puppet_master,
  $modulepath                                                 = $r10k::params::modulepath,
  Boolean $manage_modulepath                                  = $r10k::params::manage_modulepath,
  Enum['include','declare','ignore'] $manage_ruby_dependency  = $r10k::params::manage_ruby_dependency,
  Stdlib::Absolutepath $r10k_basedir                          = $r10k::params::r10k_basedir,
  $package_name                                               = $r10k::params::package_name,
  $provider                                                   = $r10k::params::provider,
  String $gentoo_keywords                                     = '', # lint:ignore:params_empty_string_assignment
  Variant[Array,String] $install_options                      = [],
  $mcollective                                                = $r10k::params::mcollective,
  Boolean $manage_configfile_symlink                          = false,
  Stdlib::Absolutepath $configfile_symlink                    = '/etc/r10k.yaml',
  Optional[Hash] $git_settings                                = undef,
  Optional[Hash] $forge_settings                              = undef,
  Hash $deploy_settings                                       = { 'generate_types' => true, 'exclude_spec' => true, },
  $root_user                                                  = $r10k::params::root_user,
  Optional[String[1]] $proxy                                  = undef,
  Integer[1] $pool_size                                       = $facts['processors']['count'],
  Optional[String[1]] $gem_source                             = undef,
  $root_group                                                 = $r10k::params::root_group,
  Optional[Array[String[1]]] $postrun                         = undef,
  Boolean $include_prerun_command                             = false,
  Boolean $include_postrun_command                            = false,
  Stdlib::Absolutepath $puppetconf_path                       = $r10k::params::puppetconf_path,
  Enum['absent','present'] $ensure                            = 'present',
) inherits r10k::params {
  # Check if user is declaring both classes
  # Other classes like r10k::webhook is supported but
  # using both classes makes no sense unless given pe_r10k
  # overrides this modules default config
  if defined(Class['pe_r10k']) {
    fail('This module does not support being declared with pe_r10k')
  }

  if $include_prerun_command {
    include r10k::prerun_command
  }

  if $include_postrun_command {
    include r10k::postrun_command
  }

  contain r10k::install
  contain r10k::config

  if $mcollective {
    class { 'r10k::mcollective': }
  }
}
