# Reasonable defaults for all classes
class r10k::params {
  $package_name           = ''
  $version                = 'installed'
  $manage_modulepath      = false
  $manage_ruby_dependency = 'ignore'
  $root_user              = 'root'
  $root_group             = 'root'

  $provider = $facts['os']['name'] ? {
    'Archlinux' => 'pacman',
    'Gentoo'    => 'portage',
    default     => 'puppet_gem',
  }

  $install_options        = []
  $sources                = undef
  $puppet_master          = true
  $proxy                  = undef
  $pool_size              = $facts['processors']['count']
  $gem_source             = undef

  if 'puppet_environment' in $facts {
    $r10k_basedir            = $facts['puppet_environmentpath']
  } else {
    $r10k_basedir            = '/etc/puppetlabs/code/environments'
  }
  $r10k_cache_dir            = "${facts['puppet_vardir']}/r10k"
  $r10k_config_file          = '/etc/puppetlabs/r10k/r10k.yaml'
  $r10k_binary               = 'r10k'
  $pre_postrun_command       = "${r10k_binary} deploy environment -p"
  $puppetconf_path           = '/etc/puppetlabs/puppet'
  $manage_configfile_symlink = false
  $configfile_symlink        = '/etc/r10k.yaml'
  $git_settings              = {}
  $forge_settings            = {}
  $deploy_settings           = {}
  # Git configuration
  $git_server = $settings::ca_server #lint:ignore:top_scope_facts
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
    $pe_module_path = '/opt/puppetlabs/puppet/modules'
    $modulepath = "${r10k_basedir}/\$environment/modules:${pe_module_path}"
  }
  else {
    # FOSS
    $is_pe_server      = false
    $modulepath = "${r10k_basedir}/\$environment/modules"
  }

  # Webhook Go parameters
  $webhook_protected = true
  $webhook_version = '2.1.0'
  $webhook_user = 'puppet'
  $webhook_password = 'puppet'
  $webhook_port = 4000
  $webhook_tls_enabled = false
  $webhook_tls_cert = ''
  $webhook_tls_key = ''
  $webhook_chatops_enabled = false
  $webhook_chatops_service = ''
  $webhook_chatops_channel = ''
  $webhook_chatops_user = ''
  $webhook_chatops_token = ''
  $webhook_chatops_uri = ''
  $webhook_r10k_command_path = "/opt/puppetlabs/puppet/bin/${r10k_binary}"
  $webhook_r10k_config_path = $r10k_config_file
  $webhook_r10k_default_branch = 'production'
  $webhook_r10k_branch_prefix = ''
  $webhook_r10k_allow_uppercase = false
  $webhook_r10k_verbose = true
  $webhook_r10k_deploy_modules = true
  $webhook_r10k_generate_types = true
  $webhook_service_ensure = 'running'
  $webhook_service_enabled = true
}
