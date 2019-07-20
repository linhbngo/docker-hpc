# This is a Dockerfile to build a head node for a cluster

# We will start from a base Alpine
FROM alpine:3.9.4

USER root

ENV SLAPD_PASSWORD goldenram
ENV SLAPD_DOMAIN ldap.golden.ram

RUN apk update && apk upgrade

RUN apk add --no-cache openldap openrc openssh openldap-back-mdb

RUN apk add --no-cache bash apache2 php7-apache2 curl ca-certificates openssl git php7 php7-phar php7-json php7-iconv php7-openssl tzdata openntpd nano

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Setup apache and php
RUN apk add \
	php7-ftp \
	php7-xdebug \
	php7-mcrypt \
	php7-mbstring \
	php7-soap \
	php7-gmp \
	php7-pdo_odbc \
	php7-dom \
	php7-pdo \
	php7-zip \
	php7-mysqli \
	php7-sqlite3 \
	php7-pdo_pgsql \
	php7-bcmath \
	php7-gd \
	php7-odbc \
	php7-pdo_mysql \
	php7-pdo_sqlite \
	php7-gettext \
	php7-xml \
	php7-xmlreader \
	php7-xmlwriter \
	php7-tokenizer \
	php7-xmlrpc \
	php7-bz2 \
	php7-pdo_dblib \
	php7-curl \
	php7-ctype \
	php7-session \
	php7-redis \
	php7-exif \
	php7-intl \
	php7-fileinfo \
	php7-ldap \
	php7-apcu

# Problems installing in above stack
RUN apk add php7-simplexml

RUN cp /usr/bin/php7 /usr/bin/php \
    && rm -f /var/cache/apk/*

RUN mkdir /app && mkdir /app/public && chown -R apache:apache /app && chmod -R 755 /app && mkdir bootstrap

RUN wget --quiet https://raw.githubusercontent.com/linhbngo/docker-hpc/master/src/sleep.sh -O /usr/local/bin/sleep.sh

RUN ["chmod", "+x", "/usr/local/bin/sleep.sh"]

EXPOSE 389 80 443
ENTRYPOINT ["/usr/local/bin/sleep.sh"]
