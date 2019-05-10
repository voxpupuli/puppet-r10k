# @summary
#   This class handles the R10k postrun command.
#
# @param ensure
#   Whether to configure the R10k postrun command.
#
# @param command
#   Specifies a command to run after every agent run.
#
class r10k::postrun_command (
  Enum['present', 'absent'] $ensure = 'present',
  String[1] $command                = 'deploy environment -p',
) {

  $binary = pick_default($facts['r10k_path'], '/bin/r10k')

  ini_setting { 'r10k_postrun_command':
    ensure  => $ensure,
    path    => $settings::config,
    section => 'agent',
    setting => 'postrun_command',
    value   => "${binary} ${command}",
  }
}
