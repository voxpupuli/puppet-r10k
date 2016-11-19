# puppet-r10k Changelog

## Release 4.0.0 - Multiple Authors

* First Vox Pupuli release of r10k!
* Badge updates #298
* First modulesync after migration #296
* unbreak on OS where root group != 'root' #279
* Update config_version.sh #291
* Duplicate certpath key #287
* Fixes Puppet 4 path for webhook #295
* add curl example to readme #274
* Fix testing #288
* Add support for custom permissions and ownership of webhooks.yaml #278
* Add GitHub signature #262
* fix mcollective image #264

## Release 3.2.0 - Multiple Authors

* Support for TFS/Visual Studio Git #259
* Lowercase Environment names #256
* Obsure Software version #253
* Fix Postrun command spaces #252
* Tagged Release events #251

## Release 3.1.1 - Corey Osman & Nate McCurdy

* r10k_path fact throwing error on agents

## Release 3.1.0 - Mickaël Canévet & Ben Ford

* Fix typo related to cachedir
* Add support for automatically calculated prefixes from github ( backwarda compatible)
* Add some new prefix acceptance tests ( WIP )

## Release 3.0.0 - Lots o Folks' see linked tickets

* Webhook compatibility on non masters servers (razor) #219
* Webhook YAML recreated on every run on ruby 1.8.7 #209
* Add postrun command support #211
* Add r10k_path fact #222
* Remove depricated params git_ssl_verify
* add git_settings param for rugged support
* Fix webhook issue when running as root #217
* Added support for Bitbucket merge hooks #193
* Add ability to be installed on non-masters i.e. razor #219
* Updated for PE 2015.2 and Puppet 4 ( which are pretty much the same thing now)

## Release 2.8.2 - Jordan Olshevski

* Fix for RHEL 7 webhook

## Release 2.8.2 - Jerald Sheets

* Troubleshooting RHEL 7 issues with systemd

## Release 2.8.1 - See Commit History

* Multiple Webhook updates for Centos 7 and Debian

## Release 2.8.0 - Tom linkin

* Support for systemd on EL7 for webhook

## Release 2.7.4 - Rob Nelson

* Fix #162 for FOSS ruby 1.8.7 webhook.yaml issues

## Release 2.7.3 - esalberg

* Regression from 2.7.1

## Release 2.7.2 - Federico Voges & Ben ford

* Fix #155 gem install issues with arguments

## Release 2.7.1 - Alex Scoble & esalberg & annaken

* Fix webhook directory permissions #144
* Fix gem dep regression #154
* Update gem version for pulled release.

## Release 2.7.0 - Zack Smith

* Updates for Puppet Enterprise 3.8 and its embeded r10k
* Update default r10k version with that which will ship in PE 3.8

## Release 2.6.5 - spidersddd

* Fix #147 for Ubuntu 14.0.4

## Release 2.6.4 - Zack Smith & Corey Osman

* Fix conditional for pe 3.7 cert upgrade hack

## Release 2.6.3 - Eli Young

* Ordering issues #134 & #138

## Release 2.6.2 - harrytford

* Webhook new installs fix #132

## Release 2.6.1 - Gary Larizza

* Fix "local" non mcollective hook tiggers to add '-p'
* See #125 , this will cause any current users to default to turning this on

## Release 2.6.0 - Eli Young & Ranjit Viswakumar

* Add bind_address to webhook
* bump r10k version to 1.4.1

## Release 2.5.4 -  Zack Smith

* Fix webhook init script issue

## Release 2.5.3 -  Eli Young & te206676

* Ubuntu Support for Webhook #118
* Permissions on Certificate #119

## Release 2.5.2 -  Chris Roddy

* Fixed missing make dep, will be removed in 3.x release of module

## Release 2.5.1 -  Zack Smith

* README updates

## Release 2.5.0 -  Zack Smith & Sean Keery

* Puppet Enterprise 3.7 compatibility
* Fixed bugs #108,#110,#110,#111
* Support for /module end point in webhook to run r10k module deploy foo

## Release 2.4.4 - Eli Young & Igor Galić

* prevent potential leakage Resource defaults for ini
*     Handle branch names containing slashes

## Release 2.4.3 - Zack Smith

* Documentation Updates

## Release 2.4.1 - Zack Smith

* Documentation Updates

## Release 2.4.0 - Zack Smith

* Bump r10k version

## Release 2.3.4 - Eli Young

* Webhook fixes for reboots + refreshes

## Release 2.3.3 - Zach Leslie + misterdom

* Fix for #97

## Release 2.3.2 - Zach Leslie + misterdom

* Fix for #96

## Release 2.3.1 - Ben Ford

* Fix for #87

## Release 2.3.0 - Zack Smith

* Fold in #78, #75 and #73

## Release 2.2.7 - Zack Smith

* Bugfix for mcollective during puppet apply and webhook as non mco

## Release 2.2.7 - Zack Smith

* forge cut

## Release 2.2.6 - Zack Smith

* Fix scoping issues with new logfile

## Release 2.2.4 - Adam Crews

* Fix for invalid webhook typo syntax and updates for using stash

## Release 2.2.3 - Zack Smith

* Functional prefix support for webhook

## Release 2.2.3 - Zack Smith

* Remove PID file creation from webhook

## Release 2.1.2 - Garrett Honeycutt & Zack Smith

* Fix quoting issue created by #24 with booleans with #54
* Intial commit of functionally tested github authenticated webhook

## Release 2.1.1 - Zack Smith

* Add SSL and auth support to webhook

## Release 2.1.0 - Zack Smith

* Intial branch support for mco

## Release 2.0.0 - Tim Hartmann

* Fixes for r10k.yaml #24 but caused #54 so use 2.1.2+

## Release 1.0.2 - James Sweeny

* Fix issue with module working on PE

## Release 1.0.1 - Justin Lambert & welterde

* Minor fix for basedir and rspec-puppet updates

## Release 0.0.9 - Zack Smith <zack@puppetlabs.com>

* Final params list for version 1.0.0 set & Bugfixes

## Release 0.0.8 - Theo Chatzimichos <tampakrap>

* Add gentoo support , refactor install class

## Release 0.0.5 - Zack Smith <zack@puppetlabs.vom>

* Lint and Syntax updates + Forge Release

## Release 0.0.4 - Zack Smith <zack@puppetlabs.com>

* RC1 of new sources code

## Release 0.0.3 - Zack Smith <zack@puppetlabs.com>

* Allow for multiple sources

## Release 0.0.2 - Zack Smith <zack@puppetlabs.com>

* Restrict installed version of r10k to

## Release 0.0.1 - Zack Smith <zack@puppetlabs.com> - 0.0.1

* Initial Release
