#!/bin/bash

# Copy wp-config.php to the correct location if it doesn't exist or if a new version is provided
if [ ! -f /var/www/html/wp-config.php ] || [ "$(diff /tmp/wp-config.php /var/www/html/wp-config.php)" != "" ]; then
    echo "Updating wp-config.php..."
    cp /tmp/wp-config.php /var/www/html/wp-config.php
fi

# Start PHP-FPM
php-fpm
