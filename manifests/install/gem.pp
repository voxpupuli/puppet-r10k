# Install the r10k gem using system ruby
class r10k::install::gem (
  $version,
) {

  # Ideally we would be singleton here but due to the bug we need the param.
  # If we are newer then the failure state, we do the right thing with include
  if versioncmp($::puppetversion,'3.2.2') > 0 {
    # https://projects.puppetlabs.com/issues/19663
    class { '::ruby':
      rubygems_update => false,
    }
  } else {
    include ruby
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
