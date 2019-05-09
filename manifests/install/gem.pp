# Install the r10k gem using system ruby
class r10k::install::gem (
  $manage_ruby_dependency,
  $version,
) {
  require git
  anchor{'r10k::ruby_done':}
  case $manage_ruby_dependency {
    'include': {
      include ruby
      include ruby::dev
      Class['::ruby']
      -> Class['ruby::dev']
      -> Anchor['r10k::ruby_done']
    }
    'declare': {
      class { 'ruby':
        rubygems_update => false,
      }
      include ruby::dev
      Class['::ruby']
      -> Class['::ruby::dev']
      -> Anchor['r10k::ruby_done']
    }
    default: {
      #This catches the 'ignore' case, and satisfies the 'default' requirement
      #do nothing
    }
  }
}
