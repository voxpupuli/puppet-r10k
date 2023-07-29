#
# @summary This class is used by the ruby or pe_ruby class
#
# @api private
#
class r10k::install {
  assert_private()

  case $r10k::provider {
    'bundle': {
      include r10k::install::bundle
    }
    'puppet_gem', 'gem', 'openbsd', 'pkgng', 'pacman', 'portage': {
      if $r10k::provider == 'gem' {
        class { 'r10k::install::gem':
          manage_ruby_dependency => $r10k::manage_ruby_dependency,
          version                => $r10k::version;
        }
      }
      elsif $r10k::provider == 'puppet_gem' {
        # Puppet FOSS 4.2 and up ships a vendor provided ruby.
        # Using puppet_gem uses that instead of the system ruby.
        include r10k::install::puppet_gem
      }

      # Currently we share a package resource to keep things simple
      # Puppet seems to have a bug (see #87 ) related to passing an
      # empty to value to the gem providers This code
      # converts an empty array to semi-standard gem options
      # This was previously undef but that caused strict var issues
      if $r10k::provider in ['puppet_gem', 'gem'] and $r10k::install_options == [] {
        $provider_install_options = ['--no-document']
      } else {
        $provider_install_options = $r10k::install_options
      }

      # Puppet Enterprise 3.8 and ships an embedded r10k so thats all thats supported
      # This conditional should not effect FOSS customers based on the fact
      package { $r10k::package_name:
        ensure          => $r10k::version,
        provider        => $r10k::provider,
        source          => $r10k::gem_source,
        install_options => $provider_install_options,
      }
    }
    default: { fail("${module_name}: ${r10k::provider} is not supported. Valid values are: 'gem', 'puppet_gem', 'bundle', 'openbsd'") }
  }
}
