FROM ghcr.io/roadrunner-server/roadrunner:2023.2.2 AS roadrunner
FROM php:8.2.10-cli-alpine3.18 AS base

COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

ARG COMPOSER_VERSION=2.6.2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION

RUN apk update \
    && apk add zip unzip linux-headers bash

RUN docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-install pcntl sockets

RUN pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini

FROM base AS dev

RUN apk update \
    && apk add vim wget autoconf g++ make

RUN pecl install xdebug-3.2.0 \
    && docker-php-ext-enable xdebug

ARG CURRENT_UID
ARG CURRENT_UNAME=appuser
RUN adduser -s /bin/bash -u ${CURRENT_UID} -D ${CURRENT_UNAME}
USER ${CURRENT_UNAME}
WORKDIR /app