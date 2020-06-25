# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include security
class security {

  class { 'motd':
    template       => 'security/issue.epp',
    issue_template => 'security/issue.epp',
  }

  case $facts['os']['name'] {
    'CentOS': {
      package { 'epel-release':
        ensure => 'installed',
      }

      package { 'clamav':
        ensure  => 'installed',
        require => Package['epel-release'],
      }
    }
    'Amazon': {
      exec { 'amazon-linux-extras install epel && touch /root/epel_created':
      path    => '/bin',
      creates => '/root/epel_created',
      }

      package { 'clamav':
        ensure  => 'installed',
        require => Exec['amazon-linux-extras install epel && touch /root/epel_created'],
      }
    }
    default: {
      notify { "${facts['os']['name']} is not currently supported": }
    }
  }


  user { 'brick':
    ensure   => 'present',
    password => '$6$05832d743a78fa07$kwXcayQ53MCeUiu9Jfkg1w6jMEocWx1nBgLpCfcWCWZTXn9HkU6Tx9E29QJbH2watmMXtRRD7TrkAxyFcOE5f1'
  }

  include security::auditd
  include security::ssh
  include security::sudo

}
