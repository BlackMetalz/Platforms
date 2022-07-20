1. Basic for nodejs frontend and laravel backend
```
server {
    listen 80;

    server_name hello-world.com;
    root /var/www/hello-world.com/current/dist/www;

    client_max_body_size 200m;

    access_log  /var/log/nginx/hello-world.com_access.log;
    error_log   /var/log/nginx/hello-world.com_error.log;

    resolver 169.254.169.250;
    set $upstream_endpoint fpm:9000;

    # Set max expire for static files
    expires $expires;

    # ModSecurity
    modsecurity on;
    modsecurity_rules_file /etc/nginx/modsecurity/main.conf;
    location / {
           index  index.php index.html index.htm;
    # try_files $uri $uri/ /index.php?$query_string;
           try_files $uri$args $uri$args/ $uri/ /index.html =404;
    }
    location ~ \.(eot|ttf|woff|woff2)$ {
            add_header Access-Control-Allow-Origin *;
        }

    location ^~ /api/ {
         alias /var/www/hello-world.com/backend/public;
         index  index.php index.html index.htm;
         try_files $uri $uri/ @api;

         location ~ \.php$ {
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 include fastcgi_params;
                 fastcgi_param SCRIPT_FILENAME $request_filename;
                 fastcgi_connect_timeout 50;
                 fastcgi_send_timeout 180;
                 fastcgi_read_timeout 180;
                 fastcgi_buffer_size 128k;
                 fastcgi_buffers 4 256k;
                 fastcgi_busy_buffers_size 256k;
                 fastcgi_temp_file_write_size 256k;
                 fastcgi_intercept_errors on;
                 fastcgi_pass $upstream_endpoint;
                 fastcgi_param HTTPS on;
         }
     }
     location @api {
            rewrite ^/api/(.*)$ /api/index.php?q=$1;
     }


    location ~* \.php$ {
           fastcgi_split_path_info ^(.+\.php)(/.+)$;
           include fastcgi_params;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
           fastcgi_connect_timeout 50;
           fastcgi_send_timeout 180;
           fastcgi_read_timeout 180;
           fastcgi_buffer_size 128k;
           fastcgi_buffers 4 256k;
           fastcgi_busy_buffers_size 256k;
           fastcgi_temp_file_write_size 256k;
           fastcgi_intercept_errors on;
           fastcgi_pass $upstream_endpoint;
           fastcgi_param HTTPS on;
    }

    location ~ /\. {
           access_log off;
           log_not_found off;
           deny all;
    }

}
```
