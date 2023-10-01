FROM php:7.4-cli

LABEL maintainer="The Dark Society <containers@darksociety.cloud>"

# install php extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# install composer v2
COPY --from=composer:2.0.8 /usr/bin/composer /usr/local/bin/composer

# PHP-FPM options and configs for production (default)
COPY --chown=root:root ./etc/config/php/php-override.ini /usr/local/etc/php/php-override.ini
COPY --chown=root:root ./etc/config/php/fpm/www.conf /usr/local/etc/php-fpm.d/www.conf
ENV \
    PHP_INI_ERROR_REPORTING="E_ALL & -E_NOTICE" \
    PHP_INI_MAX_EXECUTION_TIME=3000 \
    PHP_INI_MAX_INPUT_VARS=20000 \
    PHP_INI_POST_MAX_SIZE="60M" \
    PHP_INI_UPLOAD_MAX_FILESIZE="25M"