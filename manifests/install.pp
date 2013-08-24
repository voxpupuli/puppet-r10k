class r10k::install (
  $version,
  $provider = 'gem',
) {
  package { 'r10k':
    ensure   => $version,
    provider => $provider,
  }
}
