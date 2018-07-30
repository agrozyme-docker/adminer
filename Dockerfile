FROM agrozyme/php:7.2
COPY source /
ARG VERSION=4.6.3

RUN set -euxo pipefail \
  && chmod +x /usr/local/bin/*.sh \
  && apk add --no-cache php7-session php7-curl php7-json php7-mongodb $(apk search --no-cache -xq php7-pdo* | sort) \
  && wget -O adminer.php https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}.php \
  && wget -O source.tar.gz https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}.tar.gz \
  && tar xzf source.tar.gz --strip-components=1 "adminer-${VERSION}/designs/" "adminer-${VERSION}/plugins/" \
  && rm source.tar.gz \
  && sed -ri \
  -e 's/^[;[:space:]]*(upload_max_filesize)[[:space:]]*=.*$/\1 = 32M/i' \
  -e 's/^[;[:space:]]*(post_max_size)[[:space:]]*=.*$/\1 = 32M/i' \
  -e 's/^[;[:space:]]*(max_execution_time)[[:space:]]*=.*$/\1 = 600/i' \
  /etc/php7/php.ini

EXPOSE 8080
CMD ["agrozyme.adminer.command.sh"]
