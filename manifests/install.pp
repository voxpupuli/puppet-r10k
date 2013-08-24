# This class is used by the ruby or pe_ruby class
class r10k::install (
  $version,
  $provider = 'gem',
) {
  package { 'r10k':
    ensure   => $version,
    provider => $provider,
  }
}
