FROM agrozyme/php:7.2
COPY docker-command.sh /usr/local/bin/
COPY html/* /var/www/html/

RUN set -x \
  && chmod +x /usr/local/bin/docker-command.sh \
  && mkdir -p /var/www/html/plugins-enabled \
  && wget -O adminer.php https://github.com/vrana/adminer/releases/download/v4.6.3/adminer-4.6.3.php \
  && wget -O source.tar.gz https://github.com/vrana/adminer/releases/download/v4.6.3/adminer-4.6.3.tar.gz \
  && tar xzf source.tar.gz --strip-components=1 "adminer-4.6.3/designs/" "adminer-4.6.3/plugins/" \
  && rm source.tar.gz \
  && chown -R www-data:www-data /var/www/html \
  && sed -ri \
  -e 's!^upload_max_filesize = 2M!upload_max_filesize = 128M!' \
  -e 's!^post_max_size = 8M!post_max_size = 128M!' \
  -e 's!^memory_limit = 128M!memory_limit = 1G!' \
  -e 's!^max_execution_time = 30!max_execution_time = 600!' \
  /etc/php7/php.ini

EXPOSE 8080
CMD ["docker-command.sh"]