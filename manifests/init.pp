# This class configures r10k
class r10k (
  $sources     = {},
  $remote      = $r10k::params::remote,
  $source_name = $r10k::params::source_name,
  $purgedirs   = $r10k::params::r10k_purgedirs,
  $basedir     = $r10k::params::r10k_basedir,
  $cachedir    = $r10k::params::r10k_cache_dir,
  $configfile  = $r10k::params::r10k_config_file,
  $version     = $r10k::params::version,
  $pe_ruby     = $r10k::params::pe_ruby,
) inherits r10k::params {
  if $pe_ruby {
    class { 'r10k::pe_ruby' :
      version => $version,
    }
  } else {
    class { 'r10k::ruby' :
      version => $version,
    }
  }

  class { 'r10k::config':
    cachedir     => $cachedir,
    configfile   => $configfile,
    sources      => $sources,
    purgedirs    => $purgedirs,
    r10k_basedir => $basedir,
  }
}
