#!/opt/puppet/bin/ruby
require 'json'
require 'yaml'

if STDIN.tty?
  puts 'This command is meant be launched by webhook'
else
  prefixes = YAML.load_file('/etc/r10k.yaml')

  json_data = JSON.parse(STDIN.read)
  url = json_data['repository']['url']

  prefix = prefixes[:sources].each.map do |key,value|
    key if url == value['remote']
  end.compact

  puts prefix
end
