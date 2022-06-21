FROM php:8.0.20-apache-bullseye

# Surpresses debconf complaints of trying to install apt packages interactively
# https://github.com/moby/moby/issues/4032#issuecomment-192327844

# Arguments
ARG user
ARG uid
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION=16

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get upgrade -y


RUN apt-get -y --no-install-recommends install --fix-missing \
    apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    curl \
    dialog \
    git \
    iputils-ping \
    lsb-release \
    mc \
    nano \
    openssl \
    software-properties-common \
    unzip \
    wget \
    zip

RUN apt-get -y --no-install-recommends install --fix-missing \
    libcurl4 \
    libcurl4-openssl-dev \
    libicu-dev \
    libonig-dev \
    libsqlite3-0 \
    libsqlite3-dev \
    libxml2-dev \
    libzip-dev \
    zlib1g-dev
RUN apt-get -y --no-install-recommends install --fix-missing default-mysql-client
RUN rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install xdebug
RUN pecl install xdebug-3.1.5 && \
    docker-php-ext-enable xdebug && \
    mkdir /var/log/xdebug

# Install redis
RUN pecl install redis-5.3.3 && \
    docker-php-ext-enable redis

# Install imagick
RUN apt-get update && \
    apt-get -y --no-install-recommends install --fix-missing libmagickwand-dev && \
    rm -rf /var/lib/apt/lists/*

# Workarround until imagick is available in pecl with php8 support
# Imagick Commit to install
# https://github.com/Imagick/imagick
ARG IMAGICK_COMMIT="132a11fd26675db9eb9f0e9a3e2887c161875206"

RUN cd /usr/local/src && \
    git clone https://github.com/Imagick/imagick && \
    cd imagick && \
    git checkout ${IMAGICK_COMMIT} && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf imagick && \
    docker-php-ext-enable imagick

# Other PHP8 Extensions
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install calendar
RUN docker-php-ext-install curl
RUN docker-php-ext-install exif
RUN docker-php-ext-install gd
RUN docker-php-ext-install gettext
RUN docker-php-ext-install iconv
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install opcache
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install soap
RUN docker-php-ext-install sockets
RUN docker-php-ext-install xml
RUN docker-php-ext-install zip


# Install Freetype
RUN apt-get -y update && \
    apt-get --no-install-recommends install -y libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd

# Enable apache modules
RUN a2enmod rewrite headers

# Install nodejs, yarn and npm
RUN curl -sLS https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarn.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/src/*

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www/html

USER $user
