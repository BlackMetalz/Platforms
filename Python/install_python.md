# Centos
### Build from source

### Install requirements:
```
yum install gcc openssl-devel bzip2-devel libffi-devel -y
```

### Download Python 3.7
```
cd /usr/src
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar xzf Python-3.7.3.tgz
cd Python-3.7.3
./configure --enable-optimizations && make altinstall
```

- make altinstall is used to prevent replacing the default python binary file /usr/bin/python

### Cleanup: 
```
rm /usr/src/Python-3.7.3.tgz
```

### Probably when test python3.7 -V will show output command not found. Here is solution:
```
cp /usr/src/Python-3.7.0/python /usr/bin/python3.7
```
### Check it again
```
python3.7 -V

Python 3.7.3
```

- Reference: https://tecadmin.net/install-python-3-7-on-centos/ 
- Fix command not found from comment


# From repo
``` 
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
```

``` 
sudo yum update 
```

``` 
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip
```

```
python3.6 -V
```
