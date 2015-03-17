# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38631
# Finding ID:	V-38631
# Version:	RHEL-06-000148
# Finding Level:	Medium
#
#     The operating system must employ automated mechanisms to facilitate 
#     the monitoring and control of remote access methods. Ensuring the 
#     "auditd" service is active ensures audit records generated by the 
#     kernel can be written to disk, or that appropriate actions will be 
#     taken if other obstacles exist.
#
#  CCI: CCI-000067
#  NIST SP 800-53 :: AC-17 (1)
#  NIST SP 800-53A :: AC-17 (1).1
#  NIST SP 800-53 Revision 4 :: AC-17 (1)
#
############################################################

script_V38631-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38631.sh
    - cwd: '/root'

{%- if not salt['pkg.version']('auditd') %}
pkg_V38631-audit:
  pkg.installed:
    - name: 'audit'
{%- endif %}

svc_V38631-auditEnabled:
  service.enabled:
    - name: 'auditd'

svc_V38631-auditRunning:
  service.running:
    - name: 'auditd'

