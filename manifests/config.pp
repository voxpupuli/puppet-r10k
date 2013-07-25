# == Class: r10k::config
#
# Set up the root r10k config file (/etc/r10k.yaml).
#
# === Parameters
#
# * [*cachedir*]
#   Path to a directory to be used by r10k for caching data.
#   Default: /var/cache/r10k
# * [*sources*]
#   Hash containing data sources to be used by r10k to create dynamic Puppet
#   environments. Default: {}
# * [*purgedirs*]
#   An Array of directory paths to purge of any subdirectories that do not
#   correspond to a dynamic environment managed by r10k. Default: []
#
# === Examples
#
#  class { 'r10k::config':
#    sources => {
#      'somename' => {
#        'remote'  => 'ssh://git@github.com/someuser/somerepo.git',
#        'basedir' => "${::settings::confdir}/environments"
#      },
#      'someothername' => {
#        'remote'  => 'ssh://git@github.com/someuser/someotherrepo.git',
#        'basedir' => '/some/other/basedir'
#      },
#    },
#    purgedirs => [
#      "${::settings::confdir}/environments",
#      '/some/other/basedir',
#    ],
#  }
#
# == Documentation
#
# * https://github.com/adrienthebo/r10k#dynamic-environment-configuration
#
# === Authors
#
# Charlie Sharpsteen <source@sharpsteen.net>
# Zack Smith <zack@puppetlabs.com>
class r10k::config (
  $cachedir    = '/var/cache/r10k',
  $sources     = {},
  $purgedirs   = $r10k::params::r10k_purgedirs,
  $configfile  = $r10k::params::r10k_config_file,
) inherits r10k::params {
  file { 'r10k.yaml':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    path    => $configfile,
    content => template("${module_name}/${configfile}.erb"),
  }

}
