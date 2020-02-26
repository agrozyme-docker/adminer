FROM docker.io/agrozyme/php:7.3
COPY rootfs /
RUN set +e -uxo pipefail && chmod +x /usr/local/bin/* && /usr/local/bin/docker-build.lua
EXPOSE 8080
CMD ["/usr/local/bin/docker-run.lua"]
