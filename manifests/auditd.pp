# Class: security::auditd
#
#
class security::auditd {

  if $facts['os']['name'] == 'Amazon' and $facts['os']['release']['major'] == '2' {
    class { 'auditd':
      rules_file      => '/etc/audit/rules.d/puppet.rules',
      service_restart => '/usr/libexec/initscripts/legacy-actions/auditd/restart',
      service_stop    => '/usr/libexec/initscripts/legacy-actions/auditd/stop',
      log_group       => 'cwagent',
    }
  }
  else {
    include auditd
  }

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
  auditd::rule { '-w /etc/passwd -p wa -k passwd_changes': }
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
  auditd::rule { '-w /sbin/shutdown': }
  auditd::rule { '-w /sbin/reboot': }
  auditd::rule { '-a entry,always -S execve -F uid=0': }
  auditd::rule { '-a always,exit -F arch=b64 -S mount -S umount2 -F dir=/media -k media': }
  auditd::rule { '-w /bin/systemctl': }
  auditd::rule { '-w /usr/bin/print': }

}
