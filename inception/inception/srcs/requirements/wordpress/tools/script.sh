#!/bin/bash

# Function to create necessary directories
create_directories() {
    echo "Creating necessary directories..."
    mkdir -p /var/www/html
}

# Function to clean up existing files
clean_up() {
    echo "Removing existing files in /var/www/html..."
    cd /var/www/html
    rm -rf *
}

# Function to download and set up WP-CLI
setup_wp_cli() {
    echo "Downloading and setting up WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
}

# Function to download WordPress core
download_wordpress() {
    echo "Downloading WordPress core..."
    wp core download --allow-root
}

# Function to configure WordPress
configure_wordpress() {
    echo "Configuring WordPress..."
    mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    mv /wp-config.php /var/www/html/wp-config.php

    # Update wp-config.php with database credentials
    sed -i -r "s/db1/$db_name/1" wp-config.php
    sed -i -r "s/user/$db_user/1" wp-config.php
    sed -i -r "s/pwd/$db_pwd/1" wp-config.php
}

# Function to install WordPress core
install_wordpress() {
    echo "Installing WordPress..."
    wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
}

# Function to create a new WordPress user
create_wordpress_user() {
    echo "Creating new WordPress user..."
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
}

# Function to install and activate a WordPress theme
install_theme() {
    echo "Installing and activating the Astra theme..."
    wp theme install twentytwentytwo --activate --allow-root

}

# Function to update all WordPress plugins
update_plugins() {
    echo "Updating all WordPress plugins..."
    wp plugin update --all --allow-root
}

# Function to configure PHP-FPM
configure_php_fpm() {
    echo "Configuring PHP-FPM..."
    sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
    mkdir -p /run/php
}

# Function to start PHP-FPM
start_php_fpm() {
    echo "Starting PHP-FPM..."
    /usr/sbin/php-fpm7.3 -F
}

# Execute functions
create_directories
clean_up
setup_wp_cli
download_wordpress
configure_wordpress
install_wordpress
create_wordpress_user
install_theme
update_plugins
configure_php_fpm
start_php_fpm

echo "WordPress installation and setup complete."
