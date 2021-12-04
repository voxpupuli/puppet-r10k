# Install the r10k mcollective agent
class r10k::mcollective (
  $ensure            = 'present',
  $server            = true,
  $client            = true,
  $http_proxy        = '',
  $policies          = [],
) inherits r10k::params {
  include mcollective
  mcollective::module_plugin { 'mcollective_agent_r10k':
    ensure        => $ensure,
    server        => $server,
    client        => $client,
    server_config => {
      'http_proxy' => $http_proxy,
    },
    config_name   => 'r10k',
    common_files  => [
      'agent/r10k.ddl',
      'agent/r10k.json',
    ],
    server_files  => [
      'agent/r10k.rb',
    ],
    client_files  => [
      'application/r10k.rb',
    ],
    policies      => $policies,
  }
}
