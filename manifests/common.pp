# File::      <tt>common.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: syslog::common
#
# Base class to be inherited by the other syslog classes, containing the common code.
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]

class syslog::common {

    # Load the variables used in this module. Check the params.pp file
    require syslog::params

    package { 'syslog':
        ensure => $syslog::ensure,
        name   => $syslog::params::packagename,
    }


    if $syslog::ensure == 'present' {

    file { $syslog::params::configdir:
        ensure  => 'directory',   # TODO: deal with ensure==absent
        owner   => $syslog::params::configdir_owner,
        group   => $syslog::params::configdir_group,
        mode    => $syslog::params::configdir_mode,
        require => Package['syslog'],
    }

    file { $syslog::params::configfile:
        ensure  => $syslog::ensure,
        owner   => $syslog::params::configfile_owner,
        group   => $syslog::params::configfile_group,
        mode    => $syslog::params::configfile_mode,
        source  => "puppet:///modules/syslog/${::operatingsystem}/${::lsbmajdistrelease}/rsyslog.conf",
        require => [
                    Package['syslog'],
                    File[$syslog::params::configdir]
                    ],
        notify  => Service['syslog'],
    }

    service { 'syslog':
        ensure     => running,
        name       => $syslog::params::servicename,
        enable     => true,
        hasrestart => $syslog::params::hasrestart,
        pattern    => $syslog::params::processname,
        hasstatus  => $syslog::params::hasstatus,
        require    => Package['syslog'],
        subscribe  => File[$syslog::params::configfile],
    }
}
else
    {
        # Here $syslog::ensure is 'absent'

    }

}

