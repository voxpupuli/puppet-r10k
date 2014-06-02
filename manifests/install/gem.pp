# Install the r10k gem using system ruby
class r10k::install::gem (
  $version,
) {

  require git

  class { '::ruby':
    rubygems_update => false,
  }

  include ruby::dev

  # Explicit dependency chaining to make sure the system is ready to compile
  # native extentions for dependent rubygems by the time r10k installation
  # begins
  if versioncmp('1.0.0', $version) > 0 {
    # I am not sure all of this is required as I assumed the
    # ruby::dev class would have taken care of some of it
    include make
    include gcc

    Class['::ruby']    ->
    Class['ruby::dev'] ->
    Class['gcc']       ->
    Class['make']      ->
    Package['r10k']
  }

}
