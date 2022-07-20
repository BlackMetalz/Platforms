{% set service = salt['grains.filter_by']({
    'Debian': {'srv': 'ssh'},
    'RedHat': {'srv': 'sshd'},
}, default='Debian') %}
{% for user in pillar['users_add'] %}
{{ user }}:
  user:
    - present
    - fullname: {{ user }}
    - home: /home/{{ user }}
    - shell: /bin/bash
  ssh_auth:
    - present
    - user: {{ user }} 
    - source: salt://users/keys/{{ user }}_id_rsa.pub
    - require:
      - user: {{ user }}
  cmd.run:
      - name: sed -r -i.bak "s/(^AllowUsers.*$)/\1 {{ user }}@IP_OF_SERVER_IF_USE_THIS {{ user }}@SECOND_IP_ALLOWING_SSH/" /etc/ssh/sshd_config && service {{ service.srv }} restart
      - onlyif: grep "AllowUsers" /etc/ssh/sshd_config
{% endfor %} 
