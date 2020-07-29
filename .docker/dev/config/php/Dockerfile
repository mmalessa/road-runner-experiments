FROM php:7.4-cli

ARG DEVELOPER_UID
RUN useradd -m -s /bin/bash -u ${DEVELOPER_UID} developer && \
	apt-get update && apt-get install -y vim mc git libzip-dev unzip&& \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install sockets bcmath zip && \
    pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini && \
	echo "su - developer" > /root/.bashrc

WORKDIR "/application"
