# @summary Install the r10k mcollective application to a client
#
# @param agent_name
# @param app_name
# @param agent_ddl
# @param agent_path
# @param app_path
# @param mc_service
#
class r10k::mcollective::application (
  Optional[String] $agent_name = $r10k::params::mc_agent_name,
  Optional[String] $app_name   = $r10k::params::mc_app_name,
  Optional[String] $agent_ddl  = $r10k::params::mc_agent_ddl_name,
  Optional[String] $agent_path = $r10k::params::mc_agent_path,
  Optional[String] $app_path   = $r10k::params::mc_application_path,
  Optional[String] $mc_service = $r10k::params::mc_service_name,
) inherits r10k::params {
  require r10k

  File {
    ensure => present,
    owner  => $r10k::root_user,
    group  => $r10k::root_group,
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
