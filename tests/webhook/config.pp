class {'r10k::webhook::config':
  prefix         => true,
  prefix_command => '/bin/echo test',
}
