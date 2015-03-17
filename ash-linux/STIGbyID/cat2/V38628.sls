# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38628
# Finding ID:	V-38628
# Version:	RHEL-06-000145
# Finding Level:	Medium
#
#     The operating system must produce audit records containing sufficient 
#     information to establish the identity of any user/subject associated 
#     with the event. Ensuring the "auditd" service is active ensures audit 
#     records generated by the kernel can be written to disk, or that 
#     appropriate actions will be taken if other obstacles exist.
#
#  CCI: CCI-001487
#  NIST SP 800-53 :: AU-3
#  NIST SP 800-53A :: AU-3.1
#  NIST SP 800-53 Revision 4 :: AU-3
#
############################################################

script_V38628-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38628.sh
    - cwd: '/root'

{%- if not salt['pkg.version']('auditd') %}
pkg_V38628-audit:
  pkg.installed:
    - name: 'audit'
{%- endif %}

svc_V38628-auditEnabled:
  service.enabled:
    - name: 'auditd'

svc_V38628-auditRunning:
  service.running:
    - name: 'auditd'
