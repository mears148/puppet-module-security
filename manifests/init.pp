# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include security
class security {

  class { 'ntp':
    servers => ['tick.usno.navy.mil','tock.usno.navy.mil ','ntp2.usno.navy.mil'],
  }

  exec { 'amazon-linux-extras install epel && touch /root/epel_created':
    path    => '/bin',
    creates => '/root/epel_created',
  }

  package { 'clamav':
    ensure  => 'installed',
    require => Exec['amazon-linux-extras install epel && touch /root/epel_created'],
  }

  include auditd

  auditd::rule { '-a always,exit -F arch=b32 -S chown -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=4294967295 -k perm_mod': }

}
