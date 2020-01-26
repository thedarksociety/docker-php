FROM php:5.4-apache

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.2.1"

ENV APCU_VERSION 4.0.11
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /home/.composer
ENV MEMC_VERSION 2.2.0
ENV PATH $PATH:/root/composer/vendor/bin
ENV REDI_VERSION 4.3.0
ENV XDEB_VERSION 2.9.0

RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    libbz2-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libldap2-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libmemcachedutil2 \
    libmysqlclient-dev \
    libpng12-dev \
    libpq-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    openssh-client \
    unzip \
    zlib1g-dev

RUN \
    docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    iconv \
    intl \
    mbstring \
    mcrypt \
    mysql \
    mysqli \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    xsl \
    zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && docker-php-ext-install exif

RUN \
    pecl install \
    apcu-${APCU_VERSION} \
    memcached-${MEMC_VERSION} \
    redis-${REDI_VERSION} \
    xdebug-${XDEB_VERSION} \
    zendopcache \
    && docker-php-ext-enable \
    apcu \
    memcached.so \
    opcache.so \
    redis.sc \
    xdebug.so

RUN \
    apt-get clean \
    && rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer