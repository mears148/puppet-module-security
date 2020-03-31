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
  auditd::rule { '-a always,exit -F arch=b32 -S fchown -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S fchown -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b32 -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b32 -S fchownat -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S fchownat -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b32 -S chmod -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b32 -S fchmod -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b32 -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b64 -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod': }
  auditd::rule { '-a always,exit -F arch=b32 -S creat -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b32 -S creat -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b64 -S creat -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b64 -S creat -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b32 -S open -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b32 -S open -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b64 -S open -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-a always,exit -F arch=b64 -S open -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access': }
  auditd::rule { '-w /var/run/faillock -p wa -k logins': }
  auditd::rule { '-w /var/log/lastlog -p wa -k logins': }
  auditd::rule { '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k privileged-mount': }
  auditd::rule { '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k privileged-mount': }
  auditd::rule { '-a always,exit -F path=/usr/bin/mount -F auid>=1000 -F auid!=4294967295 -k privileged-mount': }
  auditd::rule { '-a always,exit -F path=/usr/bin/umount -F auid>=1000 -F auid!=4294967295 -k privileged-mount': }
  auditd::rule { '-w /etc/passwd -p wa -k identity': }
  auditd::rule { '-a always,exit -F arch=b32 -S rename -F auid>=1000 -F auid!=4294967295 -k delete': }
  auditd::rule { '-a always,exit -F arch=b64 -S rename -F auid>=1000 -F auid!=4294967295 -k delete': }
  auditd::rule { '-a always,exit -F arch=b32 -S renameat -F auid>=1000 -F auid!=4294967295 -k delete': }
  auditd::rule { '-a always,exit -F arch=b64 -S renameat -F auid>=1000 -F auid!=4294967295 -k delete': }
  auditd::rule { '-a always,exit -F arch=b32 -S rmdir -F auid>=1000 -F auid!=4294967295 -k delete': }
  auditd::rule { '-a always,exit -F arch=b64 -S rmdir -F auid>=1000 -F auid!=4294967295 -k delete': }
  auditd::rule { '-w /etc/group -p wa -k identity': }
  auditd::rule { '-w /etc/gshadow -p wa -k identity': }
  auditd::rule { '-w /etc/shadow -p wa -k identity': }
  auditd::rule { '-w /etc/security/opasswd -p wa -k identity': }

}
