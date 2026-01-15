#!/bin/bash

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=JO/ST=Amman/L=Amman/O=42Amman/OU=ealshorm/CN=$WP_URL"
echo "Nginx: SSL certificate generated for $WP_URL"

exec nginx -g "daemon off;"