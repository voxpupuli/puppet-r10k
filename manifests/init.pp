# This class configures r10k
class r10k (
  $sources           = {},
  $remote            = $r10k::params::remote,
  $source_name       = $r10k::params::source_name,
  $purgedirs         = $r10k::params::r10k_purgedirs,
  $basedir           = $r10k::params::r10k_basedir,
  $cachedir          = $r10k::params::r10k_cache_dir,
  $configfile        = $r10k::params::r10k_config_file,
  $version           = $r10k::params::version,
  $pe_ruby           = $r10k::params::pe_ruby,
  $modulepath        = $r10k::params::modulepath,
  $manage_modulepath = $r10k::params::manage_modulepath,
) inherits r10k::params {

  anchor { 'r10k::begin': }

  if $pe_ruby {
    class { 'r10k::install::pe_ruby' :
      version => $version,
      require => Anchor['r10k::begin'],
    }
  } else {
    class { 'r10k::install::ruby' :
      version => $version,
      require => Anchor['r10k::begin'],
    }
  }

  class { 'r10k::config':
    cachedir          => $cachedir,
    configfile        => $configfile,
    sources           => $sources,
    purgedirs         => $purgedirs,
    r10k_basedir      => $basedir,
    modulepath        => $modulepath,
    manage_modulepath => $manage_modulepath,
  }

  anchor { 'r10k::end': require => Class['r10k::config'], }
}
