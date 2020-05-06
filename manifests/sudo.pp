# Class: security::sudo
#
#
class security::sudo {

  include sudo

  sudo::conf { 'ec2-user':
    content => 'ec2-user ALL=(ALL) NOPASSWD: /usr/sbin/realm join *',
  }

  sudo::conf { 'brick':
    content => 'ec2-user ALL=(ALL) NOPASSWD: ALL',
  }

  sudo::conf { 'JAWS_Server_Admin_ALL':
    content => '%jaws_server_admin_all@jaws-sdbx.com ALL=(ALL) NOPASSWD: ALL',
  }

}
