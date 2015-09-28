# File::      <tt>syslog.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
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
#     import syslog
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
class syslog( $ensure = $syslog::params::ensure ) inherits syslog::params
{
    info ("Configuring syslog (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("syslog 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include syslog::debian }
        redhat, fedora, centos: { include syslog::redhat }
        default: {
            fail("Module $module_name is not supported on $operatingsystem")
        }
    }
}

# ------------------------------------------------------------------------------
# = Class: syslog::common
#
# Base class to be inherited by the other syslog classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class syslog::common {

    # Load the variables used in this module. Check the syslog-params.pp file
    require syslog::params

    package { 'syslog':
        name    => "${syslog::params::packagename}",
        ensure  => "${syslog::ensure}",
    }

    file { "${syslog::params::configdir}":
        owner   => "${syslog::params::configdir_owner}",
        group   => "${syslog::params::configdir_group}",
        mode    => "${syslog::params::configdir_mode}",
        ensure  => 'directory',   # TODO: deal with ensure==absent
        require => Package['syslog'],
    }

    file { "${syslog::params::configfile}":
        owner   => "${syslog::params::configfile_owner}",
        group   => "${syslog::params::configfile_group}",
        mode    => "${syslog::params::configfile_mode}",
        ensure  => "${syslog::ensure}",
        source  => "puppet:///modules/syslog/rsyslog.conf",
        require => [
                    Package['syslog'],
                    File["${syslog::params::configdir}"]
                    ],
        notify  => Service['syslog'],
    }

    service { 'syslog':
        name       => "${syslog::params::servicename}",
        enable     => true,
        ensure     => running,
        hasrestart => "${syslog::params::hasrestart}",
        pattern    => "${syslog::params::processname}",
        hasstatus  => "${syslog::params::hasstatus}",
        require    => Package['syslog'],
        subscribe  => File["${syslog::params::configfile}"],
    }
}


# ------------------------------------------------------------------------------
# = Class: syslog::debian
#
# Specialization class for Debian systems
class syslog::debian inherits syslog::common { }

# ------------------------------------------------------------------------------
# = Class: syslog::redhat
#
# Specialization class for Redhat systems
class syslog::redhat inherits syslog::common { }



