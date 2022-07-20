transfer backup script:
  file.managed:
    - name: /opt/aerospike_backup.sh
    - source: salt://aerospike_backup/files/aerospike_backup.sh
    - user: root
    - group: root
    - mode: 744

setup cronjob for backup in 0:00 everday:
  cron.present:
    - name: bash /opt/aerospike_backup.sh
    - user: root
    - minute: 0
    - hour: 0
