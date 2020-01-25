FROM php:7.0-fpm

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.2.0"

RUN \
    pecl install xdebug \
    && docker-php-ext-enable xdebug