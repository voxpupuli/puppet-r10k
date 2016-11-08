# This class links the r10k binary for PE
class r10k::install::pe_gem (
  $puppet_master,
) {

  require git

  # Puppet Enterprise 3.8 ships code to manage this symlink on install
  # This conditional should not effect FOSS customers based on the fact
  unless versioncmp("${::pe_version}", '3.8.0') >= 0 and $puppet_master { #lint:ignore:only_variable_string
    file { '/usr/bin/r10k':
      ensure  => link,
      target  => '/opt/puppet/bin/r10k',
      require => Package['r10k'],
    }
  }
}
