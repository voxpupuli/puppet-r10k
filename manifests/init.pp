# This class configures r10k
class r10k (
  $remote     = $r10k::params::remote,
  $purgedirs  = $r10k::params::r10k_purgedirs,
  $basedir    = $r10k::params::r10k_basedir,
  $cachedir   = $r10k::params::r10k_cache_dir,
  $configfile = $r10k::params::r10k_config_file,
) inherits r10k::params {
  if $::is_pe == 'true' {
    include r10k::pe
  } else {
    include r10k::foss
  }
}
