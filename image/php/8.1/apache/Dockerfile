FROM php:8.1-apache-buster

LABEL maintainer="Rye Miller" \
      vendor="The Dark Society <containers@darksociety.cloud>" \
      version="0.1"

LABEL org.opencontainers.image.authors=support@privatebin.org \
      org.opencontainers.image.vendor=PrivateBin \
      org.opencontainers.image.documentation=https://github.com/PrivateBin/docker-nginx-fpm-alpine/blob/master/README.md \
      org.opencontainers.image.source=https://github.com/PrivateBin/docker-nginx-fpm-alpine \
      org.opencontainers.image.licenses=zlib-acknowledgement \
      org.opencontainers.image.version=${RELEASE}

# Metadata
LABEL org.opencontainers.image.vendor="Jose Quintana" \
    org.opencontainers.image.url="https://github.com/joseluisq/alpine-php-fpm" \
    org.opencontainers.image.title="PHP-FPM v8.2 Alpine" \
    org.opencontainers.image.description="PHP-FPM v8.2 with essential extensions on top of Alpine Linux." \
    org.opencontainers.image.version="$PHP_VERSION" \
    org.opencontainers.image.documentation="https://github.com/joseluisq/alpine-php-fpm"

ARG PHP_VERSION
FROM php:${PHP_VERSION}

LABEL maintainer="Aron Peyroteo <aron@mqx.com.br>" \
  org.label-schema.name="aronpc/php" \
  org.label-schema.description="Docker images for PHP" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-url="https://github.com/aronpc/php"


ARG NAME_IMAGE_BASE='php'
ARG NAME_IMAGE_TAG='8.2-fpm-alpine3.16'

FROM ${NAME_IMAGE_BASE}:${NAME_IMAGE_TAG}

ARG VERSION_OS='3.16'
ARG VERSION_PHP='8.2'

LABEL \
    ALPINE="$VERSION_OS" \
    PHP_VERSION="$VERSION_PHP" \
    MAINTAINER='Samuel Fontebasso <samuel.txd@gmail.com>'



FROM php:8.2.11-apache

RUN set -eux; \
    echo; \
    php -i; \
    php -m

COPY config/*.ini /usr/local/etc/php/conf.d/

RUN true \
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-ext-enable mysqli \
    && a2enmod headers \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && true

