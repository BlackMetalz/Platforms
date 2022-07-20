- Imagine your web app allow upload. You want make sure no shell that can execute uploaded to your server. This is one of them
```
    location ~* /var/tmp/.*.php$ {
        deny all;
        access_log off;
        log_not_found off;
    }
```
