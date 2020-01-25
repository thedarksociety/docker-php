FROM php:7.2-apache

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.2.0"

RUN \
    pecl install xdebug \
    && docker-php-ext-enable xdebug