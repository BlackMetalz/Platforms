xinetd:
  pkg.latest:
    - pkgs:
      - xinetd
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: xinetd

{% if grains['os'] == 'Ubuntu' %}
/tmp/check-mk-agent.deb:
  file.managed:
    - source: salt://checkmk_install/files/check-mk-agent_1.5.0p19-1_all.deb
    - user: root
    - group: root

install_checkmk:
  cmd.run:
    - name: echo N | dpkg -i /tmp/check-mk-agent.deb

{% elif grains['os'] == 'CentOS' %}

/tmp/check-mk-agent.rpm:
  file.managed:
    - source: salt://checkmk_install/files/check-mk-agent-1.5.0p19-1.noarch.rpm
    - user: root
    - group: root

install_checkmk:
  cmd.run:
    - name: rpm -Uvh /tmp/check-mk-agent.rpm
    - unless:
      - rpm -q check-mk-agent-1.5.0p19-1.noarch

/usr/lib/check_mk_agent/plugins/mk_logins:
  file.managed:
    - source: salt://checkmk_install/files/mk_logins
    - user: root
    - group: root
    - mode: 770

{% endif %}

/etc/xinetd.d/check_mk:
  file.managed:
    - source: salt://checkmk_install/files/check_mk
    - user: root
    - group: root
    - mode: 644
