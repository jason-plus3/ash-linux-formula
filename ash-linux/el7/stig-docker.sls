include:
    - .stig

exclude:
#Firewall and network always disabled in docker
    - id: cmd_RHEL-07-040250-firewall
    - id: save_RHEL-07-040250-firewall
    - id: sysctl_RHEL-07-040350-net.ipv4.conf.all.accept_source_route
    - id: sysctl_RHEL-07-040351-net.ipv4.conf.default.accept_source_route
    - id: sysctl_RHEL-07-040380-net.ipv4.icmp_echo_ignore_broadcasts
    - id: sysctl_RHEL-07-040410-net.ipv4.conf.all.accept_redirects
    - id: sysctl_RHEL-07-040410-net.ipv4.conf.default.accept_redirects
    - id: sysctl_RHEL-07-040420-net.ipv4.conf.default.send_redirects
    - id: sysctl_RHEL-07-040421-net.ipv4.conf.all.send_redirects
    - id: sysctl_RHEL-07-040730-net.ipv4.ip_forward
    - id: sysctl_RHEL-07-040860-net.ipv6.conf.all.accept_source_route
    - id: firewalld_safeties

# SSHD
{%- if not(salt.service is defined and salt.service.available("sshd")) %}
    - id: service_RHEL-07-010270-sshd
    - id: service_RHEL-07-010440-sshd
    - id: service_RHEL-07-040540-sshd
    - id: service_sshd
    - id: service_RHEL-07-010441-sshd
    - id: service_RHEL-07-010442-sshd
    - id: service_RHEL-07-040110-/etc/ssh/sshd_config
    - id: service_RHEL-07-040170-/etc/ssh/sshd_config
    - id: service_RHEL-07-040190-/etc/ssh/sshd_config
    - id: service_RHEL-07-040191-/etc/ssh/sshd_config
    - id: running_RHEL-07-040261-sshd
    - id: service_RHEL-07-040620-/etc/ssh/sshd_config
    - id: service_RHEL-07-040660-/etc/ssh/sshd_config
    - id: service_RHEL-07-040670-/etc/ssh/sshd_config
    - id: service_RHEL-07-040680-/etc/ssh/sshd_config
    - id: service_RHEL-07-040690-/etc/ssh/sshd_config
    - id: service_RHEL-07-040700-/etc/ssh/sshd_config
    - id: file_RHEL-07-040640-
    - id: file_RHEL-07-040650-
{%-endif %}

# NTP
{%- if not(salt.service is defined and salt.service.available("ntpd")) %}
    - id: file_RHEL-07-040210-/etc/ntp.conf
    - id: service_RHEL-07-040210-/etc/ntp.conf
{%- endif %}

# Cron (jobs to run AIDE to detect baseline changes)
{%- if not(salt.service is defined and salt.service.available("crond")) %}
    - id: cron_RHEL-07-020130-file
    - id: cron_RHEL-07-020130-service
    - id: cron_RHEL-07-020140-file
    - id: cron_RHEL-07-020140-service
{%- endif %}
#Audit 
{%- if not(salt.service is defined and salt.service.available("auditd")) %}
    - id: start_RHEL-07-030010-auditd.service
    - id: enable_RHEL-07-030010-auditd.service
    - id: setval_RHEL-07-030090
    - id: touch_RHEL-07-030310-/etc/audit/rules.d/setuid_setgid.rules
{%- if not(salt.file.file_exists('/usr/lib/sendmail')) %}
    - sls: ash-linux.el7.STIGByID.cat2.RHEL-07-030351
{%- endif %}
{%- endif %}
    

# RSyslog
{%- if not(salt.service is defined and salt.service.available("syslog")) %}
    - id: disable_RHEL-07-030780-imtcp
    - id: file_RHEL-07-040020-authlog
    - id: file_RHEL-07-040020-daemonlog
{%- endif %}


