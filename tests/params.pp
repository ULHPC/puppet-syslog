# File::      <tt>params.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'syslog::params'

$names = ["ensure", "packagename", "logrotate_package", "servicename", "processname", "hasstatus", "hasrestart", "configfile", "configfile_mode", "configfile_owner", "configfile_group", "configdir", "configdir_mode", "configdir_owner", "configdir_group"]

notice("syslog::params::ensure = ${syslog::params::ensure}")
notice("syslog::params::packagename = ${syslog::params::packagename}")
notice("syslog::params::logrotate_package = ${syslog::params::logrotate_package}")
notice("syslog::params::servicename = ${syslog::params::servicename}")
notice("syslog::params::processname = ${syslog::params::processname}")
notice("syslog::params::hasstatus = ${syslog::params::hasstatus}")
notice("syslog::params::hasrestart = ${syslog::params::hasrestart}")
notice("syslog::params::configfile = ${syslog::params::configfile}")
notice("syslog::params::configfile_mode = ${syslog::params::configfile_mode}")
notice("syslog::params::configfile_owner = ${syslog::params::configfile_owner}")
notice("syslog::params::configfile_group = ${syslog::params::configfile_group}")
notice("syslog::params::configdir = ${syslog::params::configdir}")
notice("syslog::params::configdir_mode = ${syslog::params::configdir_mode}")
notice("syslog::params::configdir_owner = ${syslog::params::configdir_owner}")
notice("syslog::params::configdir_group = ${syslog::params::configdir_group}")

#each($names) |$v| {
#    $var = "syslog::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
