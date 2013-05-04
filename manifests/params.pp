class r10k::params
{
  # r10k configuration
  $r10k_config_file     = '/etc/r10k.yaml'
  $r10k_cache_dir       = '/var/cache/r10k'
  $r10k_basedir         = "${::settings::confdir}/environments"
  $r10k_purgedirs       = $r10k::params::r10k_basedir

  # Git configuration
  $git_server          = $::settings::ca_server
  $repo_path           = '/var/repos'
  $remote              = "ssh://${git_server}${repo_path}/modules.git"
}
