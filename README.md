# r10k Configuration Module
[![Puppet Forge](http://img.shields.io/puppetforge/v/zack/r10k.svg)](https://forge.puppetlabs.com/zack/r10k)
[![Build Status](https://travis-ci.org/acidprime/r10k.png?branch=master)](https://travis-ci.org/acidprime/r10k)

This is the r10k setup module. It has a base class to configure r10k to
synchronize [dynamic environments](https://github.com/adrienthebo/r10k/blob/master/doc/dynamic-environments.mkd). You can be simply used by declaring it:

```puppet
class { 'r10k':
  remote => 'git@github.com:someuser/puppet.git',
}
```

Installing into the puppet enterprise ruby stack
```puppet
class { 'r10k':
  remote   => 'git@github.com:someuser/puppet.git',
  provider => 'pe_gem',
}
```
### Prefixes
Installing using prefixes for multiple control repos.
```puppet
class { 'r10k':
  sources => {
    'webteam' => {
      'remote'  => 'ssh://git@github.com/webteam/somerepo.git',
      'basedir' => "${::settings::confdir}/environments"
      'prefix'  => true,
    },
    'secteam' => {
      'remote'  => 'ssh://git@github.com/secteam/someotherrepo.git',
      'basedir' => '/some/other/basedir'
      'prefix'  => true,
    },
  },
}
```


## Version chart

| Module Version | r10k Version |
| -------------- | ------------ |
| v2.6.x         | 1.4.1        |
| v2.5.4         | 1.4.0        |
| v2.4.4         | 1.3.5        |
| v2.3.1         | 1.3.4        |
| v2.3.0         | 1.3.2        |
| v2.2.8         | 1.3.1        |
| v2.2.x         | 1.1.0        |


This will configure `/etc/r10k.yaml` and install the r10k gem after installing
ruby using the [puppetlabs/ruby](http://forge.puppetlabs.com/puppetlabs/ruby) module.

Here is an example of deploying the ssh keys needed for r10k to connect to a repo called puppet/control on a gitlab server.
This is helpful when you need to automatically deploy new masters
```puppet
#https://docs.puppetlabs.com/references/latest/type.html#sshkey
sshkey { "your.internal.gitlab.server.com":
  ensure => present,
  type   => "ssh-rsa",
  target => "/root/.ssh/known_hosts",
  key    => "...+dffsfHQ=="
}

# https://github.com/abrader/abrader-gms
git_deploy_key { 'add_deploy_key_to_puppet_control':
  ensure       => present,
  name         => $::fqdn,
  path         => '/root/.ssh/id_dsa.pub',
  token        => hiera('gitlab_api_token'),
  project_name => 'puppet/control',
  server_url   => 'http://your.internal.gitlab.server.com',
  provider     => 'gitlab',
}
```


## Helper classes
It also has a few helper classes that do
some useful things. The following entry in Hiera will add a `postrun_command` to puppet.conf.

```
r10k::include_postrun_command: true
```

The concept here is that this is declared on the puppet master(s) that have
been configured with r10k. This will cause r10k to synchronize before each
puppet run. Any errors synchronizing will be logged to the standard puppet run.

This module requires the [puppetlabs-ruby](https://github.com/puppetlabs/puppetlabs-ruby.git) module. In the event that your environment already includes
the module with some customization, you can use the `manage_ruby_dependency`
parameter to adjust how this module expresses that requirement.
The supported values are `include`,`declare`, or `ignore`. The values' behavior
is outlined below:

  * *declare* **default** This will explicitly declare the ruby module.
    Additional declarations of the ruby module will result in an inability to
    compile a catalog.

  * *include* This will simply include the ruby module. When combined with class
    ordering, this will permit the user to manage the instantiation of the ruby module elsewhere, potentially with non-standard parameter values.

  * *ignore* This will assume that ruby is handled via some other mechanism than
    a puppet module named `ruby`. It is left to the user to insure the
    requirement be met.

## symlink to r10k.yaml
These entries in Hiera will create a symlink at `/etc/r10k.yaml` that points to the config file at `/etc/puppet/r10k.yaml`

```yaml
---
r10k::configfile: /etc/puppet/r10k.yaml
r10k::manage_configfile_symlink: true
r10k::configfile_symlink: /etc/r10k.yaml
```

## Example installs

Installing using a proxy server

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

### Mcollective Support
![alt tag](http://imageshack.com/a/img674/3070/NWvnSn.png)

An mcollective agent is included in this module which can be used to do
on demand synchronization. This mcollective application and agent can be
installed on all masters using the following class
_Note: You must have mcollective already configured for this tool to work,
Puppet Enterprise users will automatically have mcollective configured._
```puppet
include r10k::mcollective
```

Using mco you can then trigger mcollective to call r10k using

```shell
mco r10k synchronize
```

You can sync an individual environment using:

```shell
mco r10k deploy <environment>
```
Note: This implies `-p`

You can sync an individual module using:

```shell
mco r10k deploy_module <module>
```

An example post-receive hook is included in the files directory.
This hook can automatically cause code to synchronize on your
servers at time of push in git. More modern git systems use webhooks, for  those see below.

###Install mcollective support for post receive hooks
Install the `mco` command from the puppet enterprise installation directory i.e.
```shell
cd ~/puppet-enterprise-3.0.1-el-6-x86_64/packages/el-6-x86_64
sudo rpm -i pe-mcollective-client-2.2.4-2.pe.el6.noarch.rpm
```
Copy the peadmin mcollective configuration and private keys from the certificate authority (puppet master)
~~~
/var/lib/peadmin/.mcollective
/var/lib/peadmin/.mcollective.d/mcollective-public.pem
/var/lib/peadmin/.mcollective.d/peadmin-cacert.pem
/var/lib/peadmin/.mcollective.d/peadmin-cert.pem
/var/lib/peadmin/.mcollective.d/peadmin-private.pem
/var/lib/peadmin/.mcollective.d/peadmin-public.pem
~~~
Ensure you update the paths in _~/.mcollective_ when copying to new users whose name is not peadmin.
Ideally mcollective will be used with more then just the peadmin user's certificate
in the future. That said, if your git user does not have a home diretory, you can rename .mcollective as /etc/client.cfg
and copy the certs to somewhere that is readable by the respective user.
~~~
/home/gitolite/.mcollective
/home/gitolite/.mcollective.d/mcollective-public.pem
/home/gitolite/.mcollective.d/peadmin-cacert.pem
/home/gitolite/.mcollective.d/peadmin-cert.pem
/home/gitolite/.mcollective.d/peadmin-private.pem
/home/gitolite/.mcollective.d/peadmin-public.pem
~~~
_Note: PE2 only requires the .mcollective file as the default auth was psk_

# Webhook Support

![alt tag](http://imageshack.com/a/img661/6302/qQwIrw.gif)  
For version control systems that use web driven post-receive processes you can use the example webhook included in this module.
This webhook currently only runs on Puppet Enterprise and uses mcollective to automatically synchronize your environment across multiple masters.
The webhook must be configured on the respective "control" repository a master that has mco installed and can contact the other masters in your fleet.

Currently this is a feature Puppet Enterprise only.

### Webhook Github Enterprise - Non Authenticated 
This is an example of using the webhook without authentication
The `git_webhook` type will using the [api token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) to add the webhook to the "control" repo that contains your puppetfile. This is typically useful when you want all automate the addtion of the webhook to the repo.

```puppet
# Internal webhooks often don't need authentication and ssl
# Change the url below if this is changed
class {'r10k::webhook::config':
  enable_ssl     => false,
  protected      => false,
}

class {'r10k::webhook':
  require => Class['r10k::webhook::config'],
}

# https://github.com/abrader/abrader-gms
# Add webhook to control repository ( the repo where the Puppetfile lives )
git_webhook { 'web_post_receive_webhook' :
  ensure       => present,
  webhook_url  => 'http://master.of.masters:8088/payload',
  token        =>  hiera('github_api_token'),
  project_name => 'organization/control',
  server_url   => 'https://your.github.enterprise.com',
  provider     => 'github',
}


# Add webhook to module repo if we are tracking branch in Puppetfile i.e.
# mod 'module_name',
#  :git    => 'http://github.com/organization/puppet-module_name',
#  :branch => 'master'
# The module name is determined from the repo name , i.e. <puppet-><module_name>
# All characters with left and including any hyphen are removed i.e. <puppet->
git_webhook { 'web_post_receive_webhook_for_module' :
  ensure       => present,
  webhook_url  => 'http://master.of.masters:8088/module',
  token        =>  hiera('github_api_token'),
  project_name => 'organization/puppet-module_name',
  server_url   => 'https://your.github.enterprise.com',
  provider     => 'github',
}
```

### Webhook Github Example - Authenticated 
This is an example of using the webhook with authentication
The `git_webhook` type will using the [api token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) to add the webhook to the "control" repo that contains your puppetfile. This is typically useful when you want all automate the addtion of the webhook to the repo.

```puppet
# External webhooks often need authentication and ssl and authentication
# Change the url below if this is changed
class {'r10k::webhook::config':
  enable_ssl => true,
  protected  => true,
  notify     => Service['webhook'],
}

class {'r10k::webhook':
  require => Class['r10k::webhook::config'],
}

# https://github.com/abrader/abrader-gms
# Add webhook to control repository ( the repo where the Puppetfile lives )
# Requires gms 0.0.6+ for disable_ssl_verify param
git_webhook { 'web_post_receive_webhook' :
  ensure             => present,
  webhook_url        => 'https://puppet:puppet@hole.in.firewall:8088/payload',
  token              =>  hiera('github_api_token'),
  project_name       => 'organization/control',
  server_url         => 'https://api.github.com',
  disable_ssl_verify => true,
  provider           => 'github',
}


# Add webhook to module repo if we are tracking branch in Puppetfile i.e.
# mod 'module_name',
#  :git    => 'http://github.com/organization/puppet-module_name',
#  :branch => 'master'
# The module name is determined from the repo name , i.e. <puppet-><module_name>
# All characters with left and including any hyphen are removed i.e. <puppet->
git_webhook { 'web_post_receive_webhook_for_module' :
  ensure       => present,
  webhook_url  => 'https://puppet:puppet@hole.in.firewall:8088/module', 
  token        =>  hiera('github_api_token'),
  project_name => 'organization/puppet-module_name',
  server_url   => 'https://api.github.com',
  disable_ssl_verify => true,
  provider     => 'github',
}
```

### Running without mcollective
If you have only a single master, you may want to have the webhook run r10k directly rather then
as peadmin via mcollective. This requires you to run as the user that can perform `r10k` commands
which is typically root.

```puppet
# Instead of running via mco, run r10k directly
class {'r10k::webhook::config':
  use_mcollective => false,
}

# The hook needs to run as root when not running using mcollective
# It will issue r10k deploy environment <branch_from_gitlab_payload> -p
# When git pushes happen.
class {'r10k::webhook':
  user    => 'root',
  group   => '0',
  require => Class['r10k::webhook::config'],
}
```

### Webhook Prefix Example

The following is an example of declaring the webhook when r10k [prefixing](#prefixes) are enabled.

#### prefix_command.rb
This script is fed the github/gitlab payload in via stdin. This script is meant to return the prefix as its output.
This is needed as the payload does not contain the r10k prefix. The simplest way to determine the prefix is to
use the remote url in the payload and find the respective key in r10k.yaml. An example prefix command is located in
this repo [here](https://github.com/acidprime/r10k/blob/master/files/prefix_command.rb). Note that you may need to
modify this script depending on your remote configuration to use one of the various remote styles.

```puppet
file {'/usr/local/bin/prefix_command.rb':
  ensure => file,
  mode   => '0755',
  owner  => 'root',
  group  => '0',
  source => 'puppet:///modules/r10k/prefix_command.rb',
}

class {'r10k::webhook::config':
  prefix         => true,
  prefix_command => '/usr/local/bin/prefix_command.rb',
  require        => File['/usr/local/bin/prefix_command.rb'],
}

class {'r10k::webhook':
  require => Class['r10k::webhook::config'],
}
# Deploy this webhook to your local gitlab server for the puppet/control repo.
# https://github.com/abrader/abrader-gms
git_webhook { 'web_post_receive_webhook' :
  ensure       => present,
  webhook_url  => 'https://puppet:puppet@master.of.masters:8088/payload',
  token        =>  hiera('gitlab_api_token'),
  project_name => 'puppet/control',
  server_url   => 'http://your.internal.gitlab.com',
  provider     => 'gitlab',
}


```



##Support

Please log tickets and issues at our [Projects site](https://github.com/acidprime/r10k/issues)
