class r10k::pe_ruby (
  $version,
) {
  require gcc
  require make

  package { 'r10k':
    ensure   => $version,
    provider => 'pe_gem',
  }

  # Setup the r10k configuration file
  file { $configfile :
    ensure  => present,
    content => template("${module_name}/${configfile}"),
  }
}
