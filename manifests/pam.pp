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
      class { 'pam':
        pam_auth_lines              => [
          'auth        required      pam_env.so',
          'auth        required      pam_faillock.so preauth silent audit deny=3 even_deny_root fail_interval=900 unlock_time=900',
          'auth        sufficient    pam_unix.so try_first_pass',
          'auth        sufficient    pam_sss.so use_first_pass',
          'auth        [default=die] pam_faillock.so authfail audit deny=3 even_deny_root fail_interval=900 unlock_time=900',
          'auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success',
          'auth        required      pam_deny.so',
        ],
        pam_account_lines           => [
          'account     required      pam_access.so listsep=,',
          'account     required      pam_faillock.so',
          'account     required      pam_unix.so',
          'account     sufficient    pam_localuser.so',
          'account     sufficient    pam_succeed_if.so uid < 1000 quiet',
          'account     [default=bad success=ok user_unknown=ignore] pam_sss.so',
          'account     required      pam_permit.so',
        ],
        pam_password_lines          => [
          # RHEL-07-010119
          'password    required      pam_pwquality.so retry=3',
          'password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=',
          # RHEL-07-010270
          'password    requisite     pam_pwhistory.so use_authtok remember=5 retry=3',
          # RHEL-07-010200
          'password    sufficient    pam_unix.so sha512 shadow try_first_pass use_authtok',
          'password    sufficient    pam_sss.so use_authtok',
          'password    required      pam_deny.so',
        ],
        pam_session_lines           => [
          'session     optional      pam_keyinit.so revoke',
          'session     required      pam_limits.so',
          '-session     optional     pam_systemd.so',
          'session     optional      pam_oddjob_mkhomedir.so umask=0077',
          'session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid',
          'session     required      pam_unix.so',
        ],
        # RHEL-07-010320
        # BE VERY CAREFULL WHEN RE-ORDERING THESE MODULES!
        pam_password_auth_lines     => [
          'auth        required      pam_env.so',
          'auth        required      pam_faillock.so preauth silent audit deny=3 even_deny_root fail_interval=900 unlock_time=900',
          'auth        sufficient    pam_unix.so try_first_pass',
          'auth        sufficient    pam_sss.so use_first_pass',
          'auth        [default=die] pam_faillock.so authfail audit deny=3 even_deny_root fail_interval=900 unlock_time=900',
          'auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success',
          'auth        required      pam_deny.so',
        ],
        pam_password_account_lines  => [
          'account     required      pam_access.so listsep=,',
          'account     required      pam_faillock.so',
          'account     required      pam_unix.so',
          'account     sufficient    pam_localuser.so',
          'account     sufficient    pam_succeed_if.so uid < 1000 quiet',
          'account     [default=bad success=ok user_unknown=ignore] pam_sss.so',
          'account     required      pam_permit.so',
        ],
        pam_password_password_lines => [
          'password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=',
          # RHEL-07-010270
          'password    requisite     pam_pwhistory.so use_authtok remember=5 retry=3',
          # RHEL-07-010200
          'password    sufficient    pam_unix.so sha512 shadow try_first_pass use_authtok',
          'password    sufficient    pam_sss.so use_authtok',
          'password    required      pam_deny.so',
        ],
        pam_password_session_lines  => [
          'session     optional      pam_keyinit.so revoke',
          'session     required      pam_limits.so',
          '-session     optional     pam_systemd.so',
          'session     optional      pam_oddjob_mkhomedir.so umask=0077',
          'session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid',
          'session     required      pam_unix.so',
        ],
      }
    }
    /^(Debian|Ubuntu)$/: {
      package { 'libpam-pwquality':
        ensure => 'present',
      }

      file { '/etc/security/pwquality.conf':
        ensure  => 'present',
        content => epp('security/pwquality.conf.epp'),
        require => Package['libpam-pwquality'],
      }

      class { 'pam':
        pam_auth_lines     => [
          'auth  [success=1 default=ignore]  pam_unix.so nullok_secure',
          'auth  requisite     pam_deny.so',
          'auth  required      pam_permit.so',
          'auth  optional      pam_cap.so',
        ],
        pam_account_lines  => [
          'account [success=1 new_authtok_reqd=done default=ignore]  pam_unix.so',
          'account requisite     pam_deny.so',
          'account required      pam_permit.so',
        ],
        pam_password_lines => [
          # UBTU-18-010108
          # UBTU-18-010110
          'password  [success=1 default=ignore]  pam_unix.so obscure sha512 remember=5',
          # UBTU-18-010116
          'password  requisite     pam_pwquality.so retry=3',
          'password  requisite     pam_deny.so',
          'password  required      pam_permit.so',
        ],
        pam_session_lines  => [
          'session [default=1]   pam_permit.so',
          'session requisite     pam_deny.so',
          'session required      pam_permit.so',
          'session optional      pam_umask.so',
          'session required      pam_unix.so',
          'session optional      pam_systemd.so',
        ],
      }
    }
    default: {}
  }

}
