# This class configures r10k
class r10k (
  $remote            = $r10k::params::remote,
  $sources           = $r10k::params::sources,
  $purgedirs         = $r10k::params::r10k_purgedirs,
  $cachedir          = $r10k::params::r10k_cache_dir,
  $configfile        = $r10k::params::r10k_config_file,
  $version           = $r10k::params::version,
  $pe_ruby           = $r10k::params::pe_ruby,
  $modulepath        = $r10k::params::modulepath,
  $manage_modulepath = $r10k::params::manage_modulepath,
  $r10k_basedir      = $r10k::params::r10k_basedir,
  $use_bundle        = $r10k::params::use_bundle,
) inherits r10k::params {

  class { 'r10k::install':
    version    => $version,
    pe_ruby    => $pe_ruby,
    use_bundle => $use_bundle,
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
