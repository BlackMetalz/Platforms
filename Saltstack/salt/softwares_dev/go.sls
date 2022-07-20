download_go:
  cmd.run:
    - name: 'wget -P /usr/local https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz'

extract_go:
  cmd.run:
    - name: 'tar -C /usr/local -xzf /usr/local/go1.12.7.linux-amd64.tar.gz'

set_go_path:
  cmd.run:
    - name: 'export PATH=$PATH:/usr/local/go/bin'
