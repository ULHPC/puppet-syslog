# File::      <tt>init.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: syslog
#
# Configure and manage a syslog server
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of syslog
#
# == Actions:
#
# Install and configure syslog
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     include 'syslog'
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'syslog':
#             ensure => 'present'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class syslog(
    $ensure = $syslog::params::ensure
)
inherits syslog::params
{
    info ("Configuring syslog (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("syslog 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        'debian', 'ubuntu':         { include ::syslog::common::debian }
        'redhat', 'fedora', 'centos': { include ::syslog::common::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}



