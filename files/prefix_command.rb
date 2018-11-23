#!/usr/bin/env ruby
require 'json'
require 'yaml'

if STDIN.tty?
  puts 'This command is meant be launched by webhook'
else
  prefixes = YAML.load_file('/etc/r10k.yaml')

  json_data = JSON.parse(STDIN.read)
  url = json_data['repository']['url']

  prefix = ""

  prefixes[:sources].each do |key,value|
    if url == value['remote'] then
      if value['prefix'] == true
        prefix = key
      elsif value['prefix'].is_a? String
        prefix = value['prefix']
      end
    end
  end

  puts prefix
end
