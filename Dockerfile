FROM php:7.2.17-apache
RUN apt-get update && apt-get install -y \
        unzip\
        libcurl4-gnutls-dev\
        libxml2-dev\
        libenchant-dev\
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libicu-dev \
        zlib1g-dev\
        chromium\
        libpq-dev\
    && docker-php-ext-install -j$(nproc) intl curl pdo zip json\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure intl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data
RUN alias sf="bin/console"
