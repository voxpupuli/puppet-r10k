# Reasonable defaults for all classes
class r10k::params
{
  $package_name           = ''
  $version                = '1.5.1'
  $manage_modulepath      = false
  $manage_ruby_dependency = 'declare'
  $install_options        = []
  $sources                = undef

  # r10k configuration
  $r10k_config_file          = '/etc/r10k.yaml'
  $r10k_cache_dir            = '/var/cache/r10k'
  $r10k_basedir              = "${::settings::confdir}/environments"
  $r10k_purgedirs            = $r10k_basedir
  $manage_configfile_symlink = false
  $configfile_symlink        = '/etc/r10k.yaml'

  # Git configuration
  $git_server = $::settings::ca_server
  $repo_path  = '/var/repos'
  $remote     = "ssh://${git_server}${repo_path}/modules.git"

  # Gentoo specific values
  $gentoo_keywords = ''

  # Include the mcollective agent
  $mcollective = false

  # Webhook configuration information
  $webhook_user                  = 'puppet'
  $webhook_pass                  = 'puppet'
  $webhook_bind_address          = '0.0.0.0'
  $webhook_port                  = '8088'
  $webhook_access_logfile        = '/var/log/webhook/access.log'
  $webhook_mco_logfile           = '/var/log/webhook/mco_output.log'
  $webhook_certname              = 'peadmin'
  $webhook_certpath              = '/var/lib/peadmin/.mcollective.d'
  $webhook_client_cfg            = '/var/lib/peadmin/.mcollective'
  $webhook_use_mco_ruby          = false
  $webhook_protected             = true
  $webhook_discovery_timeout     = 10
  $webhook_client_timeout        = 120
  $webhook_prefix                = false
  $webhook_prefix_command        = '/bin/echo example'
  $webhook_enable_ssl            = true
  $webhook_use_mcollective       = true
  $webhook_r10k_deploy_arguments = '-pv'
  $webhook_public_key_path       = undef
  $webhook_private_key_path      = undef
  $webhook_bin_template          = 'r10k/webhook.bin.erb'
  $webhook_yaml_template         = 'r10k/webhook.yaml.erb'
  $webhook_command_prefix        = '' # 'sudo' is the canonical example for this

  if $::osfamily == Debian {
    $functions_path     = '/lib/lsb/init-functions'
    $start_pidfile_args = '--pidfile=$pidfile'
  }
  else {
    $functions_path     = '/etc/rc.d/init.d/functions'
    $start_pidfile_args = '--pidfile $pidfile'
  }
  if $::is_pe == true or $::is_pe == 'true' {
    # Puppet Enterprise specific settings
    $puppetconf_path = '/etc/puppetlabs/puppet'

    $pe_module_path  = '/opt/puppet/share/puppet/modules'
    # Mcollective configuration dynamic
    $mc_service_name = 'pe-mcollective'
    $plugins_dir     = '/opt/puppet/libexec/mcollective/mcollective'
    $modulepath      = "${r10k_basedir}/\$environment/modules:${pe_module_path}"
    $provider        = 'pe_gem'
    $r10k_binary     = 'r10k'
  } else {
    # Getting ready for FOSS support in this module
    $puppetconf_path = '/etc/puppet'

    # Mcollective configuration dynamic
    $modulepath = "${r10k_basedir}/\$environment/modules"

    case $::osfamily {
      'debian': {
        $plugins_dir     = '/usr/share/mcollective/plugins/mcollective'
        $provider        = 'gem'
        $r10k_binary     = 'r10k'
        $mc_service_name = 'mcollective'
      }
      'gentoo': {
        $plugins_dir     = '/usr/libexec/mcollective/mcollective'
        $provider        = 'portage'
        $r10k_binary     = 'r10k'
        $mc_service_name = 'mcollective'
      }
      'suse': {
        $plugins_dir     = '/usr/share/mcollective/plugins/mcollective'
        $provider        = 'zypper'
        $r10k_binary     = 'r10k'
        $mc_service_name = 'mcollective'
      }
      'openbsd': {
        $plugins_dir     = '/usr/local/libexec/mcollective/mcollective'
        $provider        = 'openbsd'
        $r10k_binary     = 'r10k21'
        $mc_service_name = 'mcollectived'
      }
      default: {
        $plugins_dir     = '/usr/libexec/mcollective/mcollective'
        $provider        = 'gem'
        $r10k_binary     = 'r10k'
        $mc_service_name = 'mcollective'
      }
    }
  }

  # prerun_command in puppet.conf
  $pre_postrun_command = "${r10k_binary} deploy environment -p"


  # Mcollective configuration static
  $mc_agent_name       = "${module_name}.rb"
  $mc_agent_ddl_name   = "${module_name}.ddl"
  $mc_app_name         = "${module_name}.rb"
  $mc_agent_path       = "${plugins_dir}/agent"
  $mc_application_path = "${plugins_dir}/application"
  $mc_http_proxy       = undef
  $mc_git_ssl_verify   = 0

  # Service Settings for SystemD in EL7
  if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == '7' {
    $webhook_service_file     = '/usr/lib/systemd/system/webhook.service'
    $webhook_service_template = 'webhook.service.erb'
  } $::osfamily == 'Gentoo' {
    $webhook_service_file     = '/etc/init.d/webhook'
    $webhook_service_template = 'webhook.init.gentoo.erb'
  } else {
    $webhook_service_file     = '/etc/init.d/webhook'
    $webhook_service_template = 'webhook.init.erb'
  }
}
