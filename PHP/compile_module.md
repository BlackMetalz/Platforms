### Scenario: When you have stack php ( example oneinstack ), but it does not support install extension other than oneinstack support
#### Ref: https://github.com/oneinstack/oneinstack/issues/216


Details:

```
# Download the source of php which matched with version of command `php -v`.  In this case I used 7.4.0
wget https://www.php.net/distributions/php-7.4.30.tar.gz
# extract and cd to ext folder, example /root/php-7.4.30/ext/gmp ( gmp extension for an example )
# Then config with php-config, path, location, etc. If you compile nginx from scratch you will understand this xDD
./configure --with-php-config=/usr/local/php/bin/php-config
# cmake times
make && make-install
# testing build
make test
# compile time
make install
# After this it will show both location for, below is example
# Installing shared extensions:     /usr/local/php/lib/php/extensions/no-debug-non-zts-20190902/
# Installing header files:          /usr/local/php/include/php/
# Add module to ini file via below command.
echo 'extension=gmp.so' > /usr/local/php/etc/php.d/ext-gmp.ini
# After that restart php-fpm to take effects
# Then you can check with command below to see gmp extension is loaded or not
php -m |grep gmp
```

