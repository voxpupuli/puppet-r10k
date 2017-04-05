# Install the r10k gem using system ruby
class r10k::install::gem (
  $manage_ruby_dependency,
  $version,
) {
  require ::git
  anchor{'r10k::ruby_done':}
  case $manage_ruby_dependency {
    'include': {
      include ::ruby
      include ::ruby::dev
      Class['::ruby']
      -> Class['ruby::dev']
      -> Anchor['r10k::ruby_done']
    }
    'declare': {
      class { '::ruby':
        rubygems_update => false,
      }
      include ::ruby::dev
      Class['::ruby']
      -> Class['::ruby::dev']
      -> Anchor['r10k::ruby_done']
    }
    default: {
      #This catches the 'ignore' case, and satisfies the 'default' requirement
      #do nothing
    }
  }

  # Explicit dependency chaining to make sure the system is ready to compile
  # native extentions for dependent rubygems by the time r10k installation
  # begins
  if versioncmp('1.0.0', $version) > 0 {
    # I am not sure all of this is required as I assumed the
    # ruby::dev class would have taken care of some of it
    include ::make
    include ::gcc

    Anchor['r10k::ruby_done']
    -> Class['gcc']
    -> Class['make']
    -> Package['r10k']
  }

}
