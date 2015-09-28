# File::      <tt>syslog-params.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPL v3
#
# ------------------------------------------------------------------------------
# = Class: syslog::params
#
# In this class are defined as variables values that are used in other
# syslog classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class syslog::params {

    ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
    # (Here are set the defaults, provide your custom variables externally)
    # (The default used is in the line with '')
    ###########################################

    # ensure the presence (or absence) of syslog
    $ensure = $syslog_ensure ? {
        ''      => 'present',
        default => "${syslog_ensure}"
    }


    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    $packagename = $::operatingsystem ? {
        default => 'rsyslog',
    }
    $logrotate_package = $::operatingsystem ? {
        default => 'logrotate',
    }

    $servicename = $::operatingsystem ? {
        default => 'rsyslog'
    }

    # used for pattern in a service ressource
    $processname = $::operatingsystem ? {
        default => 'rsyslog'
    }

    $hasstatus = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/        => false,
        /(?i-mx:centos|fedora|redhat)/ => true,
        default => true,
    }
    $hasrestart = $::operatingsystem ? {
        default => true,
    }

    # Configuration file 
    $configfile = $::operatingsystem ? {
        default => '/etc/rsyslog.conf',
    }
    $configfile_mode = $::operatingsystem ? {
        default => '0644',
    }
    $configfile_owner = $::operatingsystem ? {
        default => 'root',
    }
    $configfile_group = $::operatingsystem ? {
        default => 'root',
    }

    $configdir = $::operatingsystem ? {
        default => "/etc/rsyslog.d",
    }
    $configdir_mode = $::operatingsystem ? {
        default => '0755',
    }
    $configdir_owner = $::operatingsystem ? {
        default => 'root',
    }
    $configdir_group = $::operatingsystem ? {
        default => 'root',
    }

    # $pkgmanager = $::operatingsystem ? {
    #     /(?i-mx:ubuntu|debian)/	       => [ '/usr/bin/apt-get' ],
    #     /(?i-mx:centos|fedora|redhat)/ => [ '/bin/rpm', '/usr/bin/up2date', '/usr/bin/yum' ],
    #     default => []
    # }


}

