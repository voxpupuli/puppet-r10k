# r10k Configuration Module

[![Build Status](https://travis-ci.org/acidprime/r10k.png?branch=master)](https://travis-ci.org/acidprime/r10k)

This is the r10k setup module. It has a base class to configure r10k to 
synchronize dynamic environments. You can be simply used by declaring it:

```puppet
class { 'r10k':
  remote => 'git@github.com:someuser/puppet.git',
}
```

This will configure `/etc/r10k.yaml` and install the r10k gem after installing
ruby using the [puppetlabs/ruby](http://forge.puppetlabs.com/puppetlabs/ruby) module. It also has a few helper classes that do
some useful things. The following entry in Hiera will add a `prerun_command` to puppet.conf.

```
r10k::include_prerun_command: true
```

The concept here is that this is declared on the puppet master(s) that have
been configured with r10k. This will cause r10k to synchronize before each
puppet run. Any errors synchronizing will be logged to the standard puppet run.

## symlink to r10k.yaml
These entries in Hiera will create a symlink at `/etc/r10k.yaml` that points to the config file at `/etc/puppet/r10k.yaml`

```
r10k::configfile: /etc/puppet/r10k.yaml
r10k::manage_configfile_symlink: true
r10k::configfile_symlink: /etc/r10k.yaml
```

### Mcollective Support

![alt tag](https://gist.github.com/acidprime/7013041/raw/6748f6173b406c03067884199174ce1df313ad58/post_recieve_overview.png)

An mcollective agent is included in this module which can be used to do 
on demand synchronization. This mcollective application and agent can be
installed on all masters using the following class

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

An example post-recieve hook is included in the files directory.
This hook can automatically cause code to synchronize on your
servers at time of push in git.

###Install mcollective support for post recieve hooks
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
##Support

# Webhook Support

For version control systems that use web driven post-receive processes you can use the example webhook included in this module.
This webhook currently only runs on Puppet Enterprise and uses mcollective to automatically synchronize your environment across multiple masters.
The webhook must be configured on the respective "control" repository a master that has mco installed and can contact the other masters in your fleet.

Please log tickets and issues at our [Projects site](https://github.com/acidprime/r10k/issues)
