class r10k::params
{
  $version = '1.0.0'

  $pe_ruby = $::is_pe ? {
    'true'  => true,
    'false' => false,
  }

  # Puppet Enterprise specific settings
  if $::is_pe == 'true' {
    # Mcollective configuration dynamic
    $mc_service_name     = 'pe-mcollective'
    $plugins_dir         = '/opt/puppet/libexec/mcollective/mcollective'
  } else {
    # Getting ready for FOSS support in this module

    # Mcollective configuration dynamic
    $mc_service_name     = 'mcollective'
    $plugins_dir         = '/usr/libexec/mcollective/mcollective'
  }

  # r10k configuration
  $r10k_config_file     = '/etc/r10k.yaml'
  $r10k_cache_dir       = '/var/cache/r10k'
  $r10k_basedir         = "${::settings::confdir}/environments"
  $r10k_purgedirs       = $r10k::params::r10k_basedir

  # Git configuration
  $git_server          = $::settings::ca_server
  $repo_path           = '/var/repos'
  $remote              = "ssh://${git_server}${repo_path}/modules.git"
  $source_name         = 'jiminy'

  # Mcollective configuration static
  $mc_agent_name       = "${module_name}.rb"
  $mc_agent_ddl_name   = "${module_name}.ddl"
  $mc_app_name         = "${module_name}.rb"
  $mc_agent_path       = "${plugins_dir}/agent"
  $mc_application_path = "${plugins_dir}/application"

}
