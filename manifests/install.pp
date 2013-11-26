# This class is used by the ruby or pe_ruby class
class r10k::install (
  $version,
  $provider,
  $keywords,
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

  case $provider {
    'bundle': {
      include r10k::install::bundle
    }
    'portage': {
      class { 'r10k::install::portage':
        keywords => $keywords,
        version  => $version,
      }
    }
    'pe_gem', 'gem': {
      if $provider == 'gem' {
        class { 'r10k::install::gem': version => $version; }
      }
      elsif $provider == 'pe_gem' {
        include r10k::install::pe_gem
      }
      package { 'r10k':
        ensure   => $version,
        provider => $provider,
      }
    }
    default: { fail("$provider is not supported. Valid values are: 'gem', 'pe_gem', 'bundle', 'portage'") }
  }
}
