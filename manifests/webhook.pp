# Class: r10k::webhook
#
#
class r10k::webhook (
  Boolean $ensure = $r10k::params::webhook_ensure,
  String $version = $r10k::params::webhook_version,
  Variant[
    Enum['running', 'stopped'],
    Boolean
  ] $service_ensure = $r10k::params::webhook_service_ensure,
  Boolean $service_enabled = $r10k::params::webhook_service_enabled,
  String $config_ensure                      = 'file',
  String $config_path                        = '/etc/voxpupuli/webhook.yml',
  R10k::Webhook::Config::ChatOps $chatops    = {
    enabled    => $r10k::params::webhook_chatops_enabled,
    service    => $r10k::params::webhook_chatops_service,
    channel    => $r10k::params::webhook_chatops_channel,
    user       => $r10k::params::webhook_chatops_user,
    auth_token => $r10k::params::webhook_chatops_token,
    server_uri => $r10k::params::webhook_chatops_uri,
  },
  R10k::Webhook::Config::Server::Tls $tls    = {
    enabled     => $r10k::params::webhook_tls_enabled,
    certificate => $r10k::params::webhook_tls_cert_path,
    key         => $r10k::params::webhook_tls_key_path,
  },
  R10k::Webhook::Config::Server $server      = {
    protected => $r10k::params::webhook_protected,
    user      => $r10k::params::webhook_user,
    password  => $r10k::params::webhook_password,
    port      => $r10k::params::webhook_port,
    tls       => $tls,
  },
  R10k::Webhook::Config::R10k $r10k = {
    command_path    => $r10k::params::webhook_r10k_command_path,
    config_path     => $r10k::params::webhook_r10k_config_path,
    default_branch  => $r10k::params::webhook_r10k_default_branch,
    prefix          => $r10k::params::webhook_r10k_branch_prefix,
    allow_uppercase => $r10k::params::webhook_r10k_allow_uppercase,
    verbose         => $r10k::params::webhook_r10k_verbose,
    deploy_modules  => $r10k::params::webhook_r10k_deploy_modules,
    generate_types  => $r10k::params::webhook_r10k_generate_types,
  },
  R10k::Webhook::Config $config              = {
    server  => $server,
    chatops => $chatops,
    r10k    => $r10k,
  },
) inherits r10k::params {
  contain r10k::webhook::package
  contain r10k::webhook::config
  contain r10k::webhook::service
}
