# Build in Ubuntu

- Required

```
apt-get install libc6-dev libssl-dev openssl lua5.1 liblua5.1-dev libz-dev autoconf -y
```

- Installing libevent
```
wget "https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz"
tar xvf libevent-2.1.11-stable.tar.gz
cd libevent-2.1.11-stable
./configure
make
make install
```

- Clone the source

```
git clone https://github.com/aerospike/aerospike-server.git
```

After the initial cloning of the aerospike-server repo., the submodules must be fetched for the first time using the following command:
```
$ git submodule update --init
```

Build with -j option
```
make -j8 # 8 is number of your core for parallel job
```

-- Make a deb file by command
```
make deb
```

.deb file located in aerospike-server/pkg/packages/aerospike-server-community-4.8.0.5.ubuntu18.04.x86_64.deb

then dpkg -i aerospike-server-community-4.8.0.5.ubuntu18.04.x86_64.deb to install aerospike server. Don't forget to add config file if you want start aerospike server

Credit: https://github.com/aerospike/aerospike-server
