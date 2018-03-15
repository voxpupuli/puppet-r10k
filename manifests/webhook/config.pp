# == Class: r10k::webhook::config
#
# Set up the root r10k config file (/etc/webhook.yaml).
#
# === Authors
#
# Zack Smith <zack@puppetlabs.com>
class r10k::webhook::config (
  $ensure                         = true,
  Variant[String, Hash] $hash     = 'UNSET',
  $certname                       = $r10k::params::webhook_certname,
  $certpath                       = $r10k::params::webhook_certpath,
  $user                           = $r10k::params::webhook_user,
  $pass                           = $r10k::params::webhook_pass,
  $bind_address                   = $r10k::params::webhook_bind_address,
  $port                           = $r10k::params::webhook_port,
  $access_logfile                 = $r10k::params::webhook_access_logfile,
  $client_cfg                     = $r10k::params::webhook_client_cfg,
  $default_branch                 = $r10k::params::webhook_default_branch,
  $use_mco_ruby                   = $r10k::params::webhook_use_mco_ruby,
  $protected                      = $r10k::params::webhook_protected,
  $github_secret                  = $r10k::params::webhook_github_secret,
  $discovery_timeout              = $r10k::params::webhook_discovery_timeout,
  $client_timeout                 = $r10k::params::webhook_client_timeout,
  $prefix                         = $r10k::params::webhook_prefix,
  $prefix_command                 = $r10k::params::webhook_prefix_command,
  $server_software                = $r10k::params::webhook_server_software,
  $enable_ssl                     = $r10k::params::webhook_enable_ssl,
  $use_mcollective                = $r10k::params::webhook_use_mcollective,
  $r10k_deploy_arguments          = $r10k::params::webhook_r10k_deploy_arguments,
  $public_key_path                = $r10k::params::webhook_public_key_path,
  $private_key_path               = $r10k::params::webhook_private_key_path,
  $yaml_template                  = $r10k::params::webhook_yaml_template,
  $command_prefix                 = $r10k::params::webhook_r10k_command_prefix,
  $repository_events              = $r10k::params::webhook_repository_events,
  $allow_uppercase                = $r10k::params::webhook_allow_uppercase,
  $slack_webhook                  = $r10k::params::webhook_slack_webhook,
  $slack_channel                  = $r10k::params::webhook_slack_channel,
  $slack_username                 = $r10k::params::webhook_slack_username,
  $slack_proxy_url                = $r10k::params::webhook_slack_proxy_url,
  $rocketchat_webhook             = $r10k::params::webhook_rocketchat_webhook,
  $rocketchat_channel             = $r10k::params::webhook_rocketchat_channel,
  $rocketchat_username            = $r10k::params::webhook_rocketchat_username,
  $configfile_owner               = $r10k::params::webhook_configfile_owner,
  $configfile_group               = $r10k::params::webhook_configfile_group,
  $configfile_mode                = $r10k::params::webhook_configfile_mode,
  $configfile                     = '/etc/webhook.yaml',
  $manage_symlink                 = false,
  $configfile_symlink             = '/etc/webhook.yaml',
  $enable_mutex_lock              = $r10k::params::webhook_enable_mutex_lock,
  Array $ignore_environments      = $r10k::params::webhook_ignore_environments,
  Optional[String] $mco_arguments = $r10k::params::webhook_mco_arguments,
  Boolean $generate_types         = $r10k::params::webhook_generate_types,
) inherits r10k::params {

  if $hash == 'UNSET' {
    $webhook_hash  = {
      'user'                  => $user,
      'pass'                  => $pass,
      'bind_address'          => $bind_address,
      'port'                  => $port,
      'certname'              => $certname,
      'client_timeout'        => $client_timeout,
      'discovery_timeout'     => $discovery_timeout,
      'certpath'              => $certpath,
      'client_cfg'            => $client_cfg,
      'default_branch'        => $default_branch,
      'use_mco_ruby'          => $use_mco_ruby,
      'access_logfile'        => $access_logfile,
      'protected'             => $protected,
      'github_secret'         => $github_secret,
      'prefix'                => $prefix,
      'prefix_command'        => $prefix_command,
      'server_software'       => $server_software,
      'enable_ssl'            => $enable_ssl,
      'use_mcollective'       => $use_mcollective,
      'r10k_deploy_arguments' => $r10k_deploy_arguments,
      'public_key_path'       => $public_key_path,
      'private_key_path'      => $private_key_path,
      'command_prefix'        => $command_prefix,
      'repository_events'     => $repository_events,
      'enable_mutex_lock'     => $enable_mutex_lock,
      'allow_uppercase'       => $allow_uppercase,
      'slack_webhook'         => $slack_webhook,
      'slack_channel'         => $slack_channel,
      'slack_username'        => $slack_username,
      'slack_proxy_url'       => $slack_proxy_url,
      'rocketchat_webhook'    => $rocketchat_webhook,
      'rocketchat_channel'    => $rocketchat_channel,
      'rocketchat_username'   => $rocketchat_username,
      'ignore_environments'   => $ignore_environments,
      'mco_arguments'         => $mco_arguments,
      'generate_types'        => $generate_types,
    }
  } else {
    $webhook_hash = $hash
  }

  $ensure_file = $ensure ? {
    true  => 'file',
    false => 'absent',
  }
  $ensure_link = $ensure ? {
    true  => 'link',
    false => 'absent',
  }

  file { 'webhook.yaml':
    ensure  => $ensure_file,
    owner   => $configfile_owner,
    group   => $configfile_group,
    mode    => $configfile_mode,
    path    => $configfile,
    content => template($yaml_template),
    notify  => Service['webhook'],
  }

  if $manage_symlink {
    file { 'symlink_webhook.yaml':
      ensure => $ensure_link,
      path   => $configfile_symlink,
      target => $configfile,
    }
  }
}
