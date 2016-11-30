<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpressuser');

/** MySQL database password */
define('DB_PASSWORD', 'wordpress2016');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
#define('AUTH_KEY',         'put your unique phrase here');
#define('SECURE_AUTH_KEY',  'put your unique phrase here');
#define('LOGGED_IN_KEY',    'put your unique phrase here');
#define('NONCE_KEY',        'put your unique phrase here');
#define('AUTH_SALT',        'put your unique phrase here');
#define('SECURE_AUTH_SALT', 'put your unique phrase here');
#define('LOGGED_IN_SALT',   'put your unique phrase here');
#define('NONCE_SALT',       'put your unique phrase here');
define('AUTH_KEY',         'eN9@Tl{U!MuCY5=tJ3_#Z6hW[^F`loOr2ra)//>+/.65y&7auL=s|JfqwKTCk~eM');
define('SECURE_AUTH_KEY',  '|i<1,@GR|Z0]rFwD;6-`tp=HcQ[v0=mskR_agH+_eIpcqet/*T>Uzm|TnvQK]9y+');
define('LOGGED_IN_KEY',    'M6AimJ=$Hl.X0cw.#KpmD)2 CbMciWDwO+F0)ZAxs-D$@lJ$+C$^-InQAh3DY0:j');
define('NONCE_KEY',        'V-5b?sFB=p8vd=!cMunIv:P na$u58~3TR`iAmpCmMEY.Y!y;d+$`4GJeE1f56o+');
define('AUTH_SALT',        'C3/j.4d}0c5P^RN(9kPbp:m(~fa0EV+#;?Pb~5Y-=GMgMZ3/gEk+]|ed%1L=B;iT');
define('SECURE_AUTH_SALT', 'BVyT|PFc7_?-+7Y_=;684`#ikwVQa/gcWQ?)e{h=4]G]M^i|~JH&K+phCKgpQ7oO');
define('LOGGED_IN_SALT',   'X;=D,R&[AMsIoABxjz$yVBy._tM3>.-u3gGFqu|p6wDHtw/`t-;K|@O^cUIO2sG]');
define('NONCE_SALT',       '_?};P{6){|*(DRZ{[dE-bxPi?OA!uKt||[Tka@:^|;Vd,C&oh=h8TT)-5zFxCXF%');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

# Enable all core updates, including minor and major:
define( 'WP_AUTO_UPDATE_CORE', true );

# Turn off PHP error reporting
error_reporting(0);
@ini_set(‘display_errors’, 0);

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
