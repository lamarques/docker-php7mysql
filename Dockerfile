FROM php:7.3-apache

LABEL maintainer="Rogerio Lamarques<rogerio.lamarques@gmail.com>"

ENV XDEBUG_PORT 9000

# Install System Dependencies

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    software-properties-common \
    apt-utils \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libssl-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libedit-dev \
    libedit2 \
    libxslt1-dev \
    gnupg \
    redis-tools \
    mysql-client \
    git \
    vim \
    wget \
    curl \
    lynx \
    psmisc \
    unzip \
    tar \
    cron \
    bash-completion \
    && apt-get clean

#install mcrypt

RUN pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt

#configure gd

RUN docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/;

#install php exts

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install \
    opcache \
    bz2 \
    curl \
    gd \
    bcmath \
    imap \
    intl \
    mbstring \
    mysqli \ 
    pdo \ 
    soap \
    simplexml \
    xml \
    xmlreader \
    xmlrpc \
    xmlwriter \
    xsl \
    xsl \
    zip \
    calendar \
    ctype \
    dba \
    dom \
    enchant \
    exif \
    fileinfo \
    filter \
    ftp \
    gettext \
    gmp \
    hash \
    iconv \
    imap \
    interbase \
    json \
    ldap \
    odbc \
    pcntl \
    pdo_dblib \
    pdo_firebird \
    pdo_odbc \
    pdo_pgsql \
    pdo_sqlite \
    pgsql \
    phar \
    posix \
    pspell \
    readline \
    recode \
    reflection \
    session \
    shmop \
    snmp \
    sockets \
    sodium \
    spl \
    standard \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    tokenizer \
    wddx

#configure www

RUN chmod 777 -Rf /var/www /var/www/.* \
    && chown -Rf www-data:www-data /var/www /var/www/.* \
    && usermod -u 1000 www-data \
    && chsh -s /bin/bash www-data\
    && a2enmod rewrite \
    && a2enmod headers \
    && a2enmod version

VOLUME /var/www/html
WORKDIR /var/www/html

EXPOSE 80 443