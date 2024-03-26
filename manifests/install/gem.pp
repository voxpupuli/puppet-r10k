# @summary Install the r10k gem using system ruby
#
# @param manage_ruby_dependency
# @param version
#   R10k gem version
#
class r10k::install::gem (
  String[1] $manage_ruby_dependency,
  String[1] $version,
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
