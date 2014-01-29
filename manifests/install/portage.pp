# This class is used to install r10k from portage
class r10k::install::portage (
  $package_name,
  $keywords,
  $version,
) {

  if $keywords {
    package_keywords { 'dev-ruby/cri':
      keywords => $keywords,
      target   => 'puppet',
      before   => Portage::Package['app-admin/r10k'],
    }
    package_keywords { 'dev-ruby/colored':
      keywords => $keywords,
      target   => 'puppet',
      before   => Portage::Package['app-admin/r10k'],
    }
  }

  portage::package { $package_name:
    ensure   => $version,
    keywords => $keywords,
    target   => 'puppet',
  }
}
