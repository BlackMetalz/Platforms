run_repo:
  cmd.run:
    - names:
{% if grains['os'] == 'CentOS' %}
      - yum install -y https://centos7.iuscommunity.org/ius-release.rpm
      - yum update -y
      - yum install -y python36u python36u-libs python36u-devel python36u-pip

{% elif grains['os'] == 'Ubuntu' %}
      - apt-get update
      - apt-get install python3.6 python3-pip -y

{% endif %}
check_python:
  cmd.run:
    - name: 'python3.6 -V && pip3 --version'
    
    
#instal_pip:
#  cmd.run:
#    - name: 'ln -s /usr/bin/pip3.6 /usr/bin/pip3'
