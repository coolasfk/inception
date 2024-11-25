#!/bin/sh
set -e

echo "Starting initialization script..."

# Copy wp-config.php to the correct location if it doesn't exist or if a new version is provided
if [ ! -f /var/www/html/wp-config.php ] || [ "$(diff /tmp/wp-config.php /var/www/html/wp-config.php)" != "" ]; then
    echo "Updating wp-config.php..."
    cp /tmp/wp-config.php /var/www/html/wp-config.php
fi

# Start PHP-FPM in foreground mode
if command -v php-fpm7.4 > /dev/null 2>&1; then
    echo "Starting PHP-FPM using php-fpm7.4..."
    exec php-fpm7.4 -F
elif command -v php-fpm > /dev/null 2>&1; then
    echo "Starting PHP-FPM using php-fpm..."
    exec php-fpm -F
else
    echo "PHP-FPM could not be found. Please verify installation."
    exit 1
fi
