# This class is used by the ruby or pe_ruby class
class r10k::install (
  $version,
  $pe_ruby,
) {

  # There are currently bugs in r10k 1.x which make using 0.x desireable in
  # certain circumstances. However, 0.x requires make and gcc. Conditionally
  # include those classes if necessary due to 0.x r10k version usage. When
  # 1.x is just as good or better than 0.x, we can stop supporting 0.x and
  # remove this block.
  if versioncmp('1.0.0', $version) > 0 {
    require gcc
    require make
  }

  if $pe_ruby {
    $provider = 'pe_gem'
  } else {
    $provider = 'gem'
    class { 'r10k::install::ruby': version => $version; }
  }

  package { 'r10k':
    ensure   => $version,
    provider => $provider,
  }

}
