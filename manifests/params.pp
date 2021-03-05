# Reasonable defaults for all classes
class r10k::params {
  $package_name           = ''
  $version                = 'installed'
  $manage_modulepath      = false
  $manage_ruby_dependency = 'declare'

  $provider = $facts['os']['name'] ? {
    'Archlinux' => 'gem',
    default     => 'puppet_gem',
  }

  $install_options        = []
  $sources                = undef
  $puppet_master          = true
  $proxy                  = undef
  $pool_size              = undef
  $gem_source             = undef

  if 'puppet_environment' in $facts {
    $r10k_basedir            = $facts['puppet_environmentpath']
  } else {
    $r10k_basedir            = '/etc/puppetlabs/code/environments'
  }
  $r10k_cache_dir            = "${facts['puppet_vardir']}/r10k"
  $r10k_config_file          = '/etc/puppetlabs/r10k/r10k.yaml'
  $r10k_binary               = 'r10k'
  $puppetconf_path           = '/etc/puppetlabs/puppet'
  $manage_configfile_symlink = false
  $configfile_symlink        = '/etc/r10k.yaml'
  $git_settings              = {}
  $forge_settings            = {}
  $deploy_settings           = {}
  # Git configuration
  $git_server = $::settings::ca_server
  $repo_path  = '/var/repos'
  $remote     = "ssh://${git_server}${repo_path}/modules.git"

  # Gentoo specific values
  $gentoo_keywords = ''

  # Include the mcollective agent
  $mcollective = false

  case $facts['os']['family'] {
    'Debian': {
      $functions_path     = '/lib/lsb/init-functions'
      $start_pidfile_args = '--pidfile=$pidfile'
    }
    'SUSE': { $functions_path     = '/etc/rc.status' }
    default:  {
      $functions_path     = '/etc/rc.d/init.d/functions'
      $start_pidfile_args = '--pidfile $pidfile'
    }
  }

  # We check for the function right now instead of $::pe_server_version
  # which does not get populated on agent nodes as some users use r10k
  # with razor see https://github.com/acidprime/r10k/pull/219
  if fact('is_pe') == true or fact('is_pe') == 'true' {
    # < PE 4
    $is_pe_server      = true
  } elsif is_function_available('pe_compiling_server_version') {
    # >= PE 4
    $is_pe_server      = true
  }
  else {
    # FOSS
    $is_pe_server      = false
  }

  if fact('pe_server_version') {
    # PE 4 or greater specific settings
    # r10k configuration

    $pe_module_path  = '/opt/puppetlabs/puppet/modules'

    # Mcollective configuration dynamic
    $mc_service_name  = 'mcollective'
    $plugins_dir      = '/opt/puppetlabs/mcollective/plugins/mcollective'
    $modulepath       = "${r10k_basedir}/\$environment/modules:${pe_module_path}"

    # webhook
    $webhook_user                  = 'peadmin'
    $webhook_pass                  = 'peadmin'
    $webhook_group                 = 'peadmin'
    $webhook_public_key_path       = '/var/lib/peadmin/.mcollective.d/peadmin-cert.pem'
    $webhook_private_key_path      = '/var/lib/peadmin/.mcollective.d/peadmin-private.pem'
    $webhook_certname              = 'peadmin'
    $webhook_certpath              = '/var/lib/peadmin/.mcollective.d'
    $root_user                     = 'root'
    $root_group                    = 'root'
  }
  elsif versioncmp($facts['puppetversion'], '4.0.0') >= 0 {
    #FOSS 4 or greater specific settings
    # r10k configuration

    $module_path     = '/opt/puppetlabs/puppet/code/modules'

    # webhook
    $webhook_user                  = 'puppet'
    $webhook_pass                  = 'puppet'
    $webhook_group                 = 'puppet'
    $webhook_public_key_path       = undef
    $webhook_private_key_path      = undef
    $webhook_certname              = undef
    $webhook_certpath              = undef
    $root_user                     = 'root'
    $root_group                    = 'root'
  }
  else {
    fail("Puppet version ${facts['puppetversion']} is no longer supported. Please use an earlier version of puppet/r10k.")
  }

  # prerun_command in puppet.conf
  $pre_postrun_command = "${r10k_binary} deploy environment -p"

  # Webhook configuration information
  $webhook_bind_address          = '*'
  $webhook_port                  = '8088'
  $webhook_access_logfile        = '/var/log/webhook/access.log'
  $webhook_client_cfg            = '/var/lib/peadmin/.mcollective'
  $webhook_default_branch        = 'production'
  $webhook_use_mco_ruby          = false
  $webhook_protected             = true
  $webhook_github_secret         = undef
  $webhook_gitlab_token          = undef
  $webhook_bitbucket_secret      = undef
  $webhook_discovery_timeout     = 10
  $webhook_client_timeout        = 120
  $webhook_prefix                = false         # ':repo' | ':user' | ':command' (or true for backwards compatibility) | 'string' | false
  $webhook_prefix_command        = '/bin/echo example'
  $webhook_server_software       = 'WebHook'
  $webhook_enable_ssl            = true
  $webhook_use_mcollective       = true
  $webhook_r10k_deploy_arguments = '-pv'
  $webhook_bin_template          = 'r10k/webhook.bin.erb'
  $webhook_yaml_template         = 'r10k/webhook.yaml.erb'
  $webhook_r10k_command_prefix   = 'umask 0022;' # 'sudo' is the canonical example for this
  $webhook_repository_events     = undef
  $webhook_enable_mutex_lock     = false
  $webhook_allow_uppercase       = true          # for backwards compatibility. Default to off on a major semver update.
  $webhook_slack_webhook         = undef
  $webhook_slack_channel         = undef
  $webhook_slack_username        = undef
  $webhook_slack_proxy_url       = undef
  $webhook_slack_icon            = undef
  $webhook_rocketchat_webhook    = undef
  $webhook_rocketchat_channel    = undef
  $webhook_rocketchat_username   = undef
  $webhook_configfile_owner      = 'root'
  $webhook_configfile_group      = $root_group
  $webhook_configfile_mode       = '0644'
  $webhook_ignore_environments   = []
  $webhook_mco_arguments         = undef
  if $facts['pe_server_version'] == '2016.4.2' {
    $webhook_sinatra_version       = '~> 1.0'
  } else {
    $webhook_sinatra_version       = 'installed'
  }
  $webhook_webrick_version       = 'installed'
  $webhook_generate_types        = false

  if $facts['os']['family'] == 'Gentoo' {
    $webhook_service_file      = '/etc/init.d/webhook'
    $webhook_service_template  = 'webhook.init.gentoo.erb'
    $webhook_service_file_mode = '0755'
    $webhook_background        = true
  } else {
    $webhook_service_file      = '/etc/systemd/system/webhook.service'
    $webhook_service_template  = 'webhook.service.erb'
    $webhook_service_file_mode = '0644'
    $webhook_background        = false
  }
}
