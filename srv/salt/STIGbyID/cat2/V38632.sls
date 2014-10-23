# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38632
# Finding ID:	V-38632
# Version:	RHEL-06-000154
# Finding Level:	Medium
#
#     The operating system must produce audit records containing sufficient 
#     information to establish what type of events occurred. Ensuring the 
#     "auditd" service is active ensures audit records generated by the 
#     kernel can be written to disk, or that appropriate actions will be 
#     taken if other obstacles exist.
#
############################################################

script_V38632-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38632.sh

{% if not salt['pkg.version']('auditd') %}
pkg_V38632-audit:
  pkg.installed:
  - name: 'audit'
{% endif %}

svc_V38632-auditEnabled:
  service.enabled:
  - name: 'auditd'

svc_V38632-auditRunning:
  service.running:
  - name: 'auditd'
