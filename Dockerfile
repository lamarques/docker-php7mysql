FROM php:7.3-apache

LABEL maintainer="Rogerio Lamarques<rogerio.lamarques@gmail.com>"

ENV XDEBUG_PORT 9000

# Install System Dependencies

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    software-properties-common \
    apt-utils \
    && apt-get update \
    && apt install -y \
    libfreetype6-dev \
    libicu-dev \
    bzip2 \
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

#install mcrypt

RUN pecl install bz2 \
    && docker-php-ext-enable mcrypt

#configure gd

RUN docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/;

#install php exts

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install opcache
#RUN docker-php-ext-install bz2
RUN docker-php-ext-install curl
RUN docker-php-ext-install gd
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install imap
RUN docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install soap
RUN docker-php-ext-install simplexml
RUN docker-php-ext-install xml
RUN docker-php-ext-install xmlreader
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install xmlwriter
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-install calendar
RUN docker-php-ext-install ctype
RUN docker-php-ext-install dba
RUN docker-php-ext-install dom
RUN docker-php-ext-install enchant
RUN docker-php-ext-install exif fileinfo
RUN docker-php-ext-install filter
RUN docker-php-ext-install ftp
RUN docker-php-ext-install gettext
RUN docker-php-ext-install gmp
RUN docker-php-ext-install hash
RUN docker-php-ext-install iconv imap
RUN docker-php-ext-install interbase pdo_firebird
RUN docker-php-ext-install json tokenizer
RUN docker-php-ext-install ldap
RUN docker-php-ext-install odbc pdo_odbc
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo_dblib  pdo_sqlite
RUN docker-php-ext-install pgsql pdo_pgsql
RUN docker-php-ext-install phar posix pspell
RUN docker-php-ext-install readline recode reflection
RUN docker-php-ext-install session sockets
RUN docker-php-ext-install spl wddx
RUN docker-php-ext-install shmop snmp
RUN docker-php-ext-install sodium standard
RUN docker-php-ext-install sysvmsg sysvsem sysvshm
RUN docker-php-ext-install tidy     

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