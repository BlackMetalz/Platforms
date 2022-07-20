# Get all user available in minion
{% set all_users = salt['user.list_users']() %}

{% for user in pillar['users_remove'] %}

# Check user availble for remove sudo
{% if user in all_users %}

remove_sudo_{{ user }}:
  file.absent:
    - name: /etc/sudoers.d/{{ user }}

{% endif %}
{% endfor %}
