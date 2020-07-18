FROM php:7.4.7-cli

ARG DEVELOPER_UID
RUN useradd -m -s /bin/bash -u ${DEVELOPER_UID} developer && \
    apt-get -y update --fix-missing && \
    apt-get -y install vim mc wget git curl zip curl libonig-dev libzip-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    docker-php-ext-install mbstring sockets zip && \
    pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    rm -rf /var/lib/apt/lists/* && \
    pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini && \
    echo "su - developer" > /root/.bashrc && \
    echo "Build done"

WORKDIR "/application"