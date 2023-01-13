#!/bin/sh
# This file is managed by voxpupuli/puppet-r10k

for environment in $@; do
  /opt/puppetlabs/bin/puppet generate types --environment $environment
done
