FROM php:7.2-apache-buster

LABEL maintainer="The Dark Society <containers@darksociety.cloud>"

ARG DEBIAN_FRONTEND=noninteractive
ARG TIMEZONE="America/Denver"

ENV \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME="/usr/local/composer" \
    COMPOSER_MEMORY_LIMIT=-1 \
    COMPOSER_VERSION="2.0.11" \
    TZ="${TIMEZONE}"

USER root

# Build the Image & Assets (Extension Installer/Composer)
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN set -xe; \
    echo "Install TZ Updates" \
    && "${TIMEZONE}" > /etc/timezone \
    && rm /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata; \
    echo "Install Dependencies" \
    && apt-get update -q \
    && apt-get install -qq -y \
        curl \
        git \
        unzip \
        zip; \
    echo "Install PHP Extensions" \
    && install-php-extensions \
        opcache \
        redis; \
    echo "Install Apache Server" \
    && a2enmod expires headers rewrite \
    && echo "\nServerName localhost\n" >> /etc/apache2/apache2.conf \
    && echo "ServerSignature Off\n" >> /etc/apache2/apache2.conf; \
    echo "Finish it" \
    && service apache2 restart \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

ENV PATH "$PATH:/root/.composer/vendor/bin"
ENV PATH bin:vendor/bin:$PATH


# Certificates & Entrypoint
COPY ./etc/certs/ /etc/ssl/certs/
COPY --chown=root:root ./etc/build/docker-entrypoint.sh /usr/local/bin/entrypoint.sh

# Apache Configuration
COPY ./etc/config/apache/000-default.conf ${APACHE_CONFDIR}/sites-available/000-default.conf
COPY ./etc/config/apache/default-ssl.conf ${APACHE_CONFDIR}/sites-available/default-ssl.conf

ENV APACHE_VHOST_SERVER_ADMIN="containers@darksociety.cloud" \
    APACHE_VHOST_SERVER_NAME="_" \
    APACHE_VHOST_DOCUMENT_ROOT="/var/www/html"

# PHP INI Settings for production by default
COPY --chown=root:root ./etc/config/php/php-override.ini ${PHP_INI_DIR}/conf.d/php-override.ini
ENV PHP_INI_MAX_EXECUTION_TIME=60

WORKDIR /var/www/html

RUN \
    chmod ug+x /usr/local/bin/entrypoint.sh \
    && chown -R www-data:www-data /var/www

# Unset proxy, timezone ENVs
RUN \
    unset http_proxy \
    && unset https_proxy \
    && unset no_proxy

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["apache2-foreground"]
