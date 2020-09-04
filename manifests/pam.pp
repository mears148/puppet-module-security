# Class: security::pam
#
#
class security::pam (
  Array $pwquality_rules,
){

  case $facts['os']['name'] {
    /^(Amazon|CentOS|RedHat)$/: {
      file { '/etc/security/pwquality.conf':
        ensure  => 'present',
        content => epp('security/pwquality.conf.epp'),
      }
    }
    default: {}
  }

}
