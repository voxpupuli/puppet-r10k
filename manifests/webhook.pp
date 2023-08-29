#
# @summary install and configure the webhook-go package as local webhook receiver to trigger r10k runs
#
# @param install_method how the package should be installed
#
class r10k::webhook (
  Enum['package', 'repo', 'none'] $install_method = 'package',
  Boolean $ensure = false,
  String $version = '2.1.0',
  Variant[
    Enum['running', 'stopped'],
    Boolean
  ] $service_ensure = 'running',
  Boolean $service_enabled = true,
  String $config_ensure                      = 'file',
  String $config_path                        = '/etc/voxpupuli/webhook.yml',
  R10k::Webhook::Config::ChatOps $chatops    = {
    enabled    => false,
    service    => '',
    channel    => '',
    user       => '',
    auth_token => '',
    server_uri => '',
  },
  R10k::Webhook::Config::Server::Tls $tls    = {
    enabled     => false,
    certificate => undef,
    key         => undef,
  },
  R10k::Webhook::Config::Server $server      = {
    protected => true,
    user      => 'puppet',
    password  => 'puppet',
    port      => 4000,
    tls       => $tls,
  },
  R10k::Webhook::Config::R10k $r10k = {
    command_path    => '/opt/puppetlabs/puppet/bin/r10k',
    config_path     => '/etc/puppetlabs/r10k/r10k.yaml',
    default_branch  => 'production',
    prefix          => '',
    allow_uppercase => false,
    verbose         => true,
    deploy_modules  => true,
    generate_types  => true,
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
