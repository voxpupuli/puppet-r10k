# This class is used by the install class
class r10k::gen_types_script (
  Stdlib::Absolutepath $generate_types_script_location = $r10k::params::generate_types_script_location,
) inherits r10k::params {
  file { $generate_types_script_location:
    ensure => 'file',
    source => 'puppet://modules/modules/r10k/generate-puppet-types.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
