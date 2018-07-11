#!/bin/sh
set -e
rm -f /run/php-fpm7/php-fpm.pid
exec php -S [::]:8080 -t /var/www/html