# This class will configure r10k to run as part of the masters agent run
class r10k::postrun_command (
  $command                          = $r10k::params::pre_postrun_command,
  Enum['present', 'absent'] $ensure = 'present',
) inherits r10k::params {

  ini_setting { 'r10k_postrun_command':
    ensure  => $ensure,
    path    => "${r10k::params::puppetconf_path}/puppet.conf",
    section => 'agent',
    setting => 'postrun_command',
    value   => $command,
  }
}
