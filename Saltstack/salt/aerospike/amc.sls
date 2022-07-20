# For ubuntu 
get_deb_file:
  cmd.run:
    - names: 
      - wget https://www.aerospike.com/download/amc/4.0.27/artifact/ubuntu12 -O /tmp/aerospike-amc.deb
      - dpkg -i /tmp/aerospike-amc.deb

start_amc:
  cmd.run:
    - names: 
      - systemctl start amc
