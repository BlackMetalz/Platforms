# Ubuntu 18 only...
required_package:
  pkg.installed:
    - pkgs:
      - wget


install_aerospike:
  cmd.run:
    - names: 
      - wget -O aerospike.tgz 'https://www.aerospike.com/download/server/latest/artifact/ubuntu18'
      - tar -xvf aerospike.tgz && cd aerospike-server-community-*-ubuntu18*  && ./asinstall
      - systemctl start aerospike

verify_aerospike:
  cmd.run:
    - names: 
      - asinfo -v STATUS
