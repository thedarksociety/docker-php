



ENV ADMIN_EMAIL webmaster@localhost
ENV PHP_TIME_ZONE Europe/London
ENV PHP_MEMORY_LIMIT 256M
ENV PHP_UPLOAD_MAX_FILESIZE 32M
ENV PHP_POST_MAX_SIZE 32M

ADD 000-default.conf $APACHE_CONFDIR/sites-available/000-default.conf
ADD php-override.ini $PHP_INI_DIR/conf.d/php-override.ini





# Configure Apache and PHP.
#   - switch Apache server signature off
#   - make Apache document root configureable by environment variable
#   - use the PHP production settings as default

ENV APACHE_DOCUMENT_ROOT=/app

RUN set -ex \
    && sed -i -e '/ServerTokens/s/OS/Prod/g' -e '/ServerSignature/s/On/Off/g' /etc/apache2/conf-available/security.conf \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && cp ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini

WORKDIR ${APACHE_DOCUMENT_ROOT}

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.16

WORKDIR $NVM_DIR

RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /var/www/html

# End NVM install



# Install xdebug
ENV XDEBUG_VERSION=2.7.2

RUN \
    cd /tmp \
    && wget https://pecl.php.net/get/xdebug-${XDEBUG_VERSION}.tgz \
    && tar xzf xdebug-${XDEBUG_VERSION}.tgz \
    && cd xdebug-${XDEBUG_VERSION} \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable xdebug \
    && rm -rf /tmp/xdebug-${XDEBUG_VERSION}.tgz /tmp/xdebug-${XDEBUG_VERSION}

# install xdebug
RUN pecl install xdebug \
&& docker-php-ext-enable xdebug \
&& echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

    # Install phpunit
    ENV PHPUNIT_VERSION=7.5.20

    RUN \
        cd /tmp \
        && wget https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar \
        && chmod +x phpunit-${PHPUNIT_VERSION}.phar \
        && mv phpunit-${PHPUNIT_VERSION}.phar /usr/local/bin/phpunit



EXPOSE 9000

#Change access righs to conf, logs, bin from root to www-data
RUN chown -hR www-data:www-data /var/log/apache2/
RUN chown -hR www-data:www-data /var/run/apache2/

#setcap to bind to privileged ports as non-root
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2
RUN getcap /usr/sbin/apache2

# Update the webapp permissions so the site can write files
RUN chown -R www-data:www-data /var/www/html
RUN usermod -a -G root www-data
USER www-data


# Install default libraries/packages needed
bash
coreutils
ed
freetype
git
gzip
icu
libjpeg-turbo
libltdl
libmcrypt
libpng
libxml2
libzip
msmtp
mysql-client
unzip
wget



docker install
bcmath
calendar
exif
fileinfo
gd
iconv
imap
intl
json
mbstring
mysqli
pcntl
pdo_mysql
posix
shmop
soap
sysvshm
xml
zip


&& a2enmod rewrite \
	&& a2enmod http2 \
	&& mkdir -p /etc/cron.d/ \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& service cron start \
	&& ln -sf /dev/stdout /var/log/apache2/access.log \
	&& ln -sf /dev/stderr /var/log/apache2/error.log
















FROM php:7.2-fpm

LABEL maintainer="Rye Miller" \
      vendor="Darkstar Development" \
      version="0.1"

RUN \
    pecl install xdebug \
    && docker-php-ext-enable xdebug

    ENV PHP_EXT_XDEBUG=0 \
        FPM_PID=run/php-fpm.pid \
        FPM_DAEMONIZE=no \
        FPM_ERROR_LOG=/dev/stderr.pipe \
        FPM_WWW_ACCESS__LOG=/dev/stdout.pipe \
        FPM_WWW_CATCH_WORKERS_OUTPUT=yes \
        FPM_WWW_CLEAR_ENV=no \
        FPM_WWW_GROUP=www-data \
        FPM_WWW_LISTEN="[::]:9000" \
        FPM_WWW_USER=www-data \
        FPM_WWW_SLOWLOG=/dev/stdout.pipe \
        PHP_XDEBUG__REMOTE_ENABLE=1 \
        PHP_XDEBUG__REMOTE_HOST=172.17.0.1 \
        PHP_XDEBUG__REMOTE_PORT=9000 \
        PHP_XDEBUG__REMOTE_CONNECT_BACK=0 \
        PHP_XDEBUG__IDEKEY=PHPSTORM \
        RAWEXEC="$RAWEXEC php-fpm php-fpm$major"

            install-php-extensions

          bcmath \
              bz2 \
              calendar \
              exif \
              gd \
              intl \
              ldap \
              memcached \
              mysqli \
              opcache \
              pdo_mysql \
              pdo_pgsql \
              pgsql \
              redis \
              soap \
              xsl \
              zip \
              sockets \
              pdo_sqlsrv \
              sqlsrv \
        # already installed:
        #      iconv \
        #      mbstring \