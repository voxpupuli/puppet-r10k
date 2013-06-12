r10k

This is the r10k setup module. It has a base class to configure r10k to 
synchronize dynamic environments. You can be simply used by declaring it:

```puppet
class { 'r10k':
  remote => 'git@github.com:someuser/puppet.git',
}
```

This will configure `/etc/r10k.yaml` and install the r10k gem after installing
ruby using the [puppetlabs/ruby](http://forge.puppetlabs.com/puppetlabs/ruby) module. It also has a few helper classes that do
some useful things. The following will add a `prerun_command` to puppet.conf.

```puppet
include r10k::prerun_command
```

The concept here is that this is declared on the puppet master(s) that have
been configured with r10k. This will cause r10k to synchronize before each
puppet run. Any errors synchronizing will be logged to the standard puppet run.

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

An example post-recieve hook is included in the files directory.
This hook can automatically cause code to synchronize on your
servers at time of push in git.


##Support

Please log tickets and issues at our [Projects site](https://github.com/acidprime/r10k/issues)
