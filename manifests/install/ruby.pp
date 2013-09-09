# Install the r10k gem using system ruby
class r10k::install::ruby {

  # Breaking up my chaining a little here
  Class['::ruby'] -> Class['ruby::dev'] -> Package['gcc']

  # rubygems_update => false
  # https://projects.puppetlabs.com/issues/19741
  class { '::ruby':
    rubygems_update => false,
  }
  class { 'ruby::dev':
    tag => 'amineeded',
  }

  # I am not sure this is required as I assumed the
  # ruby::dev class would have taken care of it
  Package['gcc'] -> Package['make'] -> Package['r10k']

}
