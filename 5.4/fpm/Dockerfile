FROM php:5.4-fpm

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.1.0"

# Install PHP/Pecl Dependencies
RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
    libping12-dev \
    libpq-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev

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
    memcached-2.2.0 \
    redis-4.3.0 \
    zendopcache \
    && docker-php-ext-enable memcached.so redis.so opcache.so

RUN \
    rm -rf /var/lib/apt/lists/*

# Install Composer
RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1