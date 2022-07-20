### Laravel 5 URL Rewrite:

- Changes in config file:
```
location / {
    try_files $uri $uri/ /index.php?$query_string;
}
```

http://laravel.com/docs/5.0/installation#pretty-urls



### Laravel 5 Permission
```
chgrp -R www-data /var/www/site
chmod -R 775 /var/www/site/storage
```
