include ::r10k::webhook

file {'/usr/local/bin/prefix_command.rb':
  ensure => file,
  mode   => '0755',
  owner  => 'root',
  group  => '0',
  source => 'puppet:///modules/r10k/prefix_command.rb',
}

class {'::r10k::webhook::config':
  prefix         => true,
  prefix_command => '/usr/local/bin/prefix_command.rb',
  enable_ssl     => false,
  protected      => false,
  notify         => Service['webhook'],
  require        => File['/usr/local/bin/prefix_command.rb'],
}
