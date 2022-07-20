{% for user in pillar['users_add'] %}
/etc/sudoers.d/{{ user }}:
  file.append:
    - text:
      - {{ user }} ALL=(ALL)       NOPASSWD:ALL

chmod 440 /etc/sudoers.d/{{ user }}:
  cmd.run
{% endfor %}
