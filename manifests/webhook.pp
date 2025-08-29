# @summary install and configure the webhook-go package as local webhook receiver to trigger r10k runs
#
# @param service_user the user that should run the service
# @param install_method
#   how the package should be installed
# @param ensure
# @param version
# @param service_ensure
# @param service_enabled
# @param config_ensure
# @param config_path
# @param blocked_branches array of branches that the webhook will not deploy
# @param chatops
# @param tls
# @param queue
# @param server
# @param r10k
# @param config
#
class r10k::webhook (
  Optional $service_user = undef,
  Enum['package', 'repo', 'none'] $install_method = 'package',
  Boolean $ensure = false,
  String[1] $version = '2.10.0',
  Variant[
    Enum['running', 'stopped'],
    Boolean
  ] $service_ensure = 'running',
  Boolean $service_enabled = true,
  String $config_ensure                      = 'file',
  String $config_path                        = '/etc/voxpupuli/webhook.yml',
  Array[String[1]] $blocked_branches         = [],
  R10k::Webhook::Config::ChatOps $chatops    = {
    enabled    => false,
    service    => undef,
    channel    => undef,
    user       => undef,
    auth_token => undef,
    server_uri => undef,
  },
  R10k::Webhook::Config::Server::Tls $tls    = {
    enabled     => false,
    certificate => undef,
    key         => undef,
  },
  R10k::Webhook::Config::Server::Queue $queue    = {
    enabled             => false,
    max_concurrent_jobs => undef,
    max_history_items   => undef,
  },
  R10k::Webhook::Config::Server $server      = {
    protected => true,
    user      => 'puppet',
    password  => 'puppet',
    port      => 4000,
    tls       => $tls,
    queue     => $queue,
  },
  R10k::Webhook::Config::R10k $r10k = {
    command_path     => '/opt/puppetlabs/puppet/bin/r10k',
    config_path      => '/etc/puppetlabs/r10k/r10k.yaml',
    default_branch   => 'production',
    prefix           => undef,
    allow_uppercase  => false,
    verbose          => true,
    deploy_modules   => true,
    generate_types   => true,
    blocked_branches => $blocked_branches,
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

  Class['r10k::webhook::package']
  -> Class['r10k::webhook::config']
  ~> Class['r10k::webhook::service']
}
