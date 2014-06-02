# This class will configure r10k to run as part of the masters agent run
class r10k::postrun_command (
  $command = $r10k::params::postrun_command,
  $ensure  = 'present',
) inherits r10k::params {

  validate_re($ensure, [ '^present', '^absent' ],
  'ensure must be either present or absent')

  Ini_setting {
    path    => "${r10k::params::puppetconf_path}/puppet.conf",
    ensure  => $ensure,
    section => 'agent',
  }

  ini_setting { 'r10k_postrun_command':
    setting => 'postrun_command',
    value   => $command,
  }
}
