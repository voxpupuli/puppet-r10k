#!/usr/bin/env ruby
#
# This script is meant to be used with the external hooks script for Stash:
# https://marketplace.atlassian.com/plugins/com.ngs.stash.externalhooks.external-hooks
#
# The above plugin is used instead of the "Atlassian Post-Receive 
# Webhooks plugin" because the Atlassian plugin does not support ignoring
# ssl self signed certificates.
# 
# The external hook is useful beyond just this script, thus I prefer it.
#
require 'getoptlong'

opts = GetoptLong.new(
  [ '--target',   '-t', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--insecure', '-k', GetoptLong::NO_ARGUMENT ],
  [ '--help',     '-h', GetoptLong::NO_ARGUMENT ]
)

target = nil
insecure = nil

opts.each do |opt,arg|
  case opt
  when '--help'
    puts <<-EOF
stash_mco.rb [OPTIONS]

-h, --help
  show help

-t, --target [url]
  the target url to post to
  example: https://puppet:puppet@localhost:8088/payload
  user/pass should be specified as part of the target

-k, --insecure
  pass the 'insecure' flag to curl to ignore ssl cert verification
    EOF

  when '--target'
    target = arg
  when '--insecure'
    insecure = '-k'
  end
end

# the external-hooks script passes the following on stdin
#
# old_hash new_hash ref/ref/ref
# 
# for example:
# 0000000000000000000000000000000000000000 ad91e3697d0711985e06d5bbbf6a7c5dc3b657f7 refs/heads/production
#
# All we care about is refs/heads/<branch_name>
#
# Test this script with:
# echo "000000 123456 refs/heads/production" | stash_mco.rb -k -t https://puppet:puppet@localhost:8088/payload

while post = gets
  post_data =  "{ \"ref\": \"#{post.split[2]}\" }"
end

system( "curl -q #{insecure} -d '#{post_data}' -H 'Accept: application/json' #{target}")

