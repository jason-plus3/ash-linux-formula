# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38625
# Finding ID:	V-38625
# Version:	RHEL-06-000252
# Finding Level:	Medium
#
#     If the system is using LDAP for authentication or account 
#     information, the system must use a TLS connection using FIPS 140-2 
#     approved cryptographic algorithms. The ssl directive specifies 
#     whether to use ssl or not. If not specified it will default to "no". 
#     It should be set to "start_tls" rather than doing LDAP over SSL.
#
############################################################


script_V38625-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38625.sh

{% if salt['pkg.version']('pam_ldap') and salt['file.search']('/etc/pam_ldap.conf', '^ssl') %}
file_V38625-repl:
  file.replace:
  - name: '/etc/pam_ldap.conf'
  - pattern: '^ssl.*$'
  - repl: 'ssl start_tls'
{% elif salt['pkg.version']('pam_ldap') and not salt['file.search']('/etc/pam_ldap.conf', '^ssl') %}
file_V38625-append:
  file.append:
  - name: '/etc/pam_ldap.conf'
  - text:
    - ' '
    - '# LDAP auth-queries must use TLS (per STIG V-38625)'
    - 'ssl start_tls'
{% elif not salt['pkg.version']('pam_ldap') %}
cmd_V38625-notice:
  cmd.run:
  - name: 'echo "LDAP PAM modules not installed"'
{% endif %}
