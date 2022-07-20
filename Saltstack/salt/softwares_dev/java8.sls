/tmp/jdk-8u221-linux-x64.rpm:
  file.managed:
    - source: salt://softwares_dev/files/jdk-8u221-linux-x64.rpm
    - user: root
    - group: root

install_java_oracle_8:
  cmd.run:
    - name: rpm -Uvh /tmp/jdk-8u221-linux-x64.rpm
