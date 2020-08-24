# Class: security::sudo
#
#
class security::sudo (
  Array $admin_all_only,
) {

  include sudo

  sudo::conf { 'ec2-user':
    content => 'ec2-user ALL=(ALL) NOPASSWD: /usr/sbin/realm join *, /usr/sbin/useradd *, /opt/puppetlabs/bin/puppet agent -t, /usr/bin/hostnamectl set-hostname *',
  }

  sudo::conf { 'ubuntu':
    content => 'ubuntu ALL=(ALL) NOPASSWD: /usr/sbin/realm join *, /usr/sbin/useradd *, /usr/bin/puppet agent -t, /usr/bin/hostnamectl set-hostname *',
  }

  sudo::conf { 'brick':
    content => 'brick ALL=(ALL) NOPASSWD: ALL',
  }

  sudo::conf { 'local_adm':
    content => '%admin ALL=(ALL) ALL',
  }

  sudo::conf { 'scanner':
    content => 'scanner ALL=(ALL) NOPASSWD: ALL'
  }

  if $facts['ec2_metadata']['instance-id'] in $admin_all_only {
    sudo::conf { 'JAWS_Server_Admin_ALL':
      content => '%jaws_server_admin_all@jaws-sdbx.com ALL=(ALL) NOPASSWD: ALL',
    }
  }
  else {
    sudo::conf { 'JAWS_Server_Admin_Common':
      content => '%jaws_server_admin_common@jaws-sdbx.com ALL=(ALL) NOPASSWD: ALL',
    }
  }

}
