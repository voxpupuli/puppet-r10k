# @summary Install the r10k mcollective agent
#
# @param ensure
# @param server
# @param client
# @param http_proxy
# @param policies
#
class r10k::mcollective (
  String[1] $ensure  = 'present',
  Boolean $server    = true,
  Boolean $client    = true,
  String $http_proxy = '', # lint:ignore:params_empty_string_assignment
  Array $policies    = [],
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
