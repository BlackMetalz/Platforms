### Compile boost from source for version compatible, like ubuntu 18 with boost 1.71 ( ubuntu 18 repo gives 1.65 only )
- Ref: https://stackoverflow.com/questions/12578499/how-to-install-boost-on-ubuntu
#### Requirements:
```
apt-get update
apt-get install build-essential g++ python-dev autotools-dev libicu-dev libbz2-dev 
```

#### Compiling
```
# Get the fucking source
wget https://boostorg.jfrog.io/artifactory/main/release/1.71.0/source/boost_1_71_0.tar.gz
# Uncompress and go inside the folder
# remember to remove package libboost-all-dev if you have install before
./bootstrap.sh --prefix=/usr/local
./b2 --with=all -j $(nproc) install
```
