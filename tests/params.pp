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

$names = ["ensure", "protocol", "port", "packagename"]

notice("syslog::params::ensure = ${syslog::params::ensure}")
notice("syslog::params::protocol = ${syslog::params::protocol}")
notice("syslog::params::port = ${syslog::params::port}")
notice("syslog::params::packagename = ${syslog::params::packagename}")

#each($names) |$v| {
#    $var = "syslog::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
