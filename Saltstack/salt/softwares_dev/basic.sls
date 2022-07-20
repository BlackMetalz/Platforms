{% if grains['os'] == 'CentOS' %}
install_spel_release:
  pkg.installed:
    - pkgs:
      - epel-release
{% endif %}

install_basic_softwares:
  pkg.installed:
    - pkgs:
      - git
      - htop
      - screen
      - telnet

