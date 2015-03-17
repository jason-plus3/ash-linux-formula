# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38588
# Finding ID:	V-38588
# Version:	RHEL-06-000070
# Finding Level:	Medium
#
#     The system must not permit interactive boot. Using interactive boot, 
#     the console user could disable auditing, firewalls, or other 
#     services, weakening system security.
#
#  CCI: CCI-000213
#  NIST SP 800-53 :: AC-3
#  NIST SP 800-53A :: AC-3.1
#  NIST SP 800-53 Revision 4 :: AC-3
#
############################################################

script_V38588-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38588.sh
    - cwd: '/root'

# Conditional replace or append
{%- if salt['file.search']('/etc/sysconfig/init', '^PROMPT') %}
file_V38588-repl:
  file.replace:
    - name: '/etc/sysconfig/init'
    - pattern: '^PROMPT.*$'
    - repl: 'PROMPT=no' 
{%- else %}
file_V38588-append:
  file.append:
    - name: '/etc/sysconfig/init'
    - text:
      - ' '
      - '# Disable interactive-booting of system (per STIG V-38588)'
      - 'PROMPT=no' 
{%- endif %}
