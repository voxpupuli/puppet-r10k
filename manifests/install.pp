# This class is used by the ruby or pe_ruby class
class r10k::install (
  $package_name,
  $version,
  $provider,
  $keywords,
  $install_options,
  $manage_ruby_dependency,
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

  if $package_name == '' {
    case $provider {
      'portage': { $real_package_name = 'app-admin/r10k' }
      'yum':     { $real_package_name = 'rubygem-r10k' }
      default:   { $real_package_name = 'r10k' }
    }
  } else {
    $real_package_name = $package_name
  }

  case $provider {
    'bundle': {
      include r10k::install::bundle
    }
    'portage': {
      class { 'r10k::install::portage':
        package_name => $real_package_name,
        keywords     => $keywords,
        version      => $version,
      }
    }
    'pe_gem', 'gem', 'yum', 'zypper': {
      if $provider == 'gem' {
        class { 'r10k::install::gem':
          manage_ruby_dependency => $manage_ruby_dependency,
          version                => $version;
        }
      }
      elsif $provider == 'pe_gem' {
        include r10k::install::pe_gem
      }


      # Currently we share a package resource to keep things simple
      # Puppet seems to have a bug (see #87 ) related to passing an
      # empty to value to the gem,pe_gem providers. This code
      # converts an empty array to semi-standard gem options
      # This was previously undef but that caused strict var issues
      if $provider in ['pe_gem','gem' ] and $install_options == [] {
        $provider_install_options = ['--no-ri', '--no-rdoc']
      } else {
        $provider_install_options = $install_options
      }

      # Puppet Enterprise 3.8 and ships an embedded r10k so thats all thats supported
      # This conditional should not effect FOSS customers based on the fact
      unless versioncmp($::pe_version, '3.8.0') >= 0 {
        package { $real_package_name:
          ensure          => $version,
          provider        => $provider,
          install_options => $provider_install_options
        }
      }
    }
    default: { fail("${provider} is not supported. Valid values are: 'gem', 'pe_gem', 'bundle', 'portage', 'yum', 'zypper'") }
  }
}
