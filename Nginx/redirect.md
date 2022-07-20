```
upstream dev{
    server 0.0.0.0:8080;
}

server {
    if ($host = dev.asd.org) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    server_name dev.asd.org;
    return 301 https://dev:8080/$request_uri;
}


server {

    listen 443;
    server_name dev.asd.org;

    location / {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
        proxy_pass http://dev;
    }
    ssl_certificate /etc/letsencrypt/live/dev.asd.org/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/dev.asd.org/privkey.pem; # managed by Certbot
}
```
