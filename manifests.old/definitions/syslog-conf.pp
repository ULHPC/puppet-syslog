# File::      <tt>syslog-conf.pp</tt>
# Author::    Sebastien Varrette (<Sebastien.Varrette@uni.lu>)
# Copyright:: Copyright (c) 2011 Sebastien Varrette (www[http://varrette.gforge.uni.lu])
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Defines: syslog::conf
#
# Add a specific configuration file for the syslog server
#
# == Pre-requisites
#
# * The class 'syslog' should have been instanciated
#
# == Parameters:
#
# [*ensure*]
#   default to 'present'
#
#
# [*content*]
#  Specify the contents of the configuration as a string. Newlines, tabs,
#  and spaces can be specified using the escaped syntax (e.g., \n for a newline)
#
# [*source*]
#  Copy a file as the content of the syslog configuration directory
#  (/etc/rsyslog.d/ typically).
#  Uses checksum to determine when a file should be copied. Valid values are
#  either fully qualified paths to files, or URIs. Currently supported URI types
#  are puppet and file.
#  If content was not specified, you are expected to use the source
#
# == Requires:
#   $content or $source must be set
# n/a
#
# == Sample Usage:
#
#    syslog::conf{ 'dhcpd':
#         source => "puppet:///modules/dhcp/rsyslog.conf"
#    }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# [Remember: No empty lines between comments and class definition]
#
define syslog::conf (
    $ensure  = 'present',
    $content = '',
    $source  = ''
)
{
    # Load the variables used in this module. Check the infiniband-params.pp file
    require syslog::params

    # $name is provided by define invocation
    # guid of this entry
    $configname = $name

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("syslog::conf 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    # if content is passed, use that, else if source is passed use that
    case $content {
        '': {
            case $source {
                '': {
                    crit('No content nor source have been  specified')
                }
                default: { $real_source = $source }
            }
        }
        default: { $real_content = $content }
    }

    file{ "${syslog::params::configdir}/${configname}.conf":
        owner   => "${syslog::params::configfile_owner}",
        group   => "${syslog::params::configfile_group}",
        mode    => "${syslog::params::configfile_mode}",
        ensure  => "${ensure}",
        content => $real_content,
        source  => $real_source,
        require => [
                    Package['syslog'],
                    File["${syslog::params::configdir}"]
                    ],
        notify  => Service['syslog'],        
    }

}




