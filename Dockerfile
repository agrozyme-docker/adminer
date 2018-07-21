FROM agrozyme/php:7.2
COPY docker/ /docker/
COPY html/ /var/www/html/
ARG VERSION=4.6.3

RUN set -euxo pipefail \
  && chmod +x /docker/*.sh \
  && apk add --no-cache php7-session php7-curl php7-json php7-mongodb $(apk search --no-cache -xq php7-pdo* | sort) \
  && wget -O adminer.php https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}.php \
  && wget -O source.tar.gz https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}.tar.gz \
  && tar xzf source.tar.gz --strip-components=1 "adminer-${VERSION}/designs/" "adminer-${VERSION}/plugins/" \
  && rm source.tar.gz \
  && chown -R nobody:nobody /var/www/html \
  && sed -ri \
    -e 's!^upload_max_filesize = 2M!upload_max_filesize = 128M!' \
    -e 's!^post_max_size = 8M!post_max_size = 128M!' \
    -e 's!^memory_limit = 128M!memory_limit = 1G!' \
    -e 's!^max_execution_time = 30!max_execution_time = 600!' \
    /etc/php7/php.ini

EXPOSE 8080
CMD ["/docker/agrozyme.adminer.command.sh"]
