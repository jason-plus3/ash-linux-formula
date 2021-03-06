# Finding ID:	RHEL-07-030350
# Version:	RHEL-07-030350_rule
# SRG ID:	SRG-OS-000343-GPOS-00134
# Finding Level:	medium
# 
# Rule Summary:
#	The operating system must immediately notify the System
#	Administrator (SA) and Information System Security Officer
#	ISSO (at a minimum) when allocated audit record storage
#	volume reaches 75% of the repository maximum audit record
#	storage capacity.
#
# CCI-001855 
#    NIST SP 800-53 Revision 4 :: AU-5 (1) 
#
#################################################################
{%- set stig_id = 'RHEL-07-030350' %}
{%- set helperLoc = 'ash-linux/el7/STIGbyID/cat2/files' %}
{%- set audCfg = '/etc/audit/auditd.conf' %}
{%- set parmName = 'space_left'%}
{%- set fullPct = 0.75 %}

{%- if salt.file.file_exists('/var/log/audit') %}
  {%- set auditVol = '/var/log/audit' %}
{% else %}
  {%- set auditVol = '/var/log' %}
{% endif %}

{%- set usageDict = salt.status.diskusage(auditVol) %}
{%- set audSzMB = usageDict[auditVol]['total'] // 1024 // 1024 %}
{%- set alrtFull = (( audSzMB * 0.75 )|int)|string %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

{%- if salt.file.file_exists(audCfg) %}
# calculate values only after we confirm that we need to configure the audit volume

file_{{ stig_id }}-{{ parmName }}:
  file.replace:
    - name: '{{ audCfg }}'
    - pattern: '^\s{{ parmName }}.*$'
    - repl: '{{ parmName }} = {{ alrtFull }}'
    - append_if_not_found: True
{%- else %}
file_{{ stig_id }}-{{ parmName }}:
  file.append:
    - name: '{{ audCfg }}'
    - text: '{{ parmName }} = {{ alrtFull }}'
    - makedirs: True
{%- endif %}
