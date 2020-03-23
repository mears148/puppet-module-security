# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include security
class security {

  class { 'ntp':
        servers => ['tick.usno.navy.mil','tock.usno.navy.mil ','ntp2.usno.navy.mil']
  }

  package { 'epel':
    ensure => 'present'
  }

  package { 'clamav':
    ensure => 'present'
  }

}