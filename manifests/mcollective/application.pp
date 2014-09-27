# Install the r10k mcollective application to a client
class r10k::mcollective::application(
  $agent_name        = $r10k::params::mc_agent_name,
  $app_name          = $r10k::params::mc_app_name,
  $agent_ddl         = $r10k::params::mc_agent_ddl_name,
  $agent_path        = $r10k::params::mc_agent_path,
  $app_path          = $r10k::params::mc_application_path,
  $mc_service        = $r10k::params::mc_service_name,
) inherits r10k::params {
  File {
    ensure => present,
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }
  # Install the agent and its ddl file
  file { "${app_path}/${app_name}"  :
    source => "puppet:///modules/${module_name}/application/${agent_name}",
  }

  file { "${agent_path}/${agent_ddl}"  :
    source => "puppet:///modules/${module_name}/agent/${agent_ddl}",
  }

}
