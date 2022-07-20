### Install Nginx with PHP-FPM


1. Nginx for Ubuntu 18.04: http://nginx.org/en/linux_packages.html#Ubuntu
```bash
apt install curl gnupg2 ca-certificates lsb-release -y
echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
apt update
apt install nginx -y
```
1.1 Basic nginx conf
```
user www-data;
worker_processes auto;
pid /var/run/nginx.pid;
#load_module /usr/lib/nginx/modules/ngx_http_modsecurity_module.so;
events {
    worker_connections 1024;
    # multi_accept on;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # SSL Settings
    ##
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
    ssl_prefer_server_ciphers on;

    ##
    # Logging Settings
    ##

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    ##
    # Gzip Settings
    ##

    gzip on;
    gzip_http_version 1.0;
    gzip_vary on;
    gzip_comp_level 6;
    gzip_proxied any;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/x-javascript application/xml image/x-icon image/png image/gif image/jpeg image/jpg image/svg+xml application/x-font-ttf application/x-font-truetype application/x-font-opentype application/font-woff;
    gzip_buffers 16 8k;
    gzip_disable "MSIE [1-6].(?!.*SV1)";

    map $sent_http_content_type $expires {
         default                       off;
         text/html                     epoch;
         font/opentype                 max;
         application/vnd.ms-fontobject max;
         application/x-font-ttf        max;
         text/css                      max;
         application/javascript        max;
         ~image/                       max;
         image/svg+xml                 max;
         
             ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    }
```

1.3 Basic virtual hosts config
```
server {
    listen 80;

    server_name site_dev;
    root /data/www/site_dev/current/public;

    client_max_body_size 200m;

    access_log  /var/log/nginx/site_dev_access.log;
    error_log   /var/log/nginx/site_dev_error.log;

    resolver 169.254.169.250;
    set $upstream_endpoint fpm:9000;

    ssl_certificate /etc/nginx/ssl/site_dev.vn.crt;
    ssl_certificate_key /etc/nginx/ssl/site_dev.vn.key;

    ssl_ciphers "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4";
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 5m;

    # Set max expire for static files
    expires $expires;
```



2. Php 7.3 on Ubuntu 18.04:
```
3. If you are using nginx, you are advise to add ppa:ondrej/nginx-mainline
   or ppa:ondrej/nginx
   
add-apt-repository ppa:ondrej/nginx-mainline
```

```bash Still recommend this repo
add-apt-repository ppa:ondrej/php
apt install php7.3-fpm php7.3-gd  php7.3-exif php7.3-zip php7.3-mysqli php7.3-mbstring php7.3-curl php7.3-soap
```

3.Certbot ubuntu18
```
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python-certbot-nginx
```

Usage 
```
certbot --nginx
# Test
certbot renew --dry-run
```


