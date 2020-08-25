FROM php:7.0-fpm
# readline: libreadline-dev libedit-dev 
# xml & soap: libxml2-dev
# zip: zlib1g-dev
# pgsql: libpq-dev
# intl: libicu-dev
# imap: libc-client-dev libkrb5-dev
# curl: libcurl4-gnutls-dev
# gd: libpng-dev
RUN apt-get update                                                     && \
    apt-get install -y zlib1g-dev libxml2-dev libreadline-dev libedit-dev \
                       libpq-dev libicu-dev libc-client-dev libkrb5-dev   \
                       libcurl4-gnutls-dev libpng-dev                  && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl      && \
    docker-php-ext-install bcmath json mbstring mysqli opcache zip xml    \
                           soap readline pgsql intl gd pdo_mysql calendar && \
    rm -rf /var/lib/apt/lists/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php  --install-dir=/bin --filename=composer            && \
    rm composer-setup.php
