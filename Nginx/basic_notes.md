- Forced NGINX know that request is HTTPS even with port HTTP ( Getting PHP HTTPS-Detection Working in Nginx
 ), pass this into .conf files for your host
```
location ~* \.php$ {
  fastcgi_param HTTPS on;
 }
```
Credit: https://blog.chrismeller.com/getting-php-https-detection-working-in-nginx
