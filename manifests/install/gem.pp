# Install the r10k gem using system ruby
class r10k::install::gem (
  $manage_ruby_dependency,
  $version,
) {
  case $manage_ruby_dependency {
    'include': {
      include ruby
      require ruby::dev
      Class['ruby'] -> Class['ruby::dev']
    }
    'declare': {
      class { 'ruby':
        rubygems_update => false,
      }
      require ruby::dev
      Class['ruby'] -> Class['ruby::dev']
    }
    default: {
      #This catches the 'ignore' case, and satisfies the 'default' requirement
      #do nothing
    }
  }
}
