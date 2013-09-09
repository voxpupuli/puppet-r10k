# This class is used by the ruby or pe_ruby class
class r10k::install (
  $version,
  $pe_ruby,
) {
  require gcc
  require make

  if $pe_ruby {
    $provider = 'pe_gem'
  } else {
    $provider = 'gem'
    include 'r10k::install::ruby'
  }

  package { 'r10k':
    ensure   => $version,
    provider => $provider,
  }

}
