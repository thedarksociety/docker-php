FROM php:5.6-apache

LABEL \
  maintainer="The Dark Society <containers@darksociety.cloud" \
  vendor="The Dark Society" \
  version="0.1.0"

ARG DEBIAN_FRONTEND=noninteractive
ARG TIMEZONE="America/Denver"

ENV \
  ADMIN_EMAIL="webmaster@localhost" \
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME="/usr/local/composer" \
  COMPOSER_MEMORY_LIMIT=1 \
  COMPOSER_VERSION="2.5.8" \
  PHP_MEMORY_LIMIT=256 \
  PHP_POST_MAX_SIZE=32 \
  PHP_TIME_ZONE="${TIMEZONE}" \
  PHP_UPLOAD_MAX_FILESIZE=32

#USER root

# configure apache and php
# - switch apache server signature off
# - make apache document root configureable by env variable
# - use the php production settings by default

# change access rights to conf, logs, and bin from root to www-data
#RUN chown -hR www-data:www-data /var/log/apache2/
#RUN chown -hR www-data:www-data /var/run/apache2/

# install xdebug
#RUN \
#    pecl install xdebug \
#    && docker-php-ext-enable xdebug \
#    && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# install PHPUnit
#ENV PHPUNIT_VERSION=11.4.4

#RUN \
#    cd /tmp \
#    && wget https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar \
#    && chmod +x phpunit-${PHPUNIT_VERSION}.phar \
#    && mv phpunit-${PHPUNIT_VERSION}.phar /usr/local/bin/phpunit/

