class r10k::install::portage (
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

  portage::package { 'app-admin/r10k':
    ensure   => $version,
    keywords => $keywords,
    target   => 'puppet',
  }
}
