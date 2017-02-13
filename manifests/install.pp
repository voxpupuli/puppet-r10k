# This class is used by the ruby or pe_ruby class
class r10k::install (
  $package_name,
  $version,
  $provider,
  $keywords,
  $install_options,
  $manage_ruby_dependency,
  $puppet_master = true,
  $is_pe_server = $r10k::params::is_pe_server,
  $install_gcc = false,
) inherits r10k::params {

  # There are currently bugs in r10k 1.x which make using 0.x desireable in
  # certain circumstances. However, 0.x requires make and gcc. Conditionally
  # include those classes if necessary due to 0.x r10k version usage. When
  # 1.x is just as good or better than 0.x, we can stop supporting 0.x and
  # remove this block.
  if versioncmp('1.0.0', $version) > 0 or $install_gcc {
    require ::gcc
    require ::make
  }

  if $package_name == '' {
    case $provider {
      'openbsd': {
                    if (versioncmp("${::kernelversion}", '5.8') < 0) { #lint:ignore:only_variable_string
                      $real_package_name = 'ruby21-r10k'
                    } else {
                      $real_package_name = 'ruby22-r10k'
                    }
                  }
      'portage': { $real_package_name = 'app-admin/r10k' }
      'yum':     { $real_package_name = 'rubygem-r10k' }
      default:   { $real_package_name = 'r10k' }
    }
  } else {
    $real_package_name = $package_name
  }

  case $provider {
    'bundle': {
      include ::r10k::install::bundle
    }
    'portage': {
      class { '::r10k::install::portage':
        package_name => $real_package_name,
        keywords     => $keywords,
        version      => $version,
      }
    }
    'puppet_gem', 'gem', 'openbsd', 'yum', 'zypper': {
      if $provider == 'gem' {
        class { '::r10k::install::gem':
          manage_ruby_dependency => $manage_ruby_dependency,
          version                => $version;
        }
      }
      elsif $provider == 'puppet_gem' {
        # Puppet FOSS 4.2 and up ships a vendor provided ruby.
        # Using puppet_gem uses that instead of the system ruby.
        include ::r10k::install::puppet_gem
      }

      # Currently we share a package resource to keep things simple
      # Puppet seems to have a bug (see #87 ) related to passing an
      # empty to value to the gem providers This code
      # converts an empty array to semi-standard gem options
      # This was previously undef but that caused strict var issues
      if $provider in ['puppet_gem', 'gem' ] and $install_options == [] {
        $provider_install_options = ['--no-ri', '--no-rdoc']
      } else {
        $provider_install_options = $install_options
      }

      # Puppet Enterprise 3.8 and ships an embedded r10k so thats all thats supported
      # This conditional should not effect FOSS customers based on the fact
      package { $real_package_name:
        ensure          => $version,
        provider        => $provider,
        install_options => $provider_install_options,
      }

    }
    default: { fail("${module_name}: ${provider} is not supported. Valid values are: 'gem', 'puppet_gem', 'bundle', 'openbsd', 'portage', 'yum', 'zypper'") }
  }
}
