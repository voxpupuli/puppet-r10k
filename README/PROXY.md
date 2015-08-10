
```puppet
# Create a global gemrc for Puppet Enterprise to add the local gem source
# See http://projects.puppetlabs.com/issues/18053#note-12 for more information.

file { '/opt/puppet/etc':
  ensure => 'directory',
  owner  => 'root',
  group  => '0',
  mode   => '0755',
}

file { 'gemrc':
  ensure  => 'file',
  path    => '/opt/puppet/etc/gemrc',
  owner   => 'root',
  group   => '0',
  mode    => '0644',
  content => "---\ngem: --http-proxy=http://your.proxy.server:8080\n",
}

class { 'r10k':
  remote   => 'git@github.com:someuser/puppet.git',
  provider => 'pe_gem',
  require  => File['gemrc'],
}

# The following will allow r10k to use Puppetfile via the proxy
file { '/root/.gitconfig':
  ensure => 'file',
  owner  => 'root',
  group  => '0',
  mode   => '0600',
}

# https://forge.puppetlabs.com/puppetlabs/inifile
Ini_setting {
  ensure  => present,
  path    => '/root/.gitconfig',
  value   => 'http://proxy.your.company.com:8080',
}

ini_setting { 'git http proxy setting':
  section => 'http',
  setting => 'proxy',
}

ini_setting { 'git https proxy setting':
  section => 'https',
  setting => 'proxy',
}
```

Using a internal gem server
```puppet
# Create a global gemrc for Puppet Enterprise to add the local gem source
# See http://projects.puppetlabs.com/issues/18053#note-12 for more information.

file { '/opt/puppet/etc':
  ensure => 'directory',
  owner  => 'root',
  group  => '0',
  mode   => '0755',
}

file { 'gemrc':
  ensure  => 'file',
  path    => '/opt/puppet/etc/gemrc',
  owner   => 'root',
  group   => '0',
  mode    => '0644',
  content => "---\nupdate_sources: true\n:sources:\n- http://your.internal.gem.server.com/rubygems/\n",
}

class { 'r10k':
  remote   => 'git@github.com:someuser/puppet.git',
  provider => 'pe_gem',
  require  => File['gemrc'],
}
```

The mcollective agent can be configured to supply r10k/git environment `http_proxy`, `https_proxy` variables via the following example

```puppet
class { '::r10k::mcollective':
  http_proxy     => 'http://proxy.example.lan:3128',
  git_ssl_no_verify => 1,
}
```

