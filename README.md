# r10k Configuration Module
[![Puppet Forge](http://img.shields.io/puppetforge/v/puppet/r10k.svg)](https://forge.puppetlabs.com/puppet/r10k)
[![Build Status](https://travis-ci.org/voxpupuli/puppet-r10k.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-r10k)
[![Github Tag](https://img.shields.io/github/tag/voxpupuli/puppet-r10k.svg)](https://github.com/voxpupuli/puppet-r10k)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/voxpupuli/puppet-r10k?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/puppet/r10k.svg)](https://forge.puppetlabs.com/puppet/r10k)
[![Puppet Forge Endorsement](https://img.shields.io/puppetforge/e/puppet/r10k.svg)](https://forge.puppetlabs.com/puppet/r10k)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with r10k](#setup)
    * [What r10k affects](#what-r10k-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with r10k](#beginning-with-r10k)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module was built to install and configure r10k. It has a base class to configure r10k to
synchronize [dynamic environments](https://github.com/adrienthebo/r10k/blob/master/doc/dynamic-environments.mkd).
It also has a series of lateral scripts and tools that assist in general workflow, that will be separated into
their own modules into the future.

## Module Description

This module is meant to manage the installation and configuration of r10k using multiple installation methods on multiple platforms.

## Setup

Please refer to the official [r10k docs](https://github.com/puppetlabs/r10k/tree/master/doc) for specific configuration patterns.

### Prefix Example
Instead of passing a single `remote`, you can pass a puppet [hash](https://docs.puppetlabs.com/puppet/latest/reference/lang_datatypes.html#hashes) as the `sources`
parameter. This allows you to configure r10k with [prefix](https://github.com/puppetlabs/r10k/blob/910709a2924d6167e2e53e03d64d2cc1a64827d4/doc/dynamic-environments/configuration.mkd#prefix) support. This often used when multiple teams use separate repos, or if hiera and puppet are distributed across two repos.

```puppet
class { 'r10k':
  sources => {
    'webteam' => {
      'remote'  => 'ssh://git@github.com/webteam/somerepo.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => true,
    },
    'secteam' => {
      'remote'  => 'ssh://git@github.com/secteam/someotherrepo.git',
      'basedir' => '/some/other/basedir',
      'prefix'  => true,
    },
  },
}
```
### What r10k affects

* Installation of the r10k `gem`
* Installation of git
* Installation of ruby when not using an existing ruby stack i.e. when using `puppet_gem`
* Management of the `r10k.yaml` in /etc
* Installation and configuration of a sinatra app when using the [webhook](#webhook-support).


#### Version chart

Gem installation is pinned to a default version in this module, the following chart shows the gem installation tested with the respective module version.
You can override this by passing the `version` parameter.

| Module Version | r10k Version |
| -------------- | ------------ |
| v4.0.0+        | [![Latest Version](https://img.shields.io/gem/v/r10k.svg?style=flat-square)](https://rubygems.org/gems/r10k)        |
| v3.0.x         | 1.5.1        |
| v2.8.2         | 1.5.1        |
| v2.7.x         | 1.5.1        |
| v2.6.5         | 1.4.1        |
| v2.5.4         | 1.4.0        |
| v2.4.4         | 1.3.5        |
| v2.3.1         | 1.3.4        |
| v2.3.0         | 1.3.2        |
| v2.2.8         | 1.3.1        |
| v2.2.x         | 1.1.0        |


### Setup Requirements

r10k connects via ssh and does so silently in the background, this typically requires ssh keys to be deployed in advance of configuring
r10k. This includes the known host ( public ) key of the respective git server, and the user running r10k's private key used to authenticate
git/ssh during background runs.

Here is an example of deploying the ssh keys needed for r10k to connect to a repo called puppet/control on a gitlab server.
This is helpful when you need to automatically deploy new masters

```puppet
#https://docs.puppetlabs.com/references/latest/type.html#sshkey
sshkey { 'your.internal.gitlab.server.com':
  ensure => present,
  type   => 'ssh-rsa',
  target => '/root/.ssh/known_hosts',
  key    => '...+dffsfHQ==',
}

# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
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
A simple example of creating an ssh private key would use an exec to call `yes y | ssh-keygen -t dsa -C "r10k" -f /root/.ssh/id_dsa -q -N ''`.
The example above shows using `git_deploy_key` which would deploy that key to the remote git server via its api. This is often required in the programtic creation of compile masters.

Given r10k will likely be downloading your modules, often on the first server
it's run on, you will have to `puppet apply` this module to bootstrap this
configuration and allow for ongoing management from there.

### Beginning with r10k

The simplest example of using it would be to declare a single remote that would be written to r10k.yaml.

```puppet
class { 'r10k':
  remote => 'git@github.com:someuser/puppet.git',
}
```
This will configure `/etc/r10k.yaml` and install the r10k gem after installing
ruby using the [puppetlabs/ruby](http://forge.puppetlabs.com/puppetlabs/ruby) module.

It also supports installation via multiple providers, such as installation in the puppet_enterprise ruby stack in versions less than 3.8

Installing into the Puppet Enterprise ruby stack in PE 2015.x

```puppet
class { 'r10k':
  remote   => 'git@github.com:someuser/puppet.git',
  provider => 'puppet_gem',
}
```

_Note: It is recommended you migrate to using the `pe_r10k` module which is basically
a clone of this modules features and file tickets for anything missing._


## Usage

Installing using a proxy server

### Mcollective Support
![alt tag](https://gist.githubusercontent.com/acidprime/7013041/raw/1a99e0a8d28b13bc20b74d2dc4ab60c7e752088c/post_recieve_overview.png)

An mcollective agent is included in this module which can be used to do
on demand synchronization. This mcollective application and agent can be
installed on all masters using the following class
_Note: You must have mcollective already configured for this tool to work,
Puppet Enterprise users will automatically have mcollective configured._
This class does not restart the mcollective or pe-mcollective server on the
nodes to which it is applied, so you may need to restart mcollective for it
to see the newly installed r10k agent.
```puppet
include r10k::mcollective
```

Using mco you can then trigger mcollective to call r10k using

```shell
mco r10k synchronize
```

You can sync an individual environment using:

```shell
mco r10k deploy environment <environment>
```
Note: This implies `-p`

You can sync an individual module using:

```shell
mco r10k deploy_module <module>
```

If you are required to run `r10k` as a specific user, you can do so by passing
the `user` parameter:

```shell
mco r10k synchronize user=r10k
```

To obtain the output of running the shell command, run the agent like this:

```shell
mco rpc r10k synchronize -v
```

An example post-receive hook is included in the files directory.
This hook can automatically cause code to synchronize on your
servers at time of push in git. More modern git systems use webhooks, for  those see below.

### Install mcollective support for post receive hooks
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
in the future. That said, if your git user does not have a home directory, you can rename .mcollective as /etc/client.cfg
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

### Removing the mcollective agent

```puppet
class { 'r10k::mcollective':
  ensure => false,
}
```
This will remove the mcollective agent/application and ddl files from disk. This likely would be if you are migrating to Code manager in Puppet Enterprise.

# Webhook Support

![alt tag](https://gist.githubusercontent.com/acidprime/be25026c11a76bf3e7fb/raw/44df86181c3e5d14242a1b1f4281bf24e9c48509/webhook.gif)
For version control systems that use web driven post-receive processes you can use the example webhook included in this module.
When the webhook receives the post-receive event, it will synchronize environments on your puppet masters.
The webhook uses mcollective for multi-master synchronization and the `peadmin` user from Puppet Enterprise by default.
These settings are all configurable for your specific use case, as shown below in these configuration examples.

### Webhook Github Enterprise - Non Authenticated
This is an example of using the webhook without authentication.
The `git_webhook` type will use the [api token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) to add the webhook to the "control" repo that contains your puppetfile. This is typically useful when you want to automate the addition of the webhook to the repo.

```puppet
# Required unless you disable mcollective
include r10k::mcollective
# Internal webhooks often don't need authentication and ssl
# Change the url below if this is changed
class {'r10k::webhook::config':
  enable_ssl     => false,
  protected      => false,
}

class {'r10k::webhook':
  require => Class['r10k::webhook::config'],
}

# Add webhook to control repository ( the repo where the Puppetfile lives )
#
# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
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
#
# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
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
This is an example of using the webhook with authentication.
The `git_webhook` type will use the [api token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) to add the webhook to the "control" repo that contains your puppetfile. This is typically useful when you want to automate the addition of the webhook to the repo.

```puppet
# Required unless you disable mcollective
include r10k::mcollective

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

# Add webhook to control repository ( the repo where the Puppetfile lives )
#
# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
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
#
# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
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
### Webhook Bitbucket Example
This is an example of using the webhook with Atlassian Bitbucket (former Stash).
Requires the `external hooks` addon by https://marketplace.atlassian.com/plugins/com.ngs.stash.externalhooks.external-hooks/server/overview
and a specific Bitbucket user/pass. 
Remember to place the `stash_mco.rb` on the bitbucket server an make it executable.
Enable the webhook over the repository settings `External Async Post Receive Hook`:
 - Executable: e.g. `/opt/atlassian/bitbucket-data/external-hooks/stash_mco.rb` (see hook_exe)
 - Positional parameters: `-t http://git.example.com:8088/payload`

```puppet
# Add deploy key
git_deploy_key { 'add_deploy_key_to_puppet_control':
  ensure       => present,
  name         => $::fqdn,  
  path         => '/root/.ssh/id_rsa.pub',
  username     => 'api', 
  password     => 'pass',
  project_name => 'project',
  repo_name    => 'puppet',
  server_url   => 'https://git.example.com',
  provider     => 'stash',
}

# Add webhook
git_webhook { 'web_post_receive_webhook' :
  ensure       => present,
  webhook_url  => 'https://puppet:puppet@hole.in.firewall:8088/module',
  password     => 'pass',
  username     => 'api',
  project_name => 'project',
  repo_name    => 'puppet',
  server_url   => 'https://git.example.com',
  provider     => 'stash',
  hook_exe     => '/opt/atlassian/bitbucket-data/external-hooks/stash_mco.rb', 
}
```

### GitHub Secret Support
GitHub webhooks allow the use of a secret value that gets hashed against the payload to pass a
signature in the request X-Hub-Signature header. To support the secret with the webhook do the
following type of configuration.

```puppet
class { 'r10k::webhook::config':
  protected     => false,
  github_secret => 'THISISTHEGITHUBWEBHOOKSECRET',
}

class { 'r10k::webhook':
  require => Class['r10k::webhook::config'],
}
```

### Webhook - remove webhook init script and config file.
For use when moving to Code Manager, or other solutions, and the webhook should be removed.
```puppet
class {'r10k::webhook::config':
  ensure => false,
}

class {'r10k::webhook':
  ensure => false,
}
```

### Running without mcollective
If you have only a single master, you may want to have the webhook run r10k directly rather then as peadmin via mcollective.
This requires you to run as the user that can perform `r10k` commands which is typically root.
The peadmin certificate no longer is managed or required.


```puppet
# Instead of running via mco, run r10k directly
class {'r10k::webhook::config':
  use_mcollective => false,
}

# The hook needs to run as root when not running using mcollective
# It will issue r10k deploy environment <branch_from_gitlab_payload> -p
# When git pushes happen.
class {'r10k::webhook':
  use_mcollective => false,
  user            => 'root',
  group           => '0',
  require         => Class['r10k::webhook::config'],
}
```

### Webhook Prefix Example

The following is an example of declaring the webhook when r10k [prefixing](#prefixes) are enabled.

#### prefix_command.rb
This script is fed the github/gitlab payload in via stdin.
This script is meant to return the prefix as its output.
This is needed as the payload does not contain the r10k prefix.
The simplest way to determine the prefix is to use the remote url in the payload and find the respective key in r10k.yaml.
An example prefix command is located in this repo [here](https://github.com/voxpupuli/puppet-r10k/blob/master/files/prefix_command.rb).
Note that you may need to modify this script depending on your remote configuration to use one of the various remote styles.

```puppet
file {'/usr/local/bin/prefix_command.rb':
  ensure => file,
  mode   => '0755',
  owner  => 'root',
  group  => '0',
  source => 'puppet:///modules/r10k/prefix_command.rb',
}

# Required unless you disable mcollective
include r10k::mcollective

class {'r10k::webhook::config':
  prefix         => true,
  prefix_command => '/usr/local/bin/prefix_command.rb',
  require        => File['/usr/local/bin/prefix_command.rb'],
}

class {'r10k::webhook':
  require => Class['r10k::webhook::config'],
}
# Deploy this webhook to your local gitlab server for the puppet/control repo.
#
# Resource git_webhook is provided by https://forge.puppet.com/abrader/gms
git_webhook { 'web_post_receive_webhook' :
  ensure       => present,
  webhook_url  => 'https://puppet:puppet@master.of.masters:8088/payload',
  token        =>  hiera('gitlab_api_token'),
  project_name => 'puppet/control',
  server_url   => 'http://your.internal.gitlab.com',
  provider     => 'gitlab',
}


```
### Webhook FOSS support with MCollective

Currently the webhook relies on existing certificates for its ssl configuration.
See this following [ticket](https://github.com/voxpupuli/puppet-r10k/issues/140) for more information.
Until then, its possible to re-use you existing FOSS mcollective certificates.

Here is an working example on  Ubuntu 14.04.2 LTS

```puppet
class { 'r10k::webhook::config':
  public_key_path  => '/etc/mcollective/server_public.pem',  # Mandatory for FOSS
  private_key_path => '/etc/mcollective/server_private.pem', # Mandatory for FOSS
}

class { 'r10k::webhook':
  user    => 'puppet',                                       # Mandatory for FOSS
  group   => 'puppet',                                       # Mandatory for FOSS
}
```

### Webhook FOSS support without MCollective
Some instances may require the user/group `root/root` (Linux) or `root/wheel` (BSD).
Verify that the specified user has the permissions to run `r10k` commands.
```puppet
class { 'r10k::webhook::config':
  use_mcollective  => false,
  public_key_path  => '/etc/mcollective/server_public.pem',  # Mandatory even when use_mcollective is false
  private_key_path => '/etc/mcollective/server_private.pem', # Mandatory even when use_mcollective is false
}

class { 'r10k::webhook':
  user    => 'root',                                       # Mandatory for FOSS
  group   => 'root',                                       # Mandatory for FOSS
}
```

### Webhook sinatra gem installation

By default, the `r10k::webhook::package` class uses the `puppet_gem` provider to install the latest ruby 2.1 compatible version of sinatra ('~> 1.0').
If you are overriding `r10k::webhook::package::provider`, you will also need to override `r10k::webhook::package::sinatra_version`.

### Webhook webrick gem installation

By default, the `r10k::webhook::package` class uses the `puppet_gem` provider to install the webrick gem (version 1.3.1)
This version is compatible with all ruby version (webrick version 1.4.1 require Ruby version >=2.3.0)
If you are overriding `r10k::webhook::package::provider`, you may also override `r10k::webhook::package::webrick_version`.

### Webhook Slack notifications

You can enable Slack notifications for the webhook. You will need a
Slack webhook URL and the `slack-notifier` gem installed.

To get the Slack webhook URL you need to:

1. Go to
   [https://slack.com/apps/A0F7XDUAZ-incoming-webhooks](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks).
2. Choose your team, press `Configure`.
3. In configurations press `Add configuration`.
4. Choose channel, press `Add Incoming WebHooks integration`.

Then configure the webhook to add your Slack Webhook URL.

```puppet
class { 'r10k::webhook::config':
  . . .
  slack_webhook   => 'http://slack.webhook/webhook', # mandatory for usage
  slack_channel   => '#channel', # defaults to #default
  slack_username  => 'r10k', # the username to use
  slack_proxy_url => 'http://proxy.example.com:3128' # Optional.  Defaults to undef.
}
```

### Webhook Rocket.Chat notifications

You can enable Rocket.Chat notifications for the webhook. You will need a
Rocket.Chat incoming webhook URL and the `rocket-chat-notifier` gem installed.

To get the Rocket.Chat incoming webhook URL you need to:

1. Go to your Rocket.Chat and then select `Administration-Integrations`.
2. Choose `New integration`.
3. Choose `Incoming WebHook`. In the webhook form configure:
  * `Enabled`: `True`.
  * `Name`: A name for your webhook.
  * `Post to Channel`: The channel to post to by default.
4. Save changes with `Save Changes` bottom.

Then configure the webhook to add your Rocket.Chat Webhook URL.

```puppet
class { 'r10k::webhook::config':
  . . .
  rocketchat_webhook  => <your incoming webhook URL>,  # mandatory for usage
  rocketchat_username => 'username', # defaults to r10k
  rocketchat_channel  => '#channel', # defaults to #r10k
}
```


### Webhook Default Branch

The default branch of the controlrepo is commonly called `production`. This value can be overridden if you use another default branch name, such as `master`.

```puppet
class { 'r10k::webhook::config':
  default_branch => 'master',    # Optional. Defaults to 'production'
}
```

### Triggering the webhook from curl

To aid in debugging, or to give you some hints as to how to trigger the webhook by unsupported systems, here's a curl command to trigger the webhook to deploy the 'production' environment:

```bash
curl -d '
  {
    "repository": {"name": "foo", "owner": {"login": "foo"}},
    "ref": "production"
  }' http://puppet-master.example:8088/payload
```

### Troubleshooting

If you're not sure whether your webhook setup works:

- Try to make a GET request to the `heartbeat` endpoint (e.g. http://puppet-master.example:8088/heartbeat).
  You should see a short JSON answer similar to `{"status":"success","message":"running"}`.
- Watch the webhook logfile at `/var/log/webhook/access.log`, and send requests (e.g. using curl).
  Example output if successful:

``` bash
$ tail -f /var/log/webhook/access.log
...
[2015-05-03 13:01:45] DEBUG Rack::Handler::WEBrick is mounted on /.
[2015-05-03 13:01:45] INFO  WEBrick::HTTPServer#start: pid=7185 port=8088
[2015-05-03 13:02:46] DEBUG accept: 192.30.252.46:39379
[2015-05-03 13:02:46] DEBUG Rack::Handler::WEBrick is invoked.
[2015-05-03 13:02:46] INFO  authenticated: puppet
[2015-05-03 13:02:46] INFO  message: triggered: r10k deploy environment test_webhook -pv ...
...
```

### Docker

If you are building your image with the puppet, you need to prevent the webhook process from starting as a daemon.

The following is an example of declaring the webhook without a background mode

```puppet
class { 'r10k::webhook':
  . . .
  background  => false
}
```

### Ignore deploying some environments

If you need to configure webhook to not trigger r10k when changes pushed in some branch or repository, you can list them in
`r10k::webhook::config::ignore_environments` parameter as array.
There is an ability to specify it as a regular expression by enclosing it in forward slashes.

Here is an example where the test branch in dev repository and all branches in all repositories that includes the word 'feature'
in names will be skipped:

```puppet
class { 'r10k::webhook::config':
  . . .
  prefix               => ':repo',
  ignore_environments  => ['dev_test', '/.*feature.*/']
}
```

### Passing extra arguments to mco command

You can pass some additional arguments to mco command like `--no-progress` or `--timeout 60` or any others by specifying them
in the `r10k::webhook::config::mco_arguments` parameter as string:

```puppet
class { 'r10k::webhook::config':
  . . .
  mco_arguments  => '--no-progress'
}
```

## Reference

#### Class: `r10k`
This is the main public class to be declared , handingly installation and configuration declarations

**Parameters within `r10k`:**

##### `remote`
A string to be passed in as the source with a hardcode prefix of `puppet`

##### `sources`
A hash of all sources, this gets read out into the file as yaml. Must not be declared with `remote`

##### `cachedir`
A single string setting the `r10k.yaml` configuration value of the same name

##### `configfile`
A path to the configuration file to manage. Be aware Puppet Enterprise 4.0 and higher may conflict if you manage `/etc/puppetlabs/puppet/r10k.yaml`

##### `version`
A value passed to the package resource for managing the gem version

##### `modulepath`
Deprecated: for older [configfile](https://docs.puppetlabs.com/puppet/latest/reference/environments_classic.html) environments configuration of modulepath in puppet.conf

##### `manage_modulepath`
Deprecated: declare a resource for managing `modulepath` in Puppet.conf

##### `manage_ruby_dependency`
When using system ruby , options on how to declare

##### `r10k_basedir`
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
##### `package_name`
The name of the package to be installed via the provider

##### `provider`
The supported installation modes for this module

* portage
* yum
* bundle
* puppet_gem
* gem
* zypper

##### `gentoo_keywords`
See `r10k::install::portage` class for more information

##### `install_options`
Options to pass to the `provider` declaration

##### `mcollective`
Install mcollective application and agents. This does NOT configure mcollective automatically

##### `manage_configfile_symlink`
Manage a symlink to the configuration file, for systems installed in weird file system configurations

##### `git_settings`
This is the `git:` key in r10k, it accepts a hash that can be used to configure
rugged support.

```puppet
    $git_settings = {
      'provider'    => 'rugged',
      'private_key' => '/root/.ssh/id_rsa',
    }

    class {'r10k':
      remote       => 'git@github.com:acidprime/puppet.git',
      git_settings => $git_settings,
    }
```

##### `forge_settings`
This is the `forge:` key in r10k, it accepts a hash that contains settings for downloading modules from the Puppet Forge.

```puppet
    $forge_settings = {
      'proxy'   => 'https://proxy.example.com:3128',
      'baseurl' => 'https://forgeapi.puppetlabs.com',
    }

    class {'r10k':
      remote         => 'git@github.com:acidprime/puppet.git',
      forge_settings => $forge_settings,
    }
```

##### `deploy_settings`
This is the `deploy:` key in r10k, it accepts a hash that contains setting that control how r10k code deployments behave. Documentation for the settings can be found [here](https://docs.puppet.com/pe/latest/r10k_custom.html#deploy).

```puppet
    $deploy_settings = {
      'purge_levels' => ['puppetfile'],
    }

    class {'r10k':
      remote          => 'git@github.com:voxpupuli/puppet.git',
      deploy_settings => $deploy_settings,
    }
```

##### `configfile_symlink`
boolean if to manage symlink

##### `include_prerun_command`
Deprecated: Add [prerun_command](https://docs.puppetlabs.com/references/latest/configuration.html#preruncommand) to puppet.conf to run r10k when the agent on the master runs.
Suggest instead declaring `r10k::postrun_command ` as that will run after the agent runs which prevents r10k from stopping configuration management of masters from occurring as it does with `prerun_command`s

##### `include_postrun_command`
```
r10k::include_postrun_command: true
```

The concept here is that this is declared on the puppet master(s) that have
been configured with r10k. This will cause r10k to synchronize after each
puppet run. Any errors synchronizing will be logged to the standard puppet run.

## Limitations
The 4.1.x release *deprecates* support for:
* Puppet 3
* Ruby 1.9.3

These items are planned for removal in v5.0.0.

## Support

Please log tickets and issues at our [Projects site](https://github.com/voxpupuli/puppet-r10k/issues)

## Development

### Contributing

Modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. We can’t access the huge number of platforms and myriad of hardware, software, and deployment configurations that Puppet is intended to serve.

We want to keep it as easy as possible to contribute changes so that our modules work in your environment. There are a few guidelines that we need contributors to follow so that we can have a chance of keeping on top of things.

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for more details.

### Running tests

This project contains tests for [rspec-puppet](http://rspec-puppet.com/) to
verify functionality. For in-depth information please see their respective
documentation, as well as [CONTRIBUTING](.github/CONTRIBUTING.md).

Quickstart:

```
    gem install bundler
    bundle install --without system_tests
    bundle exec rake test
    bundle exec rake lint
```

Check the .travis.yml for supported Operating System Versions
