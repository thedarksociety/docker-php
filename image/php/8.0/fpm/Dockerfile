FROM php:8.0-fpm

LABEL \
  maintainer="The Dark Society <containers@darksociety.cloud" \
  vendor="The Dark Society" \
  version="0.1.0"

RUN \
    pecl install xdebug \
    && docker-php-ext-enable xdebug
