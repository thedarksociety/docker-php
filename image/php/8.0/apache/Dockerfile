FROM php:8.0-apache-buster

LABEL \
  maintainer="The Dark Society <containers@darksociety.cloud" \
  vendor="The Dark Society" \
  version="0.1.0"


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



####

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

    org.opencontainers.image.description="PHP-FPM v8.2 with essential extensions on top of Alpine Linux." \
    org.opencontainers.image.version="$PHP_VERSION" \
    org.opencontainers.image.documentation="https://github.com/joseluisq/alpine-php-fpm"

ARG PHP_VERSION
FROM php:${PHP_VERSION}



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






# syntax=docker/dockerfile:1.2
FROM --platform=$TARGETPLATFORM php:$VERSION-fpm-$BASEIMAGE

ARG TARGETPLATFORM
ARG VERSION
ARG BASEIMAGE

ENV DEBIAN_FRONTEND noninteractive

# Persistent dependencies
RUN set -eux; \
    \
    # https://serverfault.com/questions/633394/php-configure-not-finding-ldap-header-libraries
    #if [ ${TARGETPLATFORM} = linux/386 ]; then \
    #    ln -s /usr/lib/i386-linux-gnu/libldap.so /usr/lib/libldap.so; \
    #    ln -s /usr/lib/i386-linux-gnu/liblber.so /usr/lib/liblber.so; \
    #fi; \
    # https://github.com/docker/buildx/issues/495#issuecomment-772267281
    #if [ ${TARGETPLATFORM} = linux/arm64 ]; then \
    #    ln -s /usr/bin/dpkg-split /usr/sbin; \
    #    ln -s /usr/bin/dpkg-deb /usr/sbin; \
    #    ln -s /bin/tar /usr/sbin; \
    #    ln -s /bin/rm /usr/sbin; \
    #fi; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
# Ghostscript is required for rendering PDF previews
		ghostscript \
	; \
	rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
		libbz2-dev libicu-dev libldap2-dev libldb-dev libpq-dev libxslt1-dev libzip-dev libc-client-dev \
		libkrb5-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libxpm-dev \
		libmagickwand-dev libmemcached-dev zlib1g-dev libzstd-dev libedit-dev \
    ; \
	docker-php-ext-configure gd --with-freetype --with-jpeg --with-xpm --with-webp; \
	docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos; \
	docker-php-ext-install -j$(nproc) \
		bz2 bcmath calendar exif gd gettext imap intl ldap mysqli pcntl pdo_mysql pdo_pgsql \
		shmop sockets sysvmsg sysvsem sysvshm xsl zip readline; \
	docker-php-ext-enable opcache; \
	# imagick
# use github version for now until release from https://pecl.php.net/get/imagick is ready for PHP 8
# https://github.com/Imagick/imagick/issues/331#issuecomment-779190777
# https://github.com/Imagick/imagick/issues/331#issuecomment-785284870
	mkdir -p /usr/src/php/ext/imagick; \
	curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
	docker-php-ext-install -j$(nproc) imagick; \
	rm -rf /usr/src/php/ext/imagick; \
	# apcu igbinary msgpack xdebug
	echo 'no' | pecl install apcu; \
	pecl install igbinary; \
	pecl install msgpack; \
	pecl install xdebug; \
	docker-php-ext-enable apcu igbinary msgpack xdebug; \
	# redis memcached
	echo 'yes\nyes\nyes' | pecl install redis; \
	echo 'no\nno\nno\nyes\nno\nyes\nno\nyes\nyes' | pecl install memcached; \
	docker-php-ext-enable redis memcached; \
    \
	# clean
	pecl clear-cache; \
    docker-php-source delete; \
	apt-get -y remove --purge \
		libbz2-dev libicu-dev libldap2-dev libpq-dev libxslt1-dev libzip-dev libc-client-dev libkrb5-dev \
		libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libxpm-dev libmagickwand-dev \
		libmemcached-dev zlib1g-dev libzstd-dev libedit-dev \
    ; \
    \
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
        | awk '/=>/ { print $3 }' \
        | sort -u \
        | xargs -r dpkg-query -S \
        | cut -d: -f1 \
        | sort -u \
        | xargs -rt apt-mark manual; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
ENV MAX_EXECUTION_TIME 600
ENV MEMORY_LIMIT 512M
ENV UPLOAD_LIMIT 2048K
RUN set -ex; \
    \
    { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
    } > $PHP_INI_DIR/conf.d/opcache-recommended.ini; \
    \
    { \
        echo 'session.cookie_httponly=1'; \
        echo 'session.use_strict_mode=1'; \
    } > $PHP_INI_DIR/conf.d/session-strict.ini; \
    \
    { \
        echo 'allow_url_fopen=Off'; \
        echo 'max_execution_time=${MAX_EXECUTION_TIME}'; \
        echo 'max_input_vars=10000'; \
        echo 'memory_limit=${MEMORY_LIMIT}'; \
        echo 'post_max_size=${UPLOAD_LIMIT}'; \
        echo 'upload_max_filesize=${UPLOAD_LIMIT}'; \
    } > $PHP_INI_DIR/conf.d/phpmyadmin-misc.ini; \
    \
    # https://wordpress.org/support/article/editing-wp-config-php/#configure-error-logging
    { \
# https://www.php.net/manual/en/errorfunc.constants.php
# https://github.com/docker-library/wordpress/issues/420#issuecomment-517839670
		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
		echo 'display_errors = Off'; \
		echo 'display_startup_errors = Off'; \
		echo 'log_errors = On'; \
		echo 'error_log = /dev/stderr'; \
		echo 'log_errors_max_len = 1024'; \
		echo 'ignore_repeated_errors = On'; \
		echo 'ignore_repeated_source = Off'; \
		echo 'html_errors = Off'; \
	} > $PHP_INI_DIR/conf.d/error-logging.ini



