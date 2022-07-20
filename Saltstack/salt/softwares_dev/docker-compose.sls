install_docker_composes:
  cmd.run:
    - name: curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

grant_permission:
  cmd.run:
    - name: chmod +x /usr/local/bin/docker-compose
    - watch:
      - cmd: install_docker_composes

link_docker_compose:
  cmd.run:
    - name:  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    - unless: ls -l /usr/bin/docker-compose
