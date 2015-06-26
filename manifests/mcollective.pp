# Install the r10k mcollective agent
class r10k::mcollective (
  $agent_name        = $r10k::params::mc_agent_name,
  $app_name          = $r10k::params::mc_app_name,
  $agent_ddl         = $r10k::params::mc_agent_ddl_name,
  $agent_path        = $r10k::params::mc_agent_path,
  $app_path          = $r10k::params::mc_application_path,
  $mc_service        = $r10k::params::mc_service_name,
  $http_proxy        = $r10k::params::mc_http_proxy,
  $git_ssl_verify    = $r10k::params::mc_git_ssl_verify, # Deprecated
  $git_ssl_no_verify = $r10k::params::mc_git_ssl_no_verify,
) inherits r10k::params {
  File {
    ensure => present,
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }

  if $git_ssl_verify {
    warning('$git_ssl_verify parameter is deprecated, please use $git_ssl_no_verify instead')
    $agent_no_verify = $git_ssl_verify
  } else {
    $agent_no_verify = $git_ssl_no_verify
  }

  # Install the agent and its ddl file
  file { "${app_path}/${app_name}":
    source => "puppet:///modules/${module_name}/application/${agent_name}",
  }

  file { "${agent_path}/${agent_ddl}":
    source => "puppet:///modules/${module_name}/agent/${agent_ddl}",
  }

  # Install the application file (all masters at the moment)
  file { "${agent_path}/${agent_name}":
    content => template("${module_name}/agent/${agent_name}.erb"),
    require => File["${agent_path}/${agent_ddl}"],
  }

  Service <| name == $mc_service |> {
    subscribe +> [ File["${app_path}/${app_name}"], File["${agent_path}/${agent_ddl}"] ],
  }
}
