#!/bin/bash


#!/bin/bash

generate_ssl_certificate() {
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out "$CERTS_" \
        -subj "/C=MO/L=BG/O=1337/OU=student/CN=$DOMAIN_NAME"
}

#ssl secure socket layer , encryption , authentication.

configure_nginx() {
    cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name www.$DOMAIN_NAME $DOMAIN_NAME;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    
    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF
}

reload_nginx() {
   nginx -g "daemon off;"
}

main() {
    generate_ssl_certificate
    configure_nginx
    reload_nginx
}

main