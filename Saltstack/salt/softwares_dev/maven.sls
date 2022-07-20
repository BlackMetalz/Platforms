install_basic_softwares:
  pkg.installed:
    - name: maven

check_version:
  cmd.run:
    - name: 'mvn -version'
