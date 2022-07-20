# Require xinetd already installed. This is state for upgrade check mk agent. Not install fresh
# You have to put check-mk-agent into salt://checkmk_upgrade/files/
# Copy file to agent
{% if grains['os'] == 'Ubuntu' %}
/tmp/check-mk-agent.deb:
  file.managed:
    - source: salt://checkmk_upgrade/files/check-mk-agent_1.5.0p19-1_all.deb
    - user: root
    - group: root

install_checkmk:
  cmd.run:
    - name: echo N | dpkg -i /tmp/check-mk-agent.deb

{% elif grains['os'] == 'CentOS' %}

/tmp/check-mk-agent.rpm:
  file.managed:
    - source: salt://checkmk_upgrade/files/check-mk-agent-1.5.0p19-1.noarch.rpm
    - user: root
    - group: root

install_checkmk:
  cmd.run:
    - name: rpm -Uvh /tmp/check-mk-agent.rpm
    - unless: # Run command yum install if only package isn't installed
      - rpm -q check-mk-agent-1.5.0p19-1.noarch

/usr/lib/check_mk_agent/plugins/mk_logins:
  file.managed:
    - source: salt://checkmk_upgrade/files/mk_logins
    - user: root
    - group: root
    - mode: 770

{% endif %}

/etc/xinetd.d/check_mk:
  file.managed: # Copy configuration file
    - source: salt://checkmk_upgrade/files/check_mk
    - user: root
    - group: root
    - mode: 644

xinetd: #Make sure service is start and restart service
  service.running:
    - enable: True
    - reload: True
