<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpress' );
define( 'DB_PASSWORD', 'evapass' );
define( 'DB_HOST', 'mariadb:3306' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('WP_HOME', 'https://eprzybyl.42.fr');
define('WP_SITEURL', 'https://eprzybyl.42.fr');
define('WP_HTTP_BLOCK_EXTERNAL', false);
define('REST_API_DISABLED', false);  // Keep it enabled but avoid warning
define('FORCE_SSL_ADMIN', true);
$_SERVER['HTTPS'] = 'on';


$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';