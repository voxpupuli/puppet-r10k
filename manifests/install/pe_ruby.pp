class r10k::install::pe_ruby (
  $version,
) {
  require gcc
  require make

  class { 'r10k::install':
    version  => $version,
    provider => 'pe_gem',
  }
}
