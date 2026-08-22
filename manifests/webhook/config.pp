# Class: r10k::webhook::config
#
#
class r10k::webhook::config (
) {
  file { '/etc/voxpupuli':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { 'webhook.yml':
    ensure  => $r10k::webhook::config_ensure,
    path    => $r10k::webhook::config_path,
    content => stdlib::to_yaml($r10k::webhook::config),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $r10k::webhook::github_token_path {
    file { '/etc/voxpupuli/r10k-git-credential-helper':
      ensure  => file,
      owner   => 'root',
      group   => $r10k::webhook::service_user,
      mode    => '0550',
      content => epp('r10k/r10k-git-credential-helper.epp', {
        'token_path' => shellquote($r10k::webhook::github_token_path),
      }),
    }

    file { '/etc/voxpupuli/r10k.gitconfig':
      ensure  => file,
      owner   => 'root',
      group   => $r10k::webhook::service_user,
      mode    => '0440',
      content => "[credential \"https://github.com\"]\n  helper = /etc/voxpupuli/r10k-git-credential-helper\n",
      require => [
        File['/etc/voxpupuli'],
        File['/etc/voxpupuli/r10k-git-credential-helper'],
      ],
    }
  }
}
