### Note step for install old openssl version
#### In this scenario I will using openssl 1.1.1f

- First Get source code from here and read document for install: https://github.com/openssl/openssl/blob/OpenSSL_1_1_1f/INSTALL
```
# Config openssl compile to custom folder ( I was using Ubuntu 22.04 which shipped with openssl 3.x, therefore a lot of old source code can not compile with new openssl version )
./config --prefix=/data/wow-libs/openssl-1_1_1f --openssldir=/data/wow-libs/openssl-dir-1_1_1f
make
make test
make install
```

That's All.

for the Cmake Step, include following thing into cmake command to define custom openssl lib / header
```
-DOPENSSL_INCLUDE_DIR=/data/wow-libs/openssl-1_1_1f/include/ -DOPENSSL_LIBRARIES=/data/wow-libs/openssl-1_1_1f/lib/ -DOPENSSL_ROOT_DIR=/data/wow-libs/openssl-1_1_1f/ -DOPENSSL_USE_STATIC_LIBS=True
```

Have fun!
