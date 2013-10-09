# This class will configure r10k to run as part of the masters agent run
class r10k::prerun_command (
  $command = $r10k::params::prerun_command
) inherits r10k::params {

  Ini_setting {
    path    => "$puppetconf_path/puppet.conf",
    ensure  => present,
    section => 'agent',
  }

  ini_setting { 'r10k_prerun_command':
    setting => 'prerun_command',
    value   => $command,
  }
}
