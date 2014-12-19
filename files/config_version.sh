#!/bin/bash
# Create a environment.conf in your control repo
# and set the path to this script i.e.
# config_version = scripts/config_version.sh $environment
# https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html#configversion
# Don't forget to restart pe-puppetserver/pe-httpd to pickup on the new config_version
# Return the latest commit with the GitHub URL for it
# The repos are placed using r10k

# Get the hash of the latest commit
sha=$(git --git-dir \
  /etc/puppetlabs/puppet/environments/$1/.git rev-parse HEAD)

message=$(git --git-dir \
  /etc/puppetlabs/puppet/environments/$1/.git log -1 --pretty='%s')

# Get the address for remote origin
remote=$(git --git-dir \
  /etc/puppetlabs/puppet/environments/$1/.git config --get remote.origin.url)

# Sanitize the git remote to be an http url.
#url=$(echo "${remote}"|/bin/sed -e 's/git@//g; s/:/\//g; s/.git$//g')
url=$(echo "${remote}"| awk -F'[@:]' '{ sub(/.git$/,"");print "http://"$2"/"$3}')

# Return a full URL for it
echo "[${message}](${url}/tree/${sha})"
