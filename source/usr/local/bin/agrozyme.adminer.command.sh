#!/bin/bash
set -euo pipefail

function main() {
  agrozyme.alpine.function.sh change_core
  agrozyme.alpine.function.sh empty_folder /run/php-fpm7
  chown -R core:core /var/www/html
  exec php -S [::]:8080 -t /var/www/html
}

main "$@"
