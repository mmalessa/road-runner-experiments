FROM php:8.2.5-cli AS base
ARG COMPOSER_VERSION=2.5.5

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION
RUN apt-get update \
    && apt-get install -y git zip unzip
RUN docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-install pcntl
RUN pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini

FROM base AS dev
WORKDIR "/app"
RUN apt-get update \
    && apt-get install -y vim wget libicu-dev g++ zlib1g-dev procps
RUN pecl install xdebug-3.2.0 \
    && docker-php-ext-enable xdebug
RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl
RUN wget https://github.com/infection/infection/releases/download/0.26.19/infection.phar -O /usr/bin/infection \
	&& chmod +x /usr/bin/infection
ARG DEVELOPER_UID
RUN useradd -m -s /bin/bash -u ${DEVELOPER_UID} developer
USER developer