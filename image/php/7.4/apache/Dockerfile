FROM php:7.4-apache-buster

LABEL maintainer="The Dark Society <containers@darksociety.cloud>"


ARG DEBIAN_FRONTEND=noninteractive
ARG TIMEZONE="America/Denver"

ENV TZ $TIMEZONE

USER root

# Install Base OS updates, PHP, and Composer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN set -xe pipefail; \
    # install Timezone
    echo "${TIMEZONE}" > /etc/timezone \
    && rm /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata; \
    # install Base Dependencies
    apt-get update -q \
    && apt-get install -qq -y \
        curl \
        dumb-init \
        git \
        unzip \
        zip; \
    # install php extensions and dependencies
    install-php-extensions \
        opcache \
        redis; \
    # install and configure apache server
    a2enmod headers rewrite \
    && echo "\nServerName localhost\n" >> /etc/apache2/apache2.conf \
    && echo "ServerSignature Off\n" >> /etc/apache2/apache2.conf; \
    # install clean up
    service apache2 restart \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

ENV \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME="/usr/local/composer" \
    COMPOSER_MEMORY_LIMIT=-1 \
    PATH="${PATH}:/root/.composer/vendor/bin" \
    PATH="bin:vendor/bin:${PATH}"

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer


# Certificates & Entrypoints
COPY --chown=root:root ./etc/bin/entrypoint.sh /usr/local/bin/entrypoint.sh


# Apache Server & Module Configurations
COPY ./etc/config/000-default.conf ${APACHE_CONFDIR}/sites-available/000-default.conf
ENV \
    APACHE_VHOST_SERVER_ADMIN="containers@darksociety.cloud" \
    APACHE_VHOST_SERVER_NAME="_" \
    APACHE_VHOST_DOCUMENT_ROOT="/var/www/html"


# PHP INI Settings & Module Configurations
COPY --chown=root:root ./etc/config/php/php-override.ini ${PHP_INI_DIR}/conf.d/php-override.ini
ENV \
    PHP_INI_MAX_EXECUTION_TIME=60 \
    PHP_INI_OPCACHE_ENABLE=1


WORKDIR /var/www/html


RUN \
    chmod ug+x /usr/local/bin/entrypoint.sh \
    && chown -R www-data:www-data /var/www


# https://github.com/Yelp/dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD "entrypoint.sh"
