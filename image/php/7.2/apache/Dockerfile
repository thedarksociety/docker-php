FROM php:7.2-apache-buster


LABEL maintainer="development@darksociety.cloud"


ENV TZ=America/Denver
RUN \
    set -xe \
    && ls -fns /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone


COPY etc/config/000-default.conf ${APACHE_CONFDIR}/sites-available/000-default.conf
COPY etc/config/php-override.ini ${PHP_INI_DIR}/conf.d/php-override.ini


# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN \
    set -xeu \
    && apt-get update -q \
    && apt-get install -qq -y \
        git; \
    install-php-extensions \
        redis; \
    a2enmod rewrite \
    && a2enmod headers \
    && a2enmod expires \
    && a2enmod http2; \
    service apache2 restart \
    # && mkdir -p /etc/cron.d/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # && service cron start \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log


COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH "$PATH:/root/.composer/vendor/bin"
ENV PATH bin:vendor/bin:$PATH

RUN chmod +x /usr/local/bin/composer


RUN \
    chown -hR www-data:www-data /var/log/apache2/ \
    && chown -hR www-data:www-data /var/run/apache2/

RUN \
    chown -R www-data:www-data /var/www/html \
    && usermod -a -G root www-data

USER www-data