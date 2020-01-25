FROM php:7.0-cli

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.2.1"

RUN \
    pecl install xdebug \
    && docker-php-ext-enable xdebug