# @summary This class configures r10k
#
# @param cachedir Path to a directory to be used by r10k for caching data
# @param sources Hash containing data sources to be used by r10k to create dynamic Puppet environments
# @param postrun Array containing the parts of a system call Example: ['/usr/bin/curl', '-F', 'deploy=done', 'http://my-app.site/endpoint']
# @param manage_configfile_symlink determine if a symlink to the r10k config file is to be managed
# @param configfile_symlink Location of symlink that points to configfile
# @param forge_settings Hash containing settings for downloading modules from the Puppet Forge
# @param proxy String containing proxy setting for r10k.yaml
# @param pool_size Integer defining how many threads should be spawn while updating modules
class r10k (
  $remote                                                     = $r10k::params::remote,
  Optional[Hash] $sources                                     = $r10k::params::sources,
  $cachedir                                                   = $r10k::params::r10k_cache_dir,
  $configfile                                                 = $r10k::params::r10k_config_file,
  $version                                                    = $r10k::params::version,
  $puppet_master                                              = $r10k::params::puppet_master,
  $modulepath                                                 = $r10k::params::modulepath,
  Boolean $manage_modulepath                                  = $r10k::params::manage_modulepath,
  Enum['include','declare','ignore'] $manage_ruby_dependency  = $r10k::params::manage_ruby_dependency,
  Stdlib::Absolutepath $r10k_basedir                          = $r10k::params::r10k_basedir,
  $package_name                                               = $r10k::params::package_name,
  $provider                                                   = $r10k::params::provider,
  $gentoo_keywords                                            = $r10k::params::gentoo_keywords,
  $install_options                                            = $r10k::params::install_options,
  $mcollective                                                = $r10k::params::mcollective,
  Boolean $manage_configfile_symlink                          = $r10k::params::manage_configfile_symlink,
  Stdlib::Absolutepath $configfile_symlink                    = $r10k::params::configfile_symlink,
  Optional[Hash] $git_settings                                = $r10k::params::git_settings,
  Optional[Hash] $forge_settings                              = $r10k::params::forge_settings,
  Hash $deploy_settings                                       = $r10k::params::deploy_settings,
  $root_user                                                  = $r10k::params::root_user,
  Optional[String[1]] $proxy                                  = $r10k::params::proxy,
  Optional[Integer[1]] $pool_size                             = $r10k::params::pool_size,
  Optional[String[1]] $gem_source                             = $r10k::params::gem_source,
  $root_group                                                 = $r10k::params::root_group,
  Optional[Array[String[1]]] $postrun                         = undef,
  Boolean $include_prerun_command                             = false,
  Boolean $include_postrun_command                            = false,
  Stdlib::Absolutepath $puppetconf_path                       = $r10k::params::puppetconf_path,
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

  class { 'r10k::install':
    install_options        => $install_options,
    keywords               => $gentoo_keywords,
    manage_ruby_dependency => $manage_ruby_dependency,
    package_name           => $package_name,
    provider               => $provider,
    gem_source             => $gem_source,
    version                => $version,
    puppet_master          => $puppet_master,
  }

  contain r10k::config

  if $mcollective {
    class { 'r10k::mcollective': }
  }
}
