# This class will configure r10k to run as part of the masters agent run
class r10k::postrun_command (
  $command = $r10k::params::pre_postrun_command,
  $ensure  = 'present',
) inherits r10k::params {

  validate_re($ensure, [ '^present', '^absent' ],
  'ensure must be either present or absent')

  ini_setting { 'r10k_postrun_command':
    ensure  => $ensure,
    path    => "${r10k::params::puppetconf_path}/puppet.conf",
    section => 'agent',
    setting => 'postrun_command',
    value   => $command,
  }
}
