#!/opt/puppet/bin/ruby
require 'json'

if STDIN.tty?
  puts 'invalid'
  puts 'This command is meant be launched by webhook'
else
  data = JSON.parse(STDIN.read)
  description = data['repository']['description']
  puts description
end
