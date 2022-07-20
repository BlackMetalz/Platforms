basic_package:
  pkg.installed:
    - pkgs:
      - curl


{% if grains['os'] == 'CentOS' %}

remove_old:
  pkg.removed:
    - pkgs: ["docker","docker-client","docker-client-latest","docker-common","docker-latest","docker-latest-logrotate","docker-logrotate","docker-engine","docker-ce-cli","docker-ce"]
  cmd.run:
    - names:
      - yum install -y yum-utils device-mapper-persistent-data lvm2
      - yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

{% elif grains['os'] == 'Ubuntu' %}

remove_old:
  pkg.removed:
    - pkgs: ["docker", "docker-engine", "docker.io", "containerd", "runc", "docker-ce", "docker-ce-cli"]

run_update:
  cmd.run:
    - name: "apt-get update"

install_required:
  pkg.installed:
    - pkgs: ["apt-transport-https","ca-certificates","gnupg-agent","software-properties-common"]
    
    run_some_shiet:
  cmd.run:
    - names:
      - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      - apt update

{% endif %}

state_install_docker:
  pkg.installed:
    - pkgs: ["docker-ce","docker-ce-cli","containerd.io"]

/etc/docker/daemon.json:
  file.managed:
    - source: salt://softwares_dev/files/daemon.json
    - user: root
    - group: root
    - template: jinja
    - mode: '0644'
    - makedirs: True
    - context:
      data_root : {{ salt['pillar.get']('data_root') }}
      bip : {{ salt['pillar.get']('bip') }}

docker_test:
  cmd.run:
    - names:
      - service docker restart
      - systemctl enable docker
      - docker run --rm  hello-world
