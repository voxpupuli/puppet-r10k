# frozen_string_literal: true

require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  on host, puppet('resource', 'user', 'puppet', 'ensure=present')
end
