#!/usr/bin/env ruby
require 'json'
require 'yaml'

if STDIN.tty?
  puts 'This command is meant be launched by webhook'
else
  prefixes = YAML.load_file('/etc/r10k.yaml')

  json_data = JSON.parse(STDIN.read)
  url = json_data['repository']['url']

  bitbucket = json_data['repository'].has_key?('full_name')

  if bitbucket then
    url = json_data['repository']['links']['html']['href'].gsub('https://bitbucket.org/', '').concat('.git')
  else
    url = json_data['repository']['url']
  end

  prefix = ""

  prefixes[:sources].each do |key, value|
    if bitbucket then
      if url == value['remote'].gsub('https://bitbucket.org/', '').gsub('git@bitbucket.org:', '') then
        if value['prefix'] == true
          prefix = key
        elsif value['prefix'].is_a? String
          prefix = value['prefix']
        end
      end
    else
      if url == value['remote'] then
        if value['prefix'] == true
          prefix = key
        elsif value['prefix'].is_a? String
          prefix = value['prefix']
        end
      end
    end
  end

  puts prefix
end
