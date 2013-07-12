class r10k::pe {
  require gcc
  require make

  package { 'r10k':
    ensure   => '1.0.0',
    provider => 'pe_gem',
  }

  # Setup the r10k configuration file
  file { $configfile :
    ensure  => present,
    content => template("${module_name}/${configfile}"),
  }
}
