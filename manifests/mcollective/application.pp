# Install the r10k mcollective application to a client
class r10k::mcollective::application(
  $agent_name        = $r10k::params::mc_agent_name,
  $app_name          = $r10k::params::mc_app_name,
  $agent_ddl         = $r10k::params::mc_agent_ddl_name,
  $agent_path        = $r10k::params::mc_agent_path,
  $app_path          = $r10k::params::mc_application_path,
  $mc_service        = $r10k::params::mc_service_name,
) inherits r10k::params {

  require ::r10k

  File {
    ensure => present,
    owner  => $::r10k::root_user,
    group  => $::r10k::root_group,
    mode   => '0644',
  }
  # Install the agent and its ddl file
  file { 'mcollective_application_exec':
    path   => "${app_path}/${app_name}",
    source => "puppet:///modules/${module_name}/application/${agent_name}",
  }

  file { 'mcollective_application_ddl':
    path   => "${agent_path}/${agent_ddl}",
    source => "puppet:///modules/${module_name}/agent/${agent_ddl}",
  }

}
