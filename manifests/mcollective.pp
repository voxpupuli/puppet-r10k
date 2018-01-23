# Install the r10k mcollective agent
class r10k::mcollective (
  $ensure            = true,
  $agent_name        = $r10k::params::mc_agent_name,
  $app_name          = $r10k::params::mc_app_name,
  $agent_ddl         = $r10k::params::mc_agent_ddl_name,
  $agent_path        = $r10k::params::mc_agent_path,
  $app_path          = $r10k::params::mc_application_path,
  $mc_service        = $r10k::params::mc_service_name,
  $http_proxy        = $r10k::params::mc_http_proxy,
  $git_ssl_no_verify = $r10k::params::mc_git_ssl_no_verify,
  $root_user         = $r10k::params::root_user,
  $root_group        = $r10k::params::root_group,
) inherits r10k::params {
  $ensure_file = $ensure ? {
    true  => 'file',
    false => 'absent',
  }

  File {
    ensure => $ensure_file,
    owner  => $root_user,
    group  => $root_group,
    mode   => '0644',
  }

  # Install the agent and its ddl file
  file { 'mcollective_agent_executable':
    path   => "${app_path}/${app_name}",
    source => "puppet:///modules/${module_name}/application/${agent_name}",
  }

  file { 'mcollective_agent_ddl':
    path   => "${agent_path}/${agent_ddl}",
    source => "puppet:///modules/${module_name}/agent/${agent_ddl}",
  }

  # Install the application file (all masters at the moment)
  file { 'mcollective_application_file':
    path    => "${agent_path}/${agent_name}",
    content => template("${module_name}/agent/${agent_name}.erb"),
    require => File["${agent_path}/${agent_ddl}"],
  }

  Service <| title == $mc_service |> {
    subscribe +> [
      File['mcollective_agent_executable'],
      File['mcollective_agent_ddl'],
      File['mcollective_application_file']
    ],
  }
}
