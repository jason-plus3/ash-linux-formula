# Summary:
#
#    This state acts as a safety-valve for hardening-actions that 
#    result in the firewalld zone being changed from 'public' to 
#    something more-restrictive (typically 'drop'). This state 
#    ensures that the firewalld service allows establishment of 
#    SSH-based connections and continuence of existing connections 
#    after a firewalld zone-change action.
#
#################################################################
{%- set helperLoc = 'ash-linux/el7/Miscellaneous/files' %}
{%- set statename = 'firewalld_safeties'%}

{{ statename }}:
  cmd.script:
    - name: '{{ statename }}.sh'
    - source: 'salt://{{ helperLoc }}/{{ statename }}.sh'
    - cwd: '/root'
    - stateful: true
