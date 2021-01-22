FROM php:7.4-fpm

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.1"

RUN \
    pecl install xdebug \
    && docker-php-ext-enable xdebug