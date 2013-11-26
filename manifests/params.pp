# Reasonable defaults for all classes
class r10k::params
{
  $package_name      = ''
  $version           = '1.1.0'
  $manage_modulepath = false
  $install_options   = ''

  # r10k configuration
  $r10k_config_file     = '/etc/r10k.yaml'
  $r10k_cache_dir       = '/var/cache/r10k'
  $r10k_basedir         = "${::settings::confdir}/environments"
  $r10k_purgedirs       = $r10k_basedir

  # Git configuration
  $git_server          = $::settings::ca_server
  $repo_path           = '/var/repos'
  $remote              = "ssh://${git_server}${repo_path}/modules.git"

  # prerun_command in puppet.conf
  $prerun_command = 'r10k deploy environment -p'

  # Gentoo specific values
  $gentoo_keywords = ''

  if $::is_pe == 'true' {
    # Puppet Enterprise specific settings
    $puppetconf_path     = '/etc/puppetlabs/puppet'

    $pe_module_path      = '/opt/puppet/share/puppet/modules'
    # Mcollective configuration dynamic
    $mc_service_name     = 'pe-mcollective'
    $plugins_dir         = '/opt/puppet/libexec/mcollective/mcollective'
    $modulepath          = "${r10k_basedir}/\$environment/modules:${pe_module_path}"
    $provider            = 'pe_gem'
  } else {
    # Installation package manager provider
    $provider = 'gem'

    # Getting ready for FOSS support in this module
    $puppetconf_path     = '/etc/puppet'

    # Mcollective configuration dynamic
    $mc_service_name     = 'mcollective'
    case $::osfamily {
      'debian':  {
        $plugins_dir  = '/usr/share/mcollective/plugins/mcollective'
      }
      default: {
        $plugins_dir  = '/usr/libexec/mcollective/mcollective'
      }
    }
    $modulepath          = "${r10k_basedir}/\$environment/modules"
  }

  # Mcollective configuration static
  $mc_agent_name       = "${module_name}.rb"
  $mc_agent_ddl_name   = "${module_name}.ddl"
  $mc_app_name         = "${module_name}.rb"
  $mc_agent_path       = "${plugins_dir}/agent"
  $mc_application_path = "${plugins_dir}/application"
}
