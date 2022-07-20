check_copy_file:
  file.managed:
    - name: /root/aerospike-tools-3.22.0.ubuntu18.04.x86_64.deb
    - source: salt://aerospike_tools/files/aerospike-tools-3.22.0.ubuntu18.04.x86_64.deb
    - user: root
    - group: root
    - unless: dpkg -s aerospike-tools | grep Status

install aerospike tools:
  cmd.run:
    - name: dpkg -i /root/aerospike-tools-3.22.0.ubuntu18.04.x86_64.deb
    - onlyif: ls /root/aerospike-tools-3.22.0.ubuntu18.04.x86_64.deb


check install:
  cmd.run:
    - name: asadm --version
    - onlyif: dpkg -s aerospike-tools | grep Status
