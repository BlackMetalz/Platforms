# Get all user available
{% set all_users = salt['user.list_users']() %}

# Get user from pillar
{% for user in pillar['users_remove'] %}

# Check user available for remove 
{% if user in all_users %}
  {{ user }}:
    user.absent

  /home/{{ user }}/.ssh/authorized_keys:
    file:
      - comment
      - regex: ^ssh-rsa
      - require:
        - user: {{ user }}
{% endif %}

{% endfor %}
