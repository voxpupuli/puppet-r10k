# Reasonable defaults for all classes
class r10k::params {
  $package_name = $facts['os']['name'] ? {
    'OpenBSD' => 'ruby31-r10k',
    default   => 'r10k'
  }
  $version                = 'installed'
  $manage_modulepath      = false
  $manage_ruby_dependency = 'ignore'
  $root_user              = 'root'
  $root_group             = 'root'

  $provider = $facts['os']['name'] ? {
    'Archlinux' => 'pacman',
    'Gentoo'    => 'portage',
    default     => 'puppet_gem',
  }

  $puppet_master          = true

  if 'puppet_environment' in $facts {
    $r10k_basedir            = $facts['puppet_environmentpath']
  } else {
    $r10k_basedir            = '/etc/puppetlabs/code/environments'
  }
  $r10k_binary               = 'r10k'
  $pre_postrun_command       = "${r10k_binary} deploy environment --modules"
  $puppetconf_path           = '/etc/puppetlabs/puppet'
  # Git configuration
  $git_server = $settings::ca_server #lint:ignore:top_scope_facts
  $repo_path  = '/var/repos'
  $remote     = "ssh://${git_server}${repo_path}/modules.git"

  # Include the mcollective agent
  $mcollective = false

  case $facts['os']['family'] {
    'Debian': {
      $functions_path     = '/lib/lsb/init-functions'
      $start_pidfile_args = '--pidfile=$pidfile'
    }
    'SUSE': { $functions_path     = '/etc/rc.status' }
    default:  {
      $functions_path     = '/etc/rc.d/init.d/functions'
      $start_pidfile_args = '--pidfile $pidfile'
    }
  }

  # We check for the function right now instead of $::pe_server_version
  # which does not get populated on agent nodes as some users use r10k
  # with razor see https://github.com/acidprime/r10k/pull/219
  if fact('is_pe') == true or fact('is_pe') == 'true' {
    # < PE 4
    $is_pe_server      = true
    $pe_module_path = '/opt/puppetlabs/puppet/modules'
    $modulepath = "${r10k_basedir}/\$environment/modules:${pe_module_path}"
  }
  else {
    # FOSS
    $is_pe_server      = false
    $modulepath = "${r10k_basedir}/\$environment/modules"
  }
}
