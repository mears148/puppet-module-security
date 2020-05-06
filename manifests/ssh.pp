# Class: security::ssh
#
#
class security::ssh {

  class { 'ssh':
    sshd_config_hostkey               => [ '/etc/ssh/ssh_host_rsa_key', '/etc/ssh/ssh_host_ecdsa_key', '/etc/ssh/ssh_host_ed25519_key' ],
    sshd_config_syslog_facility       => 'AUTHPRIV',
    sshd_config_login_grace_time      => '2m',
    sshd_config_authkey_location      => '.ssh/authorized_keys',
    sshd_password_authentication      => 'yes',
    sshd_config_challenge_resp_auth   => 'no',
    sshd_gssapicleanupcredentials     => 'no',
    sshd_authorized_keys_command      => '/opt/aws/bin/eic_run_authorized_keys %u %f',
    sshd_authorized_keys_command_user => 'ec2-instance-connect',
  }

}
