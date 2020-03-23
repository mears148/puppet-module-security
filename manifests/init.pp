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
    creates => '/etc/yum.repos.d/epel.repo',
  }

  package { 'clamav':
    ensure  => 'installed',
    require => Exec['amazon-linux-extras install epel'],
  }

}
