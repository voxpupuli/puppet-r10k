# @summary
#   This class handles the R10k prerun command.
#
# @param ensure
#   Whether to configure the R10k prerun command.
#
# @param command
#   Specifies a command to run before every agent run.
#
class r10k::prerun_command (
  Enum['present', 'absent'] $ensure = 'present',
  String[1] $command                = 'deploy environment -p',
) {

  $binary = pick_default($facts['r10k_path'], '/bin/r10k')

  ini_setting { 'r10k_prerun_command':
    ensure  => $ensure,
    path    => $settings::config,
    section => 'agent',
    setting => 'prerun_command',
    value   => "${binary} ${command}",
  }
}
