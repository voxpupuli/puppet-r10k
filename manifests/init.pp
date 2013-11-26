# This class configures r10k
class r10k (
  $remote            = $r10k::params::remote,
  $sources           = $r10k::params::sources,
  $purgedirs         = $r10k::params::r10k_purgedirs,
  $cachedir          = $r10k::params::r10k_cache_dir,
  $configfile        = $r10k::params::r10k_config_file,
  $version           = $r10k::params::version,
  $modulepath        = $r10k::params::modulepath,
  $manage_modulepath = $r10k::params::manage_modulepath,
  $r10k_basedir      = $r10k::params::r10k_basedir,
  $provider          = $r10k::params::provider,
  $gentoo_keywords   = $r10k::params::gentoo_keywords,
  $install_options   = $r10k::params::install_options,
) inherits r10k::params {

  class { 'r10k::install':
    version         => $version,
    provider        => $provider,
    keywords        => $gentoo_keywords,
    install_options => $install_options,
  }

  class { 'r10k::config':
    cachedir          => $cachedir,
    configfile        => $configfile,
    sources           => $sources,
    purgedirs         => $purgedirs,
    modulepath        => $modulepath,
    remote            => $remote,
    manage_modulepath => $manage_modulepath,
  }
}
