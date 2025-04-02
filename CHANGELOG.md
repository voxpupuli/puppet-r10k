# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v14.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v14.2.0) (2025-04-02)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v14.1.0...v14.2.0)

**Implemented enhancements:**

- webhook-go: Update 2.8.0-\>2.9.0 [\#677](https://github.com/voxpupuli/puppet-r10k/pull/677) ([bastelfreak](https://github.com/bastelfreak))
- metadata.json: Add OpenVox [\#676](https://github.com/voxpupuli/puppet-r10k/pull/676) ([jstraw](https://github.com/jstraw))

## [v14.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v14.1.0) (2025-02-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v14.0.0...v14.1.0)

**Implemented enhancements:**

- Integrate puppet\_webhook [\#430](https://github.com/voxpupuli/puppet-r10k/issues/430)

**Merged pull requests:**

- puppet/systemd: allow 8.x [\#672](https://github.com/voxpupuli/puppet-r10k/pull/672) ([jay7x](https://github.com/jay7x))

## [v14.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v14.0.0) (2024-12-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v13.0.0...v14.0.0)

**Breaking changes:**

- rm manage\_ruby\_dependency param & r10k::install::gem [\#661](https://github.com/voxpupuli/puppet-r10k/pull/661) ([jhoblitt](https://github.com/jhoblitt))
- drop support for EL7 [\#660](https://github.com/voxpupuli/puppet-r10k/pull/660) ([jhoblitt](https://github.com/jhoblitt))

**Implemented enhancements:**

- Add Debian 12 support [\#669](https://github.com/voxpupuli/puppet-r10k/pull/669) ([bastelfreak](https://github.com/bastelfreak))
- Add Ubuntu 24.04 support [\#668](https://github.com/voxpupuli/puppet-r10k/pull/668) ([bastelfreak](https://github.com/bastelfreak))
- Add CentOS 9 support [\#667](https://github.com/voxpupuli/puppet-r10k/pull/667) ([bastelfreak](https://github.com/bastelfreak))
- Add Support for r10k 4 & 5 [\#666](https://github.com/voxpupuli/puppet-r10k/pull/666) ([bastelfreak](https://github.com/bastelfreak))
- Update webhook-go 2.2.0-\>2.8.0 [\#665](https://github.com/voxpupuli/puppet-r10k/pull/665) ([saz](https://github.com/saz))

## [v13.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v13.0.0) (2024-04-26)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v12.2.0...v13.0.0)

**Breaking changes:**

- Drop Ubuntu 18.04 support [\#648](https://github.com/voxpupuli/puppet-r10k/pull/648) ([zilchms](https://github.com/zilchms))

**Implemented enhancements:**

- Add OracleLinux 8 and 9 support [\#650](https://github.com/voxpupuli/puppet-r10k/pull/650) ([zilchms](https://github.com/zilchms))
- Add RHEL 9 support [\#649](https://github.com/voxpupuli/puppet-r10k/pull/649) ([zilchms](https://github.com/zilchms))
- Add Ubuntu 20.04 and 22.04 support [\#647](https://github.com/voxpupuli/puppet-r10k/pull/647) ([zilchms](https://github.com/zilchms))
- Add documentation stubs [\#646](https://github.com/voxpupuli/puppet-r10k/pull/646) ([zilchms](https://github.com/zilchms))

**Fixed bugs:**

- Use File.exist? instead of File.exists? [\#645](https://github.com/voxpupuli/puppet-r10k/pull/645) ([tuxmea](https://github.com/tuxmea))
- restore support for EoL Ruby / Puppet 7; enable acceptance tests [\#642](https://github.com/voxpupuli/puppet-r10k/pull/642) ([zilchms](https://github.com/zilchms))
- Remove legacy top-scope syntax [\#639](https://github.com/voxpupuli/puppet-r10k/pull/639) ([smortex](https://github.com/smortex))
- Update ordering on webhook and docu [\#638](https://github.com/voxpupuli/puppet-r10k/pull/638) ([tuxmea](https://github.com/tuxmea))

**Merged pull requests:**

- puppet/systemd: Allow 7.x [\#656](https://github.com/voxpupuli/puppet-r10k/pull/656) ([bastelfreak](https://github.com/bastelfreak))

## [v12.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v12.2.0) (2023-10-05)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v12.1.1...v12.2.0)

**Implemented enhancements:**

- webhook: Update default version 2.1.0-\>2.2.0 [\#631](https://github.com/voxpupuli/puppet-r10k/pull/631) ([bastelfreak](https://github.com/bastelfreak))
- Implement acceptance tests for webhook-go [\#627](https://github.com/voxpupuli/puppet-r10k/pull/627) ([bastelfreak](https://github.com/bastelfreak))
- webhook: Allow people to host the repo on their own [\#626](https://github.com/voxpupuli/puppet-r10k/pull/626) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- webhook: Fix default parameter values and add unit tests [\#630](https://github.com/voxpupuli/puppet-r10k/pull/630) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- replace to\_yaml\(\) with stdlib::to\_yaml\(\) [\#632](https://github.com/voxpupuli/puppet-r10k/pull/632) ([bastelfreak](https://github.com/bastelfreak))
- puppet/systemd: Allow 6.x [\#629](https://github.com/voxpupuli/puppet-r10k/pull/629) ([bastelfreak](https://github.com/bastelfreak))
- webhook-go: Move static data from params to webhook class [\#628](https://github.com/voxpupuli/puppet-r10k/pull/628) ([bastelfreak](https://github.com/bastelfreak))

## [v12.1.1](https://github.com/voxpupuli/puppet-r10k/tree/v12.1.1) (2023-08-12)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v12.1.0...v12.1.1)

**Merged pull requests:**

- puppetlabs/stdlib: require 9.x [\#620](https://github.com/voxpupuli/puppet-r10k/pull/620) ([bastelfreak](https://github.com/bastelfreak))

## [v12.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v12.1.0) (2023-08-09)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v12.0.0...v12.1.0)

**Implemented enhancements:**

- Implement global $ensure param to purge r10k [\#618](https://github.com/voxpupuli/puppet-r10k/pull/618) ([bastelfreak](https://github.com/bastelfreak))

## [v12.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v12.0.0) (2023-08-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v11.0.1...v12.0.0)

**Breaking changes:**

- install.pp: Make class private; Update OpenBSD package name ruby22-r10k-\>ruby31-r10k [\#615](https://github.com/voxpupuli/puppet-r10k/pull/615) ([bastelfreak](https://github.com/bastelfreak))
- replace r10k template with native puppet code [\#613](https://github.com/voxpupuli/puppet-r10k/pull/613) ([bastelfreak](https://github.com/bastelfreak))
- r10k::config: don't inherit params class [\#611](https://github.com/voxpupuli/puppet-r10k/pull/611) ([bastelfreak](https://github.com/bastelfreak))
- pre\_postrun\_command: replace deprecated `--puppetfile` with `--modules` [\#610](https://github.com/voxpupuli/puppet-r10k/pull/610) ([bastelfreak](https://github.com/bastelfreak))
- deploy settings: generate types by default and dont deploy spec dir [\#609](https://github.com/voxpupuli/puppet-r10k/pull/609) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- move static data to init.pp [\#616](https://github.com/voxpupuli/puppet-r10k/pull/616) ([bastelfreak](https://github.com/bastelfreak))
- Add Rocky/AlmaLinux support [\#614](https://github.com/voxpupuli/puppet-r10k/pull/614) ([bastelfreak](https://github.com/bastelfreak))
- Add Puppet 8 support [\#608](https://github.com/voxpupuli/puppet-r10k/pull/608) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Bugfix: Fix service name of webhook-go service [\#605](https://github.com/voxpupuli/puppet-r10k/pull/605) ([tmu-sprd](https://github.com/tmu-sprd))

**Merged pull requests:**

- config.pp: move all defaults to params.pp [\#612](https://github.com/voxpupuli/puppet-r10k/pull/612) ([bastelfreak](https://github.com/bastelfreak))

## [v11.0.1](https://github.com/voxpupuli/puppet-r10k/tree/v11.0.1) (2023-06-08)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v11.0.0...v11.0.1)

**Merged pull requests:**

- update webhook code with some basic fixes [\#603](https://github.com/voxpupuli/puppet-r10k/pull/603) ([dhollinger](https://github.com/dhollinger))

## [v11.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v11.0.0) (2023-06-05)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v10.3.0...v11.0.0)

**Breaking changes:**

- Delete legacy webhook [\#595](https://github.com/voxpupuli/puppet-r10k/pull/595) ([bastelfreak](https://github.com/bastelfreak))
- Remove old webhook code in preparation for webhook-go being added [\#594](https://github.com/voxpupuli/puppet-r10k/pull/594) ([dhollinger](https://github.com/dhollinger))
- Drop Puppet 6 support [\#592](https://github.com/voxpupuli/puppet-r10k/pull/592) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 5.5.0; Drop EoL Ubuntu 16.04 [\#584](https://github.com/voxpupuli/puppet-r10k/pull/584) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- puppetlabs/vcsrepo: Allow 6.x [\#602](https://github.com/voxpupuli/puppet-r10k/pull/602) ([bastelfreak](https://github.com/bastelfreak))
- puppet/systemd: Allow 5.x [\#601](https://github.com/voxpupuli/puppet-r10k/pull/601) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/inifile: Allow 6.x [\#600](https://github.com/voxpupuli/puppet-r10k/pull/600) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/stdlib: Allow 9.x [\#599](https://github.com/voxpupuli/puppet-r10k/pull/599) ([bastelfreak](https://github.com/bastelfreak))
- Release 11.0.0 [\#598](https://github.com/voxpupuli/puppet-r10k/pull/598) ([dhollinger](https://github.com/dhollinger))
- README: Don't use top level facts in examples [\#596](https://github.com/voxpupuli/puppet-r10k/pull/596) ([Geod24](https://github.com/Geod24))
- Change README.md dependency on \(abandoned\) abrader/gms to bjvrielink/gms [\#593](https://github.com/voxpupuli/puppet-r10k/pull/593) ([bschonec](https://github.com/bschonec))
- update module to work with webhook-go [\#590](https://github.com/voxpupuli/puppet-r10k/pull/590) ([dhollinger](https://github.com/dhollinger))

## [v10.3.0](https://github.com/voxpupuli/puppet-r10k/tree/v10.3.0) (2023-01-27)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v10.2.0...v10.3.0)

**Implemented enhancements:**

- \(Feature\) Should be installable with the MCollective module [\#46](https://github.com/voxpupuli/puppet-r10k/issues/46)
- bump puppet/systemd to \< 5.0.0 [\#587](https://github.com/voxpupuli/puppet-r10k/pull/587) ([jhoblitt](https://github.com/jhoblitt))
- Add RHEL8 support. [\#582](https://github.com/voxpupuli/puppet-r10k/pull/582) ([marcteale](https://github.com/marcteale))
- pool\_size: default to amount of CPU cores [\#579](https://github.com/voxpupuli/puppet-r10k/pull/579) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Fix webhook setup when using older Puppet/Ruby [\#581](https://github.com/voxpupuli/puppet-r10k/pull/581) ([smortex](https://github.com/smortex))

## [v10.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v10.2.0) (2022-06-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v10.1.1...v10.2.0)

**Implemented enhancements:**

- Add Gentoo support [\#576](https://github.com/voxpupuli/puppet-r10k/pull/576) ([bastelfreak](https://github.com/bastelfreak))
- Allow defining mcollective policies on the r10k agent [\#572](https://github.com/voxpupuli/puppet-r10k/pull/572) ([optiz0r](https://github.com/optiz0r))

**Closed issues:**

- Docs wrong for mcollective "deploy" command? [\#573](https://github.com/voxpupuli/puppet-r10k/issues/573)
- Enhancement Request: Support ignore\_branch\_prefixes in config hash / seperate [\#556](https://github.com/voxpupuli/puppet-r10k/issues/556)

**Merged pull requests:**

- Arch Linux: Disable acceptance tests for webhook [\#577](https://github.com/voxpupuli/puppet-r10k/pull/577) ([bastelfreak](https://github.com/bastelfreak))
- Fix mco r10k deploy command in docs to match actual behaviour [\#574](https://github.com/voxpupuli/puppet-r10k/pull/574) ([optiz0r](https://github.com/optiz0r))
- puppet-lint: fix top\_scope\_facts warnings [\#569](https://github.com/voxpupuli/puppet-r10k/pull/569) ([bastelfreak](https://github.com/bastelfreak))
- Add additional curl example for environment prefixes [\#508](https://github.com/voxpupuli/puppet-r10k/pull/508) ([DLeich](https://github.com/DLeich))

## [v10.1.1](https://github.com/voxpupuli/puppet-r10k/tree/v10.1.1) (2021-08-27)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v10.1.0...v10.1.1)

**Fixed bugs:**

- Manage unit file via systemd::unit\_file [\#566](https://github.com/voxpupuli/puppet-r10k/pull/566) ([bastelfreak](https://github.com/bastelfreak))
- Remove explicit StandardOutput from webhook.service [\#564](https://github.com/voxpupuli/puppet-r10k/pull/564) ([kenyon](https://github.com/kenyon))

**Merged pull requests:**

- Allow up-to-date dependencies [\#567](https://github.com/voxpupuli/puppet-r10k/pull/567) ([smortex](https://github.com/smortex))

## [v10.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v10.1.0) (2021-08-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v10.0.0...v10.1.0)

**Implemented enhancements:**

- Arch Linux: Install r10k as system package [\#561](https://github.com/voxpupuli/puppet-r10k/pull/561) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- cleanup .fixtures.yml [\#557](https://github.com/voxpupuli/puppet-r10k/pull/557) ([bastelfreak](https://github.com/bastelfreak))

## [v10.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v10.0.0) (2021-06-21)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v9.0.0...v10.0.0)

**Breaking changes:**

- Migrate r10k-mcollective to choria [\#431](https://github.com/voxpupuli/puppet-r10k/issues/431)
- make puppetlabs/ruby optional [\#553](https://github.com/voxpupuli/puppet-r10k/pull/553) ([bastelfreak](https://github.com/bastelfreak))
- Drop Puppet 5 support; require Puppet 6.1.0 or newer [\#549](https://github.com/voxpupuli/puppet-r10k/pull/549) ([bastelfreak](https://github.com/bastelfreak))
- Update r10k mcollective agent to work with Choria [\#548](https://github.com/voxpupuli/puppet-r10k/pull/548) ([treydock](https://github.com/treydock))
- fix: avoid using deprecated gem options [\#545](https://github.com/voxpupuli/puppet-r10k/pull/545) ([johanfleury](https://github.com/johanfleury))
- Drop EOL EL6 support [\#543](https://github.com/voxpupuli/puppet-r10k/pull/543) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Enable Puppet 7 support [\#550](https://github.com/voxpupuli/puppet-r10k/pull/550) ([bastelfreak](https://github.com/bastelfreak))
- webhook config: allow access\_log to be nil by using special value "stderr" [\#547](https://github.com/voxpupuli/puppet-r10k/pull/547) ([kenyon](https://github.com/kenyon))

**Closed issues:**

- CLI arguments --no-ri and --no-rdoc have been deprecated since Ruby 2.6.0 [\#544](https://github.com/voxpupuli/puppet-r10k/issues/544)

**Merged pull requests:**

- puppetlabs/vcsrepo: Allow 5.x [\#558](https://github.com/voxpupuli/puppet-r10k/pull/558) ([bastelfreak](https://github.com/bastelfreak))
- Use a more logical example for basedir in the example code. [\#554](https://github.com/voxpupuli/puppet-r10k/pull/554) ([zipkid](https://github.com/zipkid))
- stdlib, inifile, vcsrepo: allow latest versions [\#552](https://github.com/voxpupuli/puppet-r10k/pull/552) ([bastelfreak](https://github.com/bastelfreak))
- Add support for FreeBSD package provider [\#546](https://github.com/voxpupuli/puppet-r10k/pull/546) ([zachfi](https://github.com/zachfi))
- Added bitbucket webhook support for pull request event [\#540](https://github.com/voxpupuli/puppet-r10k/pull/540) ([magarvo](https://github.com/magarvo))

## [v9.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v9.0.0) (2020-08-15)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v8.3.0...v9.0.0)

**Breaking changes:**

- \[Issue \#530\] Removes dependence on puppetlabs-git [\#531](https://github.com/voxpupuli/puppet-r10k/pull/531) ([chadh](https://github.com/chadh))

**Implemented enhancements:**

- webhook: support verification of X-Gitlab-Token header [\#529](https://github.com/voxpupuli/puppet-r10k/pull/529) ([kenyon](https://github.com/kenyon))

**Closed issues:**

- Remove dependence on old puppetlabs-git module [\#530](https://github.com/voxpupuli/puppet-r10k/issues/530)
- webhook: add support for verifying X-Gitlab-Token [\#528](https://github.com/voxpupuli/puppet-r10k/issues/528)

**Merged pull requests:**

- modulesync 3.0.0 & puppet-lint updates  [\#533](https://github.com/voxpupuli/puppet-r10k/pull/533) ([bastelfreak](https://github.com/bastelfreak))

## [v8.3.0](https://github.com/voxpupuli/puppet-r10k/tree/v8.3.0) (2020-04-30)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v8.2.0...v8.3.0)

**Implemented enhancements:**

- Allow puppetlabs/vcsrepo 3.x [\#526](https://github.com/voxpupuli/puppet-r10k/pull/526) ([dhoppe](https://github.com/dhoppe))

**Closed issues:**

- vcsrepo is outdated - latest 6.x.x, requires \< 3.0.0 [\#525](https://github.com/voxpupuli/puppet-r10k/issues/525)

**Merged pull requests:**

- Use voxpupuli-acceptance [\#524](https://github.com/voxpupuli/puppet-r10k/pull/524) ([ekohl](https://github.com/ekohl))

## [v8.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v8.2.0) (2020-04-06)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v8.1.0...v8.2.0)

**Implemented enhancements:**

- Add support for package source attribute [\#517](https://github.com/voxpupuli/puppet-r10k/pull/517) ([prolixalias](https://github.com/prolixalias))

## [v8.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v8.1.0) (2020-04-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v8.0.0...v8.1.0)

**Implemented enhancements:**

- Change webhook systemd service type to `simple` [\#513](https://github.com/voxpupuli/puppet-r10k/pull/513) ([alexjfisher](https://github.com/alexjfisher))

**Closed issues:**

- webhook does not support the use of intermediate certificates [\#510](https://github.com/voxpupuli/puppet-r10k/issues/510)
- Travis CI tests are currently failing on centos7-x64 [\#509](https://github.com/voxpupuli/puppet-r10k/issues/509)
- Allow IPv6 [\#490](https://github.com/voxpupuli/puppet-r10k/issues/490)
- generate types feature doesn't work under unprivileged user id [\#412](https://github.com/voxpupuli/puppet-r10k/issues/412)
- Let /payload webhook deploy to all environments [\#391](https://github.com/voxpupuli/puppet-r10k/issues/391)
- dependency on puppetlabs/gcc which is not v1 [\#326](https://github.com/voxpupuli/puppet-r10k/issues/326)

**Merged pull requests:**

- Remove `anchor` resource from `r10k::install::gem` [\#519](https://github.com/voxpupuli/puppet-r10k/pull/519) ([alexjfisher](https://github.com/alexjfisher))
- Use full certificate chain for webhook [\#515](https://github.com/voxpupuli/puppet-r10k/pull/515) ([mcb30](https://github.com/mcb30))
- Fix webhook deployment on IPv6 machines [\#514](https://github.com/voxpupuli/puppet-r10k/pull/514) ([mcb30](https://github.com/mcb30))
- fix webhook generate type functionailty for non-root user [\#512](https://github.com/voxpupuli/puppet-r10k/pull/512) ([vchepkov](https://github.com/vchepkov))
- allow puppetlabs/inifile 4.x [\#505](https://github.com/voxpupuli/puppet-r10k/pull/505) ([bastelfreak](https://github.com/bastelfreak))

## [v8.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v8.0.0) (2019-10-28)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v7.0.0...v8.0.0)

**Breaking changes:**

- Don't manage installation of `git` [\#502](https://github.com/voxpupuli/puppet-r10k/pull/502) ([Andor](https://github.com/Andor))
- modulesync 2.9.0 & drop Ubuntu 14.04, add 16.04/18.04 [\#501](https://github.com/voxpupuli/puppet-r10k/pull/501) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- implement Archlinux support [\#503](https://github.com/voxpupuli/puppet-r10k/pull/503) ([bastelfreak](https://github.com/bastelfreak))
- Implement pool\_size parameter [\#492](https://github.com/voxpupuli/puppet-r10k/pull/492) ([baurmatt](https://github.com/baurmatt))
- Allow uppercase characters in environment names [\#491](https://github.com/voxpupuli/puppet-r10k/pull/491) ([nmaludy](https://github.com/nmaludy))

**Fixed bugs:**

- Trim "full\_name" when module name has no dash [\#498](https://github.com/voxpupuli/puppet-r10k/pull/498) ([posledov](https://github.com/posledov))

**Closed issues:**

- rotated logfiles should not have executable bit set [\#499](https://github.com/voxpupuli/puppet-r10k/issues/499)
- r10k, invoked by r10k::webhook, does not update the module code [\#496](https://github.com/voxpupuli/puppet-r10k/issues/496)

**Merged pull requests:**

- r10k webhook logfiles should not be executable [\#500](https://github.com/voxpupuli/puppet-r10k/pull/500) ([tuxmea](https://github.com/tuxmea))
- Add slack\_icon docs to README [\#497](https://github.com/voxpupuli/puppet-r10k/pull/497) ([0x6d617474](https://github.com/0x6d617474))
- webhook: use the systemd service by default [\#494](https://github.com/voxpupuli/puppet-r10k/pull/494) ([kenyon](https://github.com/kenyon))

## [v7.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v7.0.0) (2019-06-18)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.8.0...v7.0.0)

**Breaking changes:**

- modulesync 2.7.0 and drop puppet 4 [\#482](https://github.com/voxpupuli/puppet-r10k/pull/482) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- \(Feature\) webhook should support github secrets [\#102](https://github.com/voxpupuli/puppet-r10k/issues/102)
- Add support for proxy settings [\#487](https://github.com/voxpupuli/puppet-r10k/pull/487) ([dhoppe](https://github.com/dhoppe))
- Adding BitBucket Server secret support. [\#464](https://github.com/voxpupuli/puppet-r10k/pull/464) ([venushka](https://github.com/venushka))

**Closed issues:**

- webhook swallowing r10k error messages [\#472](https://github.com/voxpupuli/puppet-r10k/issues/472)
- support the "proxy" general setting [\#468](https://github.com/voxpupuli/puppet-r10k/issues/468)
- \(Feature\) webhook should support BitBucket server's secrets [\#463](https://github.com/voxpupuli/puppet-r10k/issues/463)
- Using exec in run\_command replaces process and skips notify\_\* calls [\#441](https://github.com/voxpupuli/puppet-r10k/issues/441)
- Acceptance tests failing with permissions error: [\#346](https://github.com/voxpupuli/puppet-r10k/issues/346)
- failing beaker tests [\#310](https://github.com/voxpupuli/puppet-r10k/issues/310)

**Merged pull requests:**

- Wrap slack\_icon with colons [\#495](https://github.com/voxpupuli/puppet-r10k/pull/495) ([0x6d617474](https://github.com/0x6d617474))
- Remove support for providers yum, zypper [\#489](https://github.com/voxpupuli/puppet-r10k/pull/489) ([dhoppe](https://github.com/dhoppe))
- Allow `puppetlabs/stdlib` 6.x [\#486](https://github.com/voxpupuli/puppet-r10k/pull/486) ([alexjfisher](https://github.com/alexjfisher))
- Webhook improvements [\#485](https://github.com/voxpupuli/puppet-r10k/pull/485) ([0x6d617474](https://github.com/0x6d617474))
- Convert mocha to rspec-mocks [\#484](https://github.com/voxpupuli/puppet-r10k/pull/484) ([dhoppe](https://github.com/dhoppe))
- Allow puppetlabs/inifile 3.x [\#483](https://github.com/voxpupuli/puppet-r10k/pull/483) ([dhoppe](https://github.com/dhoppe))
- Unify docs [\#481](https://github.com/voxpupuli/puppet-r10k/pull/481) ([DavidS](https://github.com/DavidS))
- Remove Gentoo/portage related code as is it not supported. [\#480](https://github.com/voxpupuli/puppet-r10k/pull/480) ([ghoneycutt](https://github.com/ghoneycutt))
- Acceptance tests run requests in parallel commented [\#470](https://github.com/voxpupuli/puppet-r10k/pull/470) ([Dan33l](https://github.com/Dan33l))

## [v6.8.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.8.0) (2018-12-23)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.7.0...v6.8.0)

**Implemented enhancements:**

- Update r10k path in example `prefix_command.rb` [\#467](https://github.com/voxpupuli/puppet-r10k/pull/467) ([alexjfisher](https://github.com/alexjfisher))
- Identify branch name from BitBucket server native webhook payload [\#462](https://github.com/voxpupuli/puppet-r10k/pull/462) ([venushka](https://github.com/venushka))

**Closed issues:**

- don't pin sinatra and webrick gems anymore [\#471](https://github.com/voxpupuli/puppet-r10k/issues/471)

**Merged pull requests:**

- set webrick and sinatra versions to 'installed' [\#475](https://github.com/voxpupuli/puppet-r10k/pull/475) ([kenyon](https://github.com/kenyon))
- enable acceptance tests [\#469](https://github.com/voxpupuli/puppet-r10k/pull/469) ([Dan33l](https://github.com/Dan33l))
- Remove gcc and make dependencies [\#465](https://github.com/voxpupuli/puppet-r10k/pull/465) ([Rudikza](https://github.com/Rudikza))

## [v6.7.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.7.0) (2018-10-13)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.6.1...v6.7.0)

**Implemented enhancements:**

- Allow usage of OS r10k packages [\#453](https://github.com/voxpupuli/puppet-r10k/pull/453) ([tuxmea](https://github.com/tuxmea))

**Fixed bugs:**

- Handle environment name normalized by r10k [\#452](https://github.com/voxpupuli/puppet-r10k/pull/452) ([sapakt](https://github.com/sapakt))

**Merged pull requests:**

- allow puppet 6.x [\#454](https://github.com/voxpupuli/puppet-r10k/pull/454) ([bastelfreak](https://github.com/bastelfreak))
- allow puppetlabs/stdlib 5.x [\#450](https://github.com/voxpupuli/puppet-r10k/pull/450) ([bastelfreak](https://github.com/bastelfreak))

## [v6.6.1](https://github.com/voxpupuli/puppet-r10k/tree/v6.6.1) (2018-07-29)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.6.0...v6.6.1)

**Fixed bugs:**

- Notify rocketchat in rescue of deploy environments [\#446](https://github.com/voxpupuli/puppet-r10k/pull/446) ([amateo](https://github.com/amateo))

**Closed issues:**

- Support BitBucket server's new webhook [\#436](https://github.com/voxpupuli/puppet-r10k/issues/436)

## [v6.6.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.6.0) (2018-07-05)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.5.1...v6.6.0)

**Implemented enhancements:**

- provide proper default for $r10k\_basedir [\#440](https://github.com/voxpupuli/puppet-r10k/pull/440) ([bastelfreak](https://github.com/bastelfreak))
- wrap is\_pe fact in fact\(\) method to fail safely if it isn't present [\#438](https://github.com/voxpupuli/puppet-r10k/pull/438) ([bastelfreak](https://github.com/bastelfreak))
- make cachedir optional [\#437](https://github.com/voxpupuli/puppet-r10k/pull/437) ([Andor](https://github.com/Andor))

**Closed issues:**

- Newest r10k breaks erb parsing [\#420](https://github.com/voxpupuli/puppet-r10k/issues/420)

**Merged pull requests:**

- Remove docker nodesets [\#434](https://github.com/voxpupuli/puppet-r10k/pull/434) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#433](https://github.com/voxpupuli/puppet-r10k/pull/433) ([bastelfreak](https://github.com/bastelfreak))

## [v6.5.1](https://github.com/voxpupuli/puppet-r10k/tree/v6.5.1) (2018-05-01)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.5.0...v6.5.1)

**Closed issues:**

- Syntax Error in voxpupuli/puppet-r10k/templates/webhook.bin.erb, line 119 [\#427](https://github.com/voxpupuli/puppet-r10k/issues/427)

**Merged pull requests:**

- Update webhook.bin.erb [\#428](https://github.com/voxpupuli/puppet-r10k/pull/428) ([rnelson0](https://github.com/rnelson0))

## [v6.5.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.5.0) (2018-04-25)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.4.0...v6.5.0)

**Fixed bugs:**

- Restart webhook service after package update/installation [\#419](https://github.com/voxpupuli/puppet-r10k/pull/419) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- undefined method `to\_h' in r10k.yaml.erb [\#421](https://github.com/voxpupuli/puppet-r10k/issues/421)

**Merged pull requests:**

- Release 6.5.0 [\#426](https://github.com/voxpupuli/puppet-r10k/pull/426) ([dhollinger](https://github.com/dhollinger))
- Remove Open3 and move process forks [\#425](https://github.com/voxpupuli/puppet-r10k/pull/425) ([dhollinger](https://github.com/dhollinger))
- Fixing compatibility with puppetserver/jruby. [\#424](https://github.com/voxpupuli/puppet-r10k/pull/424) ([dforste](https://github.com/dforste))
- Minor syntax update for deploying individual environment. [\#423](https://github.com/voxpupuli/puppet-r10k/pull/423) ([bschonec](https://github.com/bschonec))
- Add supports for rocketchat [\#413](https://github.com/voxpupuli/puppet-r10k/pull/413) ([amateo](https://github.com/amateo))

## [v6.4.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.4.0) (2018-03-28)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.3.2...v6.4.0)

**Implemented enhancements:**

- Using \#to\_yaml instead of printing each element [\#410](https://github.com/voxpupuli/puppet-r10k/pull/410) ([danzilio](https://github.com/danzilio))

**Fixed bugs:**

- Fix metadata for the deploy task [\#415](https://github.com/voxpupuli/puppet-r10k/pull/415) ([dnlsng](https://github.com/dnlsng))

**Closed issues:**

- r10k deploy not working with a minimal Puppetfile [\#409](https://github.com/voxpupuli/puppet-r10k/issues/409)
- Document bitbucket / stash config / hook\_exe behavior  [\#383](https://github.com/voxpupuli/puppet-r10k/issues/383)

**Merged pull requests:**

- bump puppet to latest supported version 4.10.0 [\#417](https://github.com/voxpupuli/puppet-r10k/pull/417) ([bastelfreak](https://github.com/bastelfreak))
- Propose small spelling changes [\#408](https://github.com/voxpupuli/puppet-r10k/pull/408) ([jeis2497052](https://github.com/jeis2497052))
- Restart mcollective if any of the managed files change [\#407](https://github.com/voxpupuli/puppet-r10k/pull/407) ([treydock](https://github.com/treydock))
- Implement locking for mcollective r10k to avoid multiple instances running in parallel [\#406](https://github.com/voxpupuli/puppet-r10k/pull/406) ([treydock](https://github.com/treydock))
- Add LSB tags to the webhook init script. [\#405](https://github.com/voxpupuli/puppet-r10k/pull/405) ([dickp](https://github.com/dickp))
- Add deploy task [\#400](https://github.com/voxpupuli/puppet-r10k/pull/400) ([binford2k](https://github.com/binford2k))
- add documentation for bitbucket webhook [\#384](https://github.com/voxpupuli/puppet-r10k/pull/384) ([khaefeli](https://github.com/khaefeli))

## [v6.3.2](https://github.com/voxpupuli/puppet-r10k/tree/v6.3.2) (2018-01-09)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.3.1...v6.3.2)

**Closed issues:**

- Request: Move webhook into a gem [\#399](https://github.com/voxpupuli/puppet-r10k/issues/399)

**Merged pull requests:**

- Bump upper limit of the make dependency [\#403](https://github.com/voxpupuli/puppet-r10k/pull/403) ([toepi](https://github.com/toepi))
- Pin webrick gem [\#401](https://github.com/voxpupuli/puppet-r10k/pull/401) ([D4rkSh1t](https://github.com/D4rkSh1t))

## [v6.3.1](https://github.com/voxpupuli/puppet-r10k/tree/v6.3.1) (2017-12-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.3.0...v6.3.1)

**Fixed bugs:**

- syntax errors when starting the webhook [\#394](https://github.com/voxpupuli/puppet-r10k/issues/394)
- Fix typo in webhook [\#396](https://github.com/voxpupuli/puppet-r10k/pull/396) ([alexjfisher](https://github.com/alexjfisher))

## [v6.3.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.3.0) (2017-11-26)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.2.0...v6.3.0)

**Closed issues:**

- /usr/local/bin/webhook PATH variable should include /usr/local/bundle/bin [\#373](https://github.com/voxpupuli/puppet-r10k/issues/373)

**Merged pull requests:**

- docs updates, remove top level CONTRIBUTING.md [\#390](https://github.com/voxpupuli/puppet-r10k/pull/390) ([wyardley](https://github.com/wyardley))
- Generate types option [\#389](https://github.com/voxpupuli/puppet-r10k/pull/389) ([dhollinger](https://github.com/dhollinger))

## [v6.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.2.0) (2017-10-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.1.0...v6.2.0)

**Implemented enhancements:**

- Bump upper limit of the vcsrepo and inifile dependencies [\#386](https://github.com/voxpupuli/puppet-r10k/pull/386) ([dhollinger](https://github.com/dhollinger))

**Merged pull requests:**

- Add logging messages [\#385](https://github.com/voxpupuli/puppet-r10k/pull/385) ([amateo](https://github.com/amateo))

## [v6.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.1.0) (2017-06-24)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v6.0.0...v6.1.0)

**Closed issues:**

- Clean up the log output when deleting a branch [\#374](https://github.com/voxpupuli/puppet-r10k/issues/374)

**Merged pull requests:**

- Quote the exact JSON response for `heartbeat` [\#379](https://github.com/voxpupuli/puppet-r10k/pull/379) ([bittner](https://github.com/bittner))
- Better handling for the default branch [\#376](https://github.com/voxpupuli/puppet-r10k/pull/376) ([rnelson0](https://github.com/rnelson0))
- Add Troubleshooting section \(logfile, heartbeat\) to README [\#375](https://github.com/voxpupuli/puppet-r10k/pull/375) ([bittner](https://github.com/bittner))
- Fix github license detection [\#372](https://github.com/voxpupuli/puppet-r10k/pull/372) ([alexjfisher](https://github.com/alexjfisher))

## [v6.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v6.0.0) (2017-05-10)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v5.0.2...v6.0.0)

**Breaking changes:**

- BREAKING: Fix webhook installation by pinning sinatra gem [\#366](https://github.com/voxpupuli/puppet-r10k/pull/366) ([alexjfisher](https://github.com/alexjfisher))

**Implemented enhancements:**

- Add slack\_proxy\_url parameter [\#368](https://github.com/voxpupuli/puppet-r10k/pull/368) ([alexjfisher](https://github.com/alexjfisher))

**Closed issues:**

- Support using webhook slack notifier through a proxy [\#367](https://github.com/voxpupuli/puppet-r10k/issues/367)
- webhook gems aren't installable [\#365](https://github.com/voxpupuli/puppet-r10k/issues/365)
- cachedir setting is not idempotent [\#351](https://github.com/voxpupuli/puppet-r10k/issues/351)
- webhook fails to auto-start on Systemd based systems [\#339](https://github.com/voxpupuli/puppet-r10k/issues/339)

**Merged pull requests:**

- Webhook: ability to pass extra arguments to mco [\#363](https://github.com/voxpupuli/puppet-r10k/pull/363) ([nike38rus](https://github.com/nike38rus))
- use stdlib puppet facts for configuration [\#352](https://github.com/voxpupuli/puppet-r10k/pull/352) ([vchepkov](https://github.com/vchepkov))
- Added /heartbeat url endpoint to webhook [\#272](https://github.com/voxpupuli/puppet-r10k/pull/272) ([thebaron](https://github.com/thebaron))

## [v5.0.2](https://github.com/voxpupuli/puppet-r10k/tree/v5.0.2) (2017-04-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v5.0.1...v5.0.2)

**Closed issues:**

- Webhook not compatible with Puppet 4.10.0 [\#359](https://github.com/voxpupuli/puppet-r10k/issues/359)

**Merged pull requests:**

- Add check to fix the ruby path on puppet 4.10.0 [\#360](https://github.com/voxpupuli/puppet-r10k/pull/360) ([dhollinger](https://github.com/dhollinger))
- Webhook: ignore deploying some environments [\#355](https://github.com/voxpupuli/puppet-r10k/pull/355) ([nike38rus](https://github.com/nike38rus))

## [v5.0.1](https://github.com/voxpupuli/puppet-r10k/tree/v5.0.1) (2017-04-06)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v5.0.0...v5.0.1)

**Closed issues:**

- Migrate r10k module to Vox Pupuli [\#290](https://github.com/voxpupuli/puppet-r10k/issues/290)

**Merged pull requests:**

- puppet-lint: fix arrow\_on\_right\_operand\_line [\#357](https://github.com/voxpupuli/puppet-r10k/pull/357) ([bastelfreak](https://github.com/bastelfreak))
- Create sanitize\_input helper method for strings sent to run\_command method. [\#356](https://github.com/voxpupuli/puppet-r10k/pull/356) ([xraystyle](https://github.com/xraystyle))
- Use styleguide compliant syntax for sshkey example. [\#353](https://github.com/voxpupuli/puppet-r10k/pull/353) ([kallies](https://github.com/kallies))
- Fix webhook slack\_username parameter handling [\#350](https://github.com/voxpupuli/puppet-r10k/pull/350) ([alexbrett](https://github.com/alexbrett))
- Webhook Background mode [\#349](https://github.com/voxpupuli/puppet-r10k/pull/349) ([luckyraul](https://github.com/luckyraul))

## [v5.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v5.0.0) (2017-03-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v4.2.0...v5.0.0)

**Closed issues:**

- r10k.yaml placement is incorrect [\#342](https://github.com/voxpupuli/puppet-r10k/issues/342)

**Merged pull requests:**

- r10k.yaml contents indentation is incorrect [\#345](https://github.com/voxpupuli/puppet-r10k/pull/345) ([Kotty666](https://github.com/Kotty666))
- Update yaml location for \>PE3 [\#343](https://github.com/voxpupuli/puppet-r10k/pull/343) ([rnelson0](https://github.com/rnelson0))
- replace all validate functions with datatypes [\#341](https://github.com/voxpupuli/puppet-r10k/pull/341) ([bastelfreak](https://github.com/bastelfreak))
- Cleanup webhook use case notes; specifically PE/FOSS split. [\#338](https://github.com/voxpupuli/puppet-r10k/pull/338) ([rnelson0](https://github.com/rnelson0))
- Remove support for Puppet 3 and Ruby \<2.0.0 [\#321](https://github.com/voxpupuli/puppet-r10k/pull/321) ([rnelson0](https://github.com/rnelson0))
- Ensure webhook run folder exists on redhat systemd environments [\#283](https://github.com/voxpupuli/puppet-r10k/pull/283) ([luisfdez](https://github.com/luisfdez))

## [v4.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v4.2.0) (2017-02-12)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v4.1.0...v4.2.0)

**Closed issues:**

- Add support for changing deploy settings [\#332](https://github.com/voxpupuli/puppet-r10k/issues/332)
- Document breaking changes in CHANGELOG [\#306](https://github.com/voxpupuli/puppet-r10k/issues/306)
- Status 42, OK, but it doesn't completely work [\#261](https://github.com/voxpupuli/puppet-r10k/issues/261)

**Merged pull requests:**

- Added new 'deploy\_settings' information [\#334](https://github.com/voxpupuli/puppet-r10k/pull/334) ([triforce](https://github.com/triforce))
- Add support for changing the 'deploy' settings in the r10k.yaml configuration file [\#333](https://github.com/voxpupuli/puppet-r10k/pull/333) ([triforce](https://github.com/triforce))
- Added Slack webhook [\#331](https://github.com/voxpupuli/puppet-r10k/pull/331) ([jamtur01](https://github.com/jamtur01))
- mcollective plugin dir has changed for foss puppet 4 [\#330](https://github.com/voxpupuli/puppet-r10k/pull/330) ([attachmentgenie](https://github.com/attachmentgenie))
- Better document soft dependency abrader/gms [\#327](https://github.com/voxpupuli/puppet-r10k/pull/327) ([rnelson0](https://github.com/rnelson0))

## [v4.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v4.1.0) (2017-01-06)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v4.0.2...v4.1.0)

**Closed issues:**

- Conflict between r10k subclasses and pe\_r10k due to `require r10k` in subclasses [\#323](https://github.com/voxpupuli/puppet-r10k/issues/323)
- Re-visit hard-coded version - 1.5.1 [\#284](https://github.com/voxpupuli/puppet-r10k/issues/284)
- \(maint\) Remove ruby 1.8.7 support from the module [\#231](https://github.com/voxpupuli/puppet-r10k/issues/231)

**Merged pull requests:**

- \(GH323\) Better parameterization of root user/group from \#279 [\#324](https://github.com/voxpupuli/puppet-r10k/pull/324) ([rnelson0](https://github.com/rnelson0))
- Fix rubocop failures from \#268 [\#322](https://github.com/voxpupuli/puppet-r10k/pull/322) ([rnelson0](https://github.com/rnelson0))
- Bump minimum version dependencies \(for Puppet 4\) [\#318](https://github.com/voxpupuli/puppet-r10k/pull/318) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Bump puppet minimum version\_requirement to 3.8.7 [\#315](https://github.com/voxpupuli/puppet-r10k/pull/315) ([juniorsysadmin](https://github.com/juniorsysadmin))
- \[284\] Replace hard-coded version 1.5.1 with installed [\#308](https://github.com/voxpupuli/puppet-r10k/pull/308) ([rnelson0](https://github.com/rnelson0))
- use puppet/make instead of deprecated croddy/make [\#307](https://github.com/voxpupuli/puppet-r10k/pull/307) ([croddy](https://github.com/croddy))
- Lockfile to mitigate r10k race condition. [\#268](https://github.com/voxpupuli/puppet-r10k/pull/268) ([binford2k](https://github.com/binford2k))

## [v4.0.2](https://github.com/voxpupuli/puppet-r10k/tree/v4.0.2) (2016-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v4.0.1...v4.0.2)

## [v4.0.1](https://github.com/voxpupuli/puppet-r10k/tree/v4.0.1) (2016-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v4.0.0...v4.0.1)

**Merged pull requests:**

- Changelog for 4.0.1 [\#304](https://github.com/voxpupuli/puppet-r10k/pull/304) ([rnelson0](https://github.com/rnelson0))

## [v4.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v4.0.0) (2016-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v3.2.0...v4.0.0)

**Closed issues:**

- 'require git' appears to be unnecessary [\#286](https://github.com/voxpupuli/puppet-r10k/issues/286)
- Webhook cannot do new puppet module install [\#280](https://github.com/voxpupuli/puppet-r10k/issues/280)
- mcollective agent unable to find r10k binary [\#275](https://github.com/voxpupuli/puppet-r10k/issues/275)
- MCollective r10k only syncs git based modules [\#273](https://github.com/voxpupuli/puppet-r10k/issues/273)
- images in README.md broken [\#263](https://github.com/voxpupuli/puppet-r10k/issues/263)

**Merged pull requests:**

- Rename CHANGELOG.md [\#301](https://github.com/voxpupuli/puppet-r10k/pull/301) ([rnelson0](https://github.com/rnelson0))
- Fixes Puppet 4 path for webhook [\#295](https://github.com/voxpupuli/puppet-r10k/pull/295) ([andrewwippler](https://github.com/andrewwippler))
- Update config\_version.sh [\#291](https://github.com/voxpupuli/puppet-r10k/pull/291) ([LinguineCode](https://github.com/LinguineCode))
- Fix testing [\#288](https://github.com/voxpupuli/puppet-r10k/pull/288) ([ghoneycutt](https://github.com/ghoneycutt))
- Duplicate certpath key [\#287](https://github.com/voxpupuli/puppet-r10k/pull/287) ([LinguineCode](https://github.com/LinguineCode))
- unbreak on OS where root group != 'root' [\#279](https://github.com/voxpupuli/puppet-r10k/pull/279) ([buzzdeee](https://github.com/buzzdeee))
- Add support for custom permissions and ownership of webhooks.yaml [\#278](https://github.com/voxpupuli/puppet-r10k/pull/278) ([elconas](https://github.com/elconas))
- add curl example to readme [\#274](https://github.com/voxpupuli/puppet-r10k/pull/274) ([jessereynolds](https://github.com/jessereynolds))
- fix mcollective image [\#264](https://github.com/voxpupuli/puppet-r10k/pull/264) ([mmckinst](https://github.com/mmckinst))
- Add GitHub signature [\#262](https://github.com/voxpupuli/puppet-r10k/pull/262) ([ayohrling](https://github.com/ayohrling))

## [v3.2.0](https://github.com/voxpupuli/puppet-r10k/tree/v3.2.0) (2015-12-16)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v3.1.1...v3.2.0)

**Implemented enhancements:**

- \(feature\) Add forge\_settings param from pe\_r10k [\#244](https://github.com/voxpupuli/puppet-r10k/issues/244)

**Closed issues:**

- Agent activation fails on mcollective 2.8.6 \(open source puppet 4.2\) [\#254](https://github.com/voxpupuli/puppet-r10k/issues/254)
- Mcollective plugins\_dir is incorrect for FOSS Puppet 4  [\#245](https://github.com/voxpupuli/puppet-r10k/issues/245)

**Merged pull requests:**

- Support for TFS/Visual Studio Git [\#259](https://github.com/voxpupuli/puppet-r10k/pull/259) ([jpadams](https://github.com/jpadams))
- Add option to lowercase environment names [\#256](https://github.com/voxpupuli/puppet-r10k/pull/256) ([binford2k](https://github.com/binford2k))
- adding server\_software option to obscure the server software in use [\#253](https://github.com/voxpupuli/puppet-r10k/pull/253) ([uphillian](https://github.com/uphillian))
- postrun array requires spaces between elements [\#252](https://github.com/voxpupuli/puppet-r10k/pull/252) ([mpeter](https://github.com/mpeter))
- Grab the correct field for repo username [\#251](https://github.com/voxpupuli/puppet-r10k/pull/251) ([binford2k](https://github.com/binford2k))
- Handle tagged release events [\#250](https://github.com/voxpupuli/puppet-r10k/pull/250) ([binford2k](https://github.com/binford2k))
- configure forge settings with config class [\#249](https://github.com/voxpupuli/puppet-r10k/pull/249) ([juame](https://github.com/juame))
- Align webhook prefix command behavior with r10k behavior [\#248](https://github.com/voxpupuli/puppet-r10k/pull/248) ([stepanstipl](https://github.com/stepanstipl))
- Log when r10k not found in PATH [\#247](https://github.com/voxpupuli/puppet-r10k/pull/247) ([joshbeard](https://github.com/joshbeard))
- update plugins\_dir for FOSS puppet [\#246](https://github.com/voxpupuli/puppet-r10k/pull/246) ([velocity303](https://github.com/velocity303))
- create the /etc/puppetlabs/r10k directory [\#242](https://github.com/voxpupuli/puppet-r10k/pull/242) ([mmckinst](https://github.com/mmckinst))
- Add single request concurrency option in r10k webhook [\#240](https://github.com/voxpupuli/puppet-r10k/pull/240) ([pdaukintis](https://github.com/pdaukintis))

## [v3.1.1](https://github.com/voxpupuli/puppet-r10k/tree/v3.1.1) (2015-08-12)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v3.1.0...v3.1.1)

**Implemented enhancements:**

- \(Feature\) Webhook: Add timestamp to mco\_output.log [\#215](https://github.com/voxpupuli/puppet-r10k/issues/215)

**Fixed bugs:**

- stderr of the which command shows during Puppet runs on agent nodes [\#241](https://github.com/voxpupuli/puppet-r10k/issues/241)

## [v3.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v3.1.0) (2015-08-10)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.8.4...v3.1.0)

**Merged pull requests:**

- Fix typo [\#238](https://github.com/voxpupuli/puppet-r10k/pull/238) ([mcanevet](https://github.com/mcanevet))
- Automatically calculate some prefixes [\#236](https://github.com/voxpupuli/puppet-r10k/pull/236) ([binford2k](https://github.com/binford2k))
- Add the ability to respond only to certain events [\#235](https://github.com/voxpupuli/puppet-r10k/pull/235) ([binford2k](https://github.com/binford2k))
- Let rb scripts resolve what ruby to use themselves [\#233](https://github.com/voxpupuli/puppet-r10k/pull/233) ([attachmentgenie](https://github.com/attachmentgenie))
- Making r10k webhook 2015.x compatible [\#229](https://github.com/voxpupuli/puppet-r10k/pull/229) ([WhatsARanjit](https://github.com/WhatsARanjit))

## [v2.8.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.8.4) (2015-08-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v3.0.0...v2.8.4)

## [v3.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v3.0.0) (2015-07-31)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.8.3...v3.0.0)

**Implemented enhancements:**

- \[Feature\] Support BitBucket Pull-merge in Webhook \(or other git services with non-standard webhooks\) [\#192](https://github.com/voxpupuli/puppet-r10k/issues/192)
- Added support for BitBucket merge hooks [\#193](https://github.com/voxpupuli/puppet-r10k/pull/193) ([ayohrling](https://github.com/ayohrling))

**Closed issues:**

- r10k and Webhook install using system ruby on CentOS 6 using Puppet 4.2.0 from "Puppet Collection 1" repo. [\#220](https://github.com/voxpupuli/puppet-r10k/issues/220)
- Feature Request: add a r10k postrun hook for directory environment cache invalidation [\#211](https://github.com/voxpupuli/puppet-r10k/issues/211)
- Feature Request: custom fact location of r10k binary [\#210](https://github.com/voxpupuli/puppet-r10k/issues/210)
- webhook.yaml recreated on every puppet run [\#209](https://github.com/voxpupuli/puppet-r10k/issues/209)
- Permissions for environments created by the webhook are incorrect [\#191](https://github.com/voxpupuli/puppet-r10k/issues/191)
- move r10k.yaml to /etc/puppetlabs/r10k/r10k.yaml [\#190](https://github.com/voxpupuli/puppet-r10k/issues/190)
- Webhook issues for init service without hasstatus=\> false [\#188](https://github.com/voxpupuli/puppet-r10k/issues/188)
- puppetconf\_path is incorrect for puppet4 [\#187](https://github.com/voxpupuli/puppet-r10k/issues/187)
- use of ::pe\_version fails puppet run when strict\_variables is enabled on foss puppet [\#160](https://github.com/voxpupuli/puppet-r10k/issues/160)

**Merged pull requests:**

- Mco plugin directory is corrected [\#230](https://github.com/voxpupuli/puppet-r10k/pull/230) ([WhatsARanjit](https://github.com/WhatsARanjit))
- OpenBSD 5.8 switches default ruby version to 2.2, therefore [\#228](https://github.com/voxpupuli/puppet-r10k/pull/228) ([buzzdeee](https://github.com/buzzdeee))
- Added support for BitBucket push webhooks. [\#227](https://github.com/voxpupuli/puppet-r10k/pull/227) ([dharmabruce](https://github.com/dharmabruce))
- Moved r10k file and basedir [\#226](https://github.com/voxpupuli/puppet-r10k/pull/226) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Provider for 2015.x uses puppet\_gem instead of pe\_gem [\#225](https://github.com/voxpupuli/puppet-r10k/pull/225) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Puppet 4 Changes [\#224](https://github.com/voxpupuli/puppet-r10k/pull/224) ([acidprime](https://github.com/acidprime))
- Add a custom fact 'r10k\_path' [\#222](https://github.com/voxpupuli/puppet-r10k/pull/222) ([poikilotherm](https://github.com/poikilotherm))

## [v2.8.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.8.3) (2015-07-17)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.8.2...v2.8.3)

**Implemented enhancements:**

- \[Bug\] Webhook does not support Ping event from GitHub [\#89](https://github.com/voxpupuli/puppet-r10k/issues/89)

**Closed issues:**

- hiera\_eyaml on pe 3.7+  is broken. [\#216](https://github.com/voxpupuli/puppet-r10k/issues/216)
- webhook::package inclusion in r10k::webhook class [\#213](https://github.com/voxpupuli/puppet-r10k/issues/213)
- systemd issues on RHEL7 [\#208](https://github.com/voxpupuli/puppet-r10k/issues/208)
- systemd doesn't detect webhook as running [\#207](https://github.com/voxpupuli/puppet-r10k/issues/207)

**Merged pull requests:**

- \(METHOD-401\) Fix Webhook Service on EL7 [\#218](https://github.com/voxpupuli/puppet-r10k/pull/218) ([jveski](https://github.com/jveski))
- Changes in r10k::webhook class [\#214](https://github.com/voxpupuli/puppet-r10k/pull/214) ([pdaukintis](https://github.com/pdaukintis))
- Add EnvironmentFile line as optional [\#206](https://github.com/voxpupuli/puppet-r10k/pull/206) ([brandonweeks](https://github.com/brandonweeks))

## [v2.8.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.8.2) (2015-06-26)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.8.1...v2.8.2)

## [v2.8.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.8.1) (2015-06-24)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.8.0...v2.8.1)

**Implemented enhancements:**

- \[Deprecation\] Remove purgedirs support [\#84](https://github.com/voxpupuli/puppet-r10k/pull/84) ([trlinkin](https://github.com/trlinkin))

**Closed issues:**

- NoMethodError when GitHub send webhook 'ping'  [\#200](https://github.com/voxpupuli/puppet-r10k/issues/200)
- EnvironmentFile removed from webhook unit file [\#197](https://github.com/voxpupuli/puppet-r10k/issues/197)
- Webhook returns status 200 even if deploy fails [\#195](https://github.com/voxpupuli/puppet-r10k/issues/195)
- webhook script should write a pidfile [\#171](https://github.com/voxpupuli/puppet-r10k/issues/171)
- Change git\_ssl\_verify parameter name [\#165](https://github.com/voxpupuli/puppet-r10k/issues/165)

**Merged pull requests:**

- R10k/issues/200 [\#201](https://github.com/voxpupuli/puppet-r10k/pull/201) ([brandonweeks](https://github.com/brandonweeks))
- Return http 500 instead of http 200 on error [\#199](https://github.com/voxpupuli/puppet-r10k/pull/199) ([brandonweeks](https://github.com/brandonweeks))
- Restore EnvironmentFile line as optional [\#198](https://github.com/voxpupuli/puppet-r10k/pull/198) ([brandonweeks](https://github.com/brandonweeks))
- 188 - Webhook segfault on status [\#194](https://github.com/voxpupuli/puppet-r10k/pull/194) ([ayohrling](https://github.com/ayohrling))
- add puppet\_gem provider [\#186](https://github.com/voxpupuli/puppet-r10k/pull/186) ([mmckinst](https://github.com/mmckinst))
- Added webhook\_group parameter lost in 0da328831ecd49c2671017e16d614dbdc1842b7c [\#185](https://github.com/voxpupuli/puppet-r10k/pull/185) ([vchepkov](https://github.com/vchepkov))
- Change the way the webhook logs the r10k deploy command [\#184](https://github.com/voxpupuli/puppet-r10k/pull/184) ([tampakrap](https://github.com/tampakrap))
- Include the r10k::webhook::config class in r10k::webhook [\#183](https://github.com/voxpupuli/puppet-r10k/pull/183) ([tampakrap](https://github.com/tampakrap))
- improve the webhook systemd unit file [\#182](https://github.com/voxpupuli/puppet-r10k/pull/182) ([tampakrap](https://github.com/tampakrap))
- Updates in the webhook config [\#181](https://github.com/voxpupuli/puppet-r10k/pull/181) ([tampakrap](https://github.com/tampakrap))
- Conditionally install the webhook packages [\#180](https://github.com/voxpupuli/puppet-r10k/pull/180) ([tampakrap](https://github.com/tampakrap))
- Add SUSE support in the webhook init file [\#179](https://github.com/voxpupuli/puppet-r10k/pull/179) ([tampakrap](https://github.com/tampakrap))
- Remove the hardcoded hasstatus =\> false from the webhook service [\#178](https://github.com/voxpupuli/puppet-r10k/pull/178) ([tampakrap](https://github.com/tampakrap))
- Move the $webhook::{user,group} definition to params.pp [\#177](https://github.com/voxpupuli/puppet-r10k/pull/177) ([tampakrap](https://github.com/tampakrap))
- Use the webhook's systemd service file for openSUSE \>= 12.1 and SLE12 [\#176](https://github.com/voxpupuli/puppet-r10k/pull/176) ([tampakrap](https://github.com/tampakrap))
- webhook: include mcollective optionally [\#175](https://github.com/voxpupuli/puppet-r10k/pull/175) ([tampakrap](https://github.com/tampakrap))
- Fix for \#165 [\#174](https://github.com/voxpupuli/puppet-r10k/pull/174) ([petems](https://github.com/petems))
- Actually run as non-root, --user is for matching not chuid. [\#173](https://github.com/voxpupuli/puppet-r10k/pull/173) ([robbat2](https://github.com/robbat2))
- Gentoo & Pidfile/Init fixes [\#172](https://github.com/voxpupuli/puppet-r10k/pull/172) ([robbat2](https://github.com/robbat2))
- Fix non-ssl, abilliy to customize templates, and run with less privileges \(but call r10k/mco via sudo\) [\#170](https://github.com/voxpupuli/puppet-r10k/pull/170) ([robbat2](https://github.com/robbat2))
- Update stash\_mco.rb [\#169](https://github.com/voxpupuli/puppet-r10k/pull/169) ([rdrgmnzs](https://github.com/rdrgmnzs))
- Fix a few typos. [\#167](https://github.com/voxpupuli/puppet-r10k/pull/167) ([gabe-sky](https://github.com/gabe-sky))
- Add support for OpenBSD, some noteworthy points to mention: [\#163](https://github.com/voxpupuli/puppet-r10k/pull/163) ([buzzdeee](https://github.com/buzzdeee))
- add logic to prevent issue with pe\_version on foss puppet with strict\_variables enabled [\#161](https://github.com/voxpupuli/puppet-r10k/pull/161) ([smithtrevor](https://github.com/smithtrevor))

## [v2.8.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.8.0) (2015-05-12)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.7.4...v2.8.0)

**Closed issues:**

- Webhook does not install properly in PE 3.7 [\#164](https://github.com/voxpupuli/puppet-r10k/issues/164)

**Merged pull requests:**

- Systemd [\#168](https://github.com/voxpupuli/puppet-r10k/pull/168) ([trlinkin](https://github.com/trlinkin))

## [v2.7.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.7.4) (2015-05-08)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.7.3...v2.7.4)

**Closed issues:**

- Webhook: Invalid yaml and unstartable service with FOSS [\#162](https://github.com/voxpupuli/puppet-r10k/issues/162)

**Merged pull requests:**

- \(162\) Revert to original webhook.yaml.erb contents [\#166](https://github.com/voxpupuli/puppet-r10k/pull/166) ([rnelson0](https://github.com/rnelson0))
- Update r10k gem version for v2.7.x module version [\#159](https://github.com/voxpupuli/puppet-r10k/pull/159) ([aharden](https://github.com/aharden))

## [v2.7.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.7.3) (2015-04-22)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.7.2...v2.7.3)

## [v2.7.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.7.2) (2015-04-21)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.7.1...v2.7.2)

**Closed issues:**

- Gem install has the space problem regressed. [\#155](https://github.com/voxpupuli/puppet-r10k/issues/155)

## [v2.7.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.7.1) (2015-04-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.7.0...v2.7.1)

**Implemented enhancements:**

- /var/log/webhook permissions not managed properly [\#144](https://github.com/voxpupuli/puppet-r10k/issues/144)

**Fixed bugs:**

- Sinatra gem required for PE webhook? [\#154](https://github.com/voxpupuli/puppet-r10k/issues/154)

**Merged pull requests:**

- Support of Puppet FOSS for Webhook [\#150](https://github.com/voxpupuli/puppet-r10k/pull/150) ([acidprime](https://github.com/acidprime))

## [v2.7.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.7.0) (2015-04-08)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.6.5...v2.7.0)

**Implemented enhancements:**

- \[enhancement\] mcollective agent as non-root [\#135](https://github.com/voxpupuli/puppet-r10k/issues/135)

**Fixed bugs:**

- Module upgrade does not upgrade r10k gem [\#126](https://github.com/voxpupuli/puppet-r10k/issues/126)
- Option to NOT install the r10k package [\#74](https://github.com/voxpupuli/puppet-r10k/issues/74)

**Merged pull requests:**

- 3.x [\#148](https://github.com/voxpupuli/puppet-r10k/pull/148) ([acidprime](https://github.com/acidprime))
- fix for /var/run being mounted on tmpfs in ubuntu 14.04 [\#147](https://github.com/voxpupuli/puppet-r10k/pull/147) ([spidersddd](https://github.com/spidersddd))
- Add commas in README example [\#143](https://github.com/voxpupuli/puppet-r10k/pull/143) ([cmurphy](https://github.com/cmurphy))
- support for 'user' argument to su to another user when executing git and R10K [\#142](https://github.com/voxpupuli/puppet-r10k/pull/142) ([GeoffWilliams](https://github.com/GeoffWilliams))

## [v2.6.5](https://github.com/voxpupuli/puppet-r10k/tree/v2.6.5) (2015-03-18)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.6.4...v2.6.5)

**Fixed bugs:**

- web hook does not work for non-mco install [\#139](https://github.com/voxpupuli/puppet-r10k/issues/139)

**Closed issues:**

- Add Gitlab support \(or add Gitlab documentation\) [\#145](https://github.com/voxpupuli/puppet-r10k/issues/145)

## [v2.6.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.6.4) (2015-02-26)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.6.3...v2.6.4)

**Fixed bugs:**

- puppet enterprise 3.7.0 webhook \(no mcollective\) ordering problem [\#138](https://github.com/voxpupuli/puppet-r10k/issues/138)
- pre\_commit ruby script fails puppet-lint if you are in the wrong working directory [\#130](https://github.com/voxpupuli/puppet-r10k/issues/130)
- webhook does not normalize branch name [\#115](https://github.com/voxpupuli/puppet-r10k/issues/115)

## [v2.6.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.6.3) (2015-02-24)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.6.2...v2.6.3)

**Merged pull requests:**

- Ensure webhook dependencies are met before running the service [\#134](https://github.com/voxpupuli/puppet-r10k/pull/134) ([elyscape](https://github.com/elyscape))

## [v2.6.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.6.2) (2015-02-19)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.6.1...v2.6.2)

**Fixed bugs:**

- webhook module tries to start up before the mcollective cert is installed [\#132](https://github.com/voxpupuli/puppet-r10k/issues/132)

**Merged pull requests:**

- issue \#132 making peadmin-cert.pem execute before webhook init script [\#133](https://github.com/voxpupuli/puppet-r10k/pull/133) ([harrytford](https://github.com/harrytford))
- Support puppet-lint v1 [\#131](https://github.com/voxpupuli/puppet-r10k/pull/131) ([ghoneycutt](https://github.com/ghoneycutt))
- Travis-ci to use faster container based systems [\#129](https://github.com/voxpupuli/puppet-r10k/pull/129) ([ghoneycutt](https://github.com/ghoneycutt))
- Support Puppet v3.7.x [\#128](https://github.com/voxpupuli/puppet-r10k/pull/128) ([ghoneycutt](https://github.com/ghoneycutt))

## [v2.6.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.6.1) (2015-02-13)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.6.0...v2.6.1)

**Merged pull requests:**

- Add r10k\_deploy\_arguments for non-MCO deploys [\#125](https://github.com/voxpupuli/puppet-r10k/pull/125) ([glarizza](https://github.com/glarizza))

## [v2.6.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.6.0) (2015-02-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.5.4...v2.6.0)

**Merged pull requests:**

- Use 0.0.0.0 as default webhook bind address [\#124](https://github.com/voxpupuli/puppet-r10k/pull/124) ([elyscape](https://github.com/elyscape))
- Added bind\_address option to webhook.yaml [\#123](https://github.com/voxpupuli/puppet-r10k/pull/123) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Use zypper as default provider for openSUSE [\#122](https://github.com/voxpupuli/puppet-r10k/pull/122) ([tampakrap](https://github.com/tampakrap))
- added metadata.json file for puppet versions 3.6 and older [\#121](https://github.com/voxpupuli/puppet-r10k/pull/121) ([vchepkov](https://github.com/vchepkov))
- Update webhook.pp - adjusted peadmin-cert.pem [\#120](https://github.com/voxpupuli/puppet-r10k/pull/120) ([aharden](https://github.com/aharden))

## [v2.5.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.5.4) (2015-02-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.5.3...v2.5.4)

**Closed issues:**

- mco doesn't deploy modules when using forge functionality of Puppetfile [\#65](https://github.com/voxpupuli/puppet-r10k/issues/65)

## [v2.5.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.5.3) (2015-01-29)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.5.2...v2.5.3)

**Closed issues:**

- Dependency disappeared from forge. [\#116](https://github.com/voxpupuli/puppet-r10k/issues/116)
- Ubuntu 14.04 webhook init fails [\#105](https://github.com/voxpupuli/puppet-r10k/issues/105)
- r10k::webhook::config provides support for changing config file path, but the webhook script has this hardcoded [\#90](https://github.com/voxpupuli/puppet-r10k/issues/90)

**Merged pull requests:**

- Remove +x permissions from peadmin-cert.pem [\#119](https://github.com/voxpupuli/puppet-r10k/pull/119) ([elyscape](https://github.com/elyscape))
- 105 updated webhook.ini.erb for ubuntu support [\#118](https://github.com/voxpupuli/puppet-r10k/pull/118) ([MarsuperMammal](https://github.com/MarsuperMammal))

## [v2.5.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.5.2) (2015-01-16)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.5.1...v2.5.2)

**Closed issues:**

- invalid\_branches configuration [\#85](https://github.com/voxpupuli/puppet-r10k/issues/85)
- Feature Request: Updated doc to use hieradata for sources [\#80](https://github.com/voxpupuli/puppet-r10k/issues/80)

**Merged pull requests:**

- depend on croddy/make instead of mhuffnagle/make [\#117](https://github.com/voxpupuli/puppet-r10k/pull/117) ([croddy](https://github.com/croddy))
- support strict\_variables = true [\#114](https://github.com/voxpupuli/puppet-r10k/pull/114) ([jlambert121](https://github.com/jlambert121))

## [v2.5.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.5.1) (2014-12-17)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.5.0...v2.5.1)

## [v2.5.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.5.0) (2014-12-17)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.4.4...v2.5.0)

**Closed issues:**

- PE 3.7.0 breaks webhook, peadmin cert name changed [\#110](https://github.com/voxpupuli/puppet-r10k/issues/110)
- r10k 1.4.0 has been released [\#106](https://github.com/voxpupuli/puppet-r10k/issues/106)
- Missing dependency on webhook after upgrade to PE 3.7.0 [\#104](https://github.com/voxpupuli/puppet-r10k/issues/104)
- webhook should support r10k deploy module foo end point [\#101](https://github.com/voxpupuli/puppet-r10k/issues/101)

**Merged pull requests:**

- Spelling [\#111](https://github.com/voxpupuli/puppet-r10k/pull/111) ([skibum55](https://github.com/skibum55))

## [v2.4.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.4.4) (2014-12-15)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.4.3...v2.4.4)

**Closed issues:**

- Webhook sends incorrect command to r10k if branch name contains / [\#108](https://github.com/voxpupuli/puppet-r10k/issues/108)
- Documentation issues [\#99](https://github.com/voxpupuli/puppet-r10k/issues/99)

**Merged pull requests:**

- Handle branch names containing slashes [\#109](https://github.com/voxpupuli/puppet-r10k/pull/109) ([elyscape](https://github.com/elyscape))
- prevent potential leakage of Default {} resources [\#107](https://github.com/voxpupuli/puppet-r10k/pull/107) ([igalic](https://github.com/igalic))
- Documentation fixes [\#103](https://github.com/voxpupuli/puppet-r10k/pull/103) ([elyscape](https://github.com/elyscape))

## [v2.4.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.4.3) (2014-11-22)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.4.2...v2.4.3)

**Closed issues:**

- Versions and the Puppet Forge [\#100](https://github.com/voxpupuli/puppet-r10k/issues/100)

## [v2.4.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.4.2) (2014-11-21)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.4.1...v2.4.2)

## [v2.4.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.4.1) (2014-11-21)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.4.0...v2.4.1)

## [v2.4.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.4.0) (2014-11-21)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.3.4...v2.4.0)

**Closed issues:**

- r10k 1.3.5 has been released [\#98](https://github.com/voxpupuli/puppet-r10k/issues/98)

## [v2.3.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.3.4) (2014-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.3.3...v2.3.4)

**Closed issues:**

- Webhook service does not start at boot [\#94](https://github.com/voxpupuli/puppet-r10k/issues/94)
- Webhook service is not refreshed when config file changes [\#93](https://github.com/voxpupuli/puppet-r10k/issues/93)

**Merged pull requests:**

- Refresh webhook service when config file changes [\#91](https://github.com/voxpupuli/puppet-r10k/pull/91) ([elyscape](https://github.com/elyscape))

## [v2.3.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.3.3) (2014-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.3.2...v2.3.3)

**Closed issues:**

- Add release tag for 2.3.1 [\#92](https://github.com/voxpupuli/puppet-r10k/issues/92)

**Merged pull requests:**

- Check for variations of $is\_pe [\#97](https://github.com/voxpupuli/puppet-r10k/pull/97) ([zachfi](https://github.com/zachfi))

## [v2.3.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.3.2) (2014-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.3.1...v2.3.2)

**Merged pull requests:**

- Replaced references to type\(\) function with is\_string\(\) for Puppet 3.7.x... [\#96](https://github.com/voxpupuli/puppet-r10k/pull/96) ([zachfi](https://github.com/zachfi))

## [v2.3.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.3.1) (2014-11-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.3.0...v2.3.1)

**Closed issues:**

- `pe_gem` install of the r10k gem is wonked [\#87](https://github.com/voxpupuli/puppet-r10k/issues/87)
- mco r10k sync leave environment in a broken state [\#77](https://github.com/voxpupuli/puppet-r10k/issues/77)
- Please cut new release [\#76](https://github.com/voxpupuli/puppet-r10k/issues/76)
- Remove technology stack dependencies from installation process [\#66](https://github.com/voxpupuli/puppet-r10k/issues/66)
- License [\#53](https://github.com/voxpupuli/puppet-r10k/issues/53)
- Dependency on puppetlabs-ruby constrains use [\#49](https://github.com/voxpupuli/puppet-r10k/issues/49)

**Merged pull requests:**

- Change install\_options to undef [\#88](https://github.com/voxpupuli/puppet-r10k/pull/88) ([binford2k](https://github.com/binford2k))
- Fix tests for manage\_ruby\_dependency =\> 'include' [\#86](https://github.com/voxpupuli/puppet-r10k/pull/86) ([gsarjeant](https://github.com/gsarjeant))
- Allow for non-linux [\#83](https://github.com/voxpupuli/puppet-r10k/pull/83) ([zachfi](https://github.com/zachfi))
- Update CHANGELOG [\#82](https://github.com/voxpupuli/puppet-r10k/pull/82) ([ghoneycutt](https://github.com/ghoneycutt))
- bumped version 1.3.4 [\#81](https://github.com/voxpupuli/puppet-r10k/pull/81) ([kennyg](https://github.com/kennyg))

## [v2.3.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.3.0) (2014-09-15)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.8...v2.3.0)

**Closed issues:**

- Invalid path to r10k.ddl [\#72](https://github.com/voxpupuli/puppet-r10k/issues/72)
- trouble with remote ssl posts from stash to the webhook [\#62](https://github.com/voxpupuli/puppet-r10k/issues/62)

**Merged pull requests:**

- Stash webhook helper [\#78](https://github.com/voxpupuli/puppet-r10k/pull/78) ([adamcrews](https://github.com/adamcrews))
- Allow prefixing to be optional [\#75](https://github.com/voxpupuli/puppet-r10k/pull/75) ([trlinkin](https://github.com/trlinkin))
- Fixes \#72 [\#73](https://github.com/voxpupuli/puppet-r10k/pull/73) ([robruma](https://github.com/robruma))
- provide a knob to flexibly manage the ruby requirement [\#67](https://github.com/voxpupuli/puppet-r10k/pull/67) ([wolfspyre](https://github.com/wolfspyre))

## [v2.2.8](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.8) (2014-08-28)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.7...v2.2.8)

**Closed issues:**

- r10k::include\_prerun\_command doesn't apply changes during the current run [\#69](https://github.com/voxpupuli/puppet-r10k/issues/69)
- breaking master when I apply r10k config [\#64](https://github.com/voxpupuli/puppet-r10k/issues/64)
- update params.pp to the latest r10k? [\#60](https://github.com/voxpupuli/puppet-r10k/issues/60)
- Missing dependency on service mcollective [\#39](https://github.com/voxpupuli/puppet-r10k/issues/39)
- Deploy single environment with Puppetfile [\#21](https://github.com/voxpupuli/puppet-r10k/issues/21)

**Merged pull requests:**

- Fix minor lint issues [\#71](https://github.com/voxpupuli/puppet-r10k/pull/71) ([adamcrews](https://github.com/adamcrews))
- change webhook exec to execute the command built previously [\#70](https://github.com/voxpupuli/puppet-r10k/pull/70) ([k-f](https://github.com/k-f))
- Adding support for application/x-www-form-urlencoded content type webhooks [\#68](https://github.com/voxpupuli/puppet-r10k/pull/68) ([robruma](https://github.com/robruma))
- Fix default postrun\_command [\#63](https://github.com/voxpupuli/puppet-r10k/pull/63) ([joshbeard](https://github.com/joshbeard))

## [v2.2.7](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.7) (2014-07-16)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.6...v2.2.7)

## [v2.2.6](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.6) (2014-07-16)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.5...v2.2.6)

## [v2.2.5](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.5) (2014-07-16)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.4...v2.2.5)

**Closed issues:**

- Deploy single environment and prerun\_command  [\#52](https://github.com/voxpupuli/puppet-r10k/issues/52)

**Merged pull requests:**

- Fixup the webhook script [\#59](https://github.com/voxpupuli/puppet-r10k/pull/59) ([adamcrews](https://github.com/adamcrews))
- Fix quoting to pass linting [\#57](https://github.com/voxpupuli/puppet-r10k/pull/57) ([adamcrews](https://github.com/adamcrews))

## [v2.2.4](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.4) (2014-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.3...v2.2.4)

## [v2.2.3](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.3) (2014-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.2...v2.2.3)

## [v2.2.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.2) (2014-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.2.1...v2.2.2)

**Closed issues:**

- r10k::webhook Service resource pattern is too loose [\#54](https://github.com/voxpupuli/puppet-r10k/issues/54)
- install fails on PE 3.2.2 due to Puppet Module Tool Bug [\#43](https://github.com/voxpupuli/puppet-r10k/issues/43)

**Merged pull requests:**

- Removed symlinked r10k fixture/modules directory. [\#56](https://github.com/voxpupuli/puppet-r10k/pull/56) ([dreilly1982](https://github.com/dreilly1982))

## [v2.2.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.2.1) (2014-06-04)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.1.2...v2.2.1)

## [v2.1.2](https://github.com/voxpupuli/puppet-r10k/tree/v2.1.2) (2014-06-04)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.1.1...v2.1.2)

**Merged pull requests:**

- Stop quoting all configuration options so that prefix is not always on [\#51](https://github.com/voxpupuli/puppet-r10k/pull/51) ([ghoneycutt](https://github.com/ghoneycutt))

## [v2.1.1](https://github.com/voxpupuli/puppet-r10k/tree/v2.1.1) (2014-06-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.1.0...v2.1.1)

## [v2.1.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.1.0) (2014-06-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v2.0.0...v2.1.0)

**Closed issues:**

- rubygems-update makes r10k non idempotent on fresh install [\#37](https://github.com/voxpupuli/puppet-r10k/issues/37)
- r10k.yaml is rebuilt \(md5sum differs\) every Puppet run on ruby 1.8.7 [\#25](https://github.com/voxpupuli/puppet-r10k/issues/25)

**Merged pull requests:**

- Attempted fix for issue\#25 [\#44](https://github.com/voxpupuli/puppet-r10k/pull/44) ([tfhartmann](https://github.com/tfhartmann))

## [v2.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v2.0.0) (2014-06-03)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v1.0.2...v2.0.0)

**Closed issues:**

- does this module support Puppetfile? [\#40](https://github.com/voxpupuli/puppet-r10k/issues/40)
- $r10k::params::sources doesn't exist [\#19](https://github.com/voxpupuli/puppet-r10k/issues/19)

**Merged pull requests:**

- Support Puppet v3.6.0 [\#50](https://github.com/voxpupuli/puppet-r10k/pull/50) ([ghoneycutt](https://github.com/ghoneycutt))
- ensure webhook initscript is ordered correctly [\#48](https://github.com/voxpupuli/puppet-r10k/pull/48) ([dhgwilliam](https://github.com/dhgwilliam))
- Add class for postrun\_command [\#47](https://github.com/voxpupuli/puppet-r10k/pull/47) ([joshbeard](https://github.com/joshbeard))
- never update gem with rubygems-update [\#45](https://github.com/voxpupuli/puppet-r10k/pull/45) ([pall-valmundsson](https://github.com/pall-valmundsson))
- Add ability to specify a symlink for r10k.yaml [\#41](https://github.com/voxpupuli/puppet-r10k/pull/41) ([ghoneycutt](https://github.com/ghoneycutt))

## [v1.0.2](https://github.com/voxpupuli/puppet-r10k/tree/v1.0.2) (2014-02-19)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v1.0.1...v1.0.2)

## [v1.0.1](https://github.com/voxpupuli/puppet-r10k/tree/v1.0.1) (2014-02-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v1.0.0...v1.0.1)

**Merged pull requests:**

- don't ignore basedir parameter [\#35](https://github.com/voxpupuli/puppet-r10k/pull/35) ([welterde](https://github.com/welterde))
- update travis config, minor lint fixes [\#34](https://github.com/voxpupuli/puppet-r10k/pull/34) ([jlambert121](https://github.com/jlambert121))

## [v1.0.0](https://github.com/voxpupuli/puppet-r10k/tree/v1.0.0) (2014-02-09)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.9...v1.0.0)

**Closed issues:**

- r10k does not run sometimes [\#31](https://github.com/voxpupuli/puppet-r10k/issues/31)
- Exit status 42. Is that a git not found in path error? [\#12](https://github.com/voxpupuli/puppet-r10k/issues/12)

**Merged pull requests:**

- Update config.pp [\#32](https://github.com/voxpupuli/puppet-r10k/pull/32) ([zachfi](https://github.com/zachfi))
- add ability to include mcollective agent through main class [\#30](https://github.com/voxpupuli/puppet-r10k/pull/30) ([jlambert121](https://github.com/jlambert121))
- The gem is called 'bundler' [\#27](https://github.com/voxpupuli/puppet-r10k/pull/27) ([glarizza](https://github.com/glarizza))
- Bump to 0.0.10 [\#26](https://github.com/voxpupuli/puppet-r10k/pull/26) ([glarizza](https://github.com/glarizza))
- Ability to pass package\_name [\#24](https://github.com/voxpupuli/puppet-r10k/pull/24) ([tampakrap](https://github.com/tampakrap))
- new URL for the make module [\#23](https://github.com/voxpupuli/puppet-r10k/pull/23) ([tampakrap](https://github.com/tampakrap))
- require git only when installing via gem or bundler [\#22](https://github.com/voxpupuli/puppet-r10k/pull/22) ([tampakrap](https://github.com/tampakrap))
- Add tests for Gentoo [\#18](https://github.com/voxpupuli/puppet-r10k/pull/18) ([tampakrap](https://github.com/tampakrap))

## [v0.0.9](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.9) (2013-10-21)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.8...v0.0.9)

**Closed issues:**

- Ruby class is not singleton [\#17](https://github.com/voxpupuli/puppet-r10k/issues/17)
- Could not find declared class ::ruby at /etc/puppet/modules/r10k/manifests/install/gem.pp:10 [\#16](https://github.com/voxpupuli/puppet-r10k/issues/16)
- Deprecation warning [\#11](https://github.com/voxpupuli/puppet-r10k/issues/11)
- Require Git [\#10](https://github.com/voxpupuli/puppet-r10k/issues/10)

## [v0.0.8](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.8) (2013-10-15)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.7...v0.0.8)

**Closed issues:**

- Cannot install on PE3.0 [\#2](https://github.com/voxpupuli/puppet-r10k/issues/2)

**Merged pull requests:**

- refresh mco if we install the r10k app [\#15](https://github.com/voxpupuli/puppet-r10k/pull/15) ([nvalentine-puppetlabs](https://github.com/nvalentine-puppetlabs))
- Refactor install.pp and add Gentoo Portage support [\#14](https://github.com/voxpupuli/puppet-r10k/pull/14) ([tampakrap](https://github.com/tampakrap))
- Set prerun\_command with inifile instead of augeas [\#13](https://github.com/voxpupuli/puppet-r10k/pull/13) ([tampakrap](https://github.com/tampakrap))
- Update config.pp [\#9](https://github.com/voxpupuli/puppet-r10k/pull/9) ([bxm](https://github.com/bxm))
- Install using bundle option added for bleeding edge features not in gem ... [\#8](https://github.com/voxpupuli/puppet-r10k/pull/8) ([diginc](https://github.com/diginc))

## [v0.0.7](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.7) (2013-09-10)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.5...v0.0.7)

**Merged pull requests:**

- Move environemnt logic from config.pp to params.pp [\#7](https://github.com/voxpupuli/puppet-r10k/pull/7) ([reidmv](https://github.com/reidmv))
- Clean up install class [\#6](https://github.com/voxpupuli/puppet-r10k/pull/6) ([reidmv](https://github.com/reidmv))

## [v0.0.5](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.5) (2013-08-24)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.4...v0.0.5)

**Merged pull requests:**

- Manage puppet.conf's $modulepath [\#4](https://github.com/voxpupuli/puppet-r10k/pull/4) ([glarizza](https://github.com/glarizza))
- fixing comment typo [\#3](https://github.com/voxpupuli/puppet-r10k/pull/3) ([fiddyspence](https://github.com/fiddyspence))

## [v0.0.4](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.4) (2013-07-25)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.3...v0.0.4)

## [v0.0.3](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.3) (2013-07-25)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.2...v0.0.3)

**Merged pull requests:**

- Update R10k for PE [\#1](https://github.com/voxpupuli/puppet-r10k/pull/1) ([glarizza](https://github.com/glarizza))

## [v0.0.2](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.2) (2013-07-11)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/v0.0.1...v0.0.2)

## [v0.0.1](https://github.com/voxpupuli/puppet-r10k/tree/v0.0.1) (2013-06-12)

[Full Changelog](https://github.com/voxpupuli/puppet-r10k/compare/ef99b4e25b70fa0293e65b7e0994f4eec6f1815e...v0.0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
