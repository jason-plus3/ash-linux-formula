# This Salt test/lockdown implements a SCAP item that has already been
# merged into the DISA-published STIGS
#
# Rule ID:
# - 
#
# Security identifiers:
# - CCE-27457-1
#
# Rule Summary: 
#
# Rule Text:
#
#################################################################

{%- set helperLoc = 'ash-linux/el6/SCAPonly/low/files' %}
{%- set scapId = 'CCE-27457-1' %}
{%- set stigId = 'V-38684' %}

script_{{ scapId }}-describe:
  cmd.run:
    - name: 'printf "
************************************************\n
* NOTE: {{ scapId }} already covered by handler *\n
*       for STIG-ID {{ stigId }}                    *\n
************************************************\n"'
