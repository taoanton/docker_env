FROM php:5.6-fpm

MAINTAINER taoanton@gmail.com

# Add aliyun repository
RUN echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list

# Get repository and install wget and vim
RUN apt-get update && apt-get install --no-install-recommends -y \
        wget \
        vim \
        git \
        unzip

# Install Oracle Instantclient
RUN mkdir /opt/oracle \
    && cd /opt/oracle \
    && wget http://repo.domain.com/pkg/instantclient-basic-linux.x64-12.1.0.2.0.zip \
    && wget http://repo.domain.com/pkg/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && unzip /opt/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
    && unzip /opt/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
    && ln -s /opt/oracle/instantclient_12_1/libclntsh.so.12.1 /opt/oracle/instantclient_12_1/libclntsh.so \
    && ln -s /opt/oracle/instantclient_12_1/libclntshcore.so.12.1 /opt/oracle/instantclient_12_1/libclntshcore.so \
    && ln -s /opt/oracle/instantclient_12_1/libocci.so.12.1 /opt/oracle/instantclient_12_1/libocci.so \
    && rm -rf /opt/oracle/*.zip


# Install PHP extensions deps
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        libicu-dev \
        g++ \
        unixodbc-dev \
        libxml2-dev \
        libaio-dev \
        libmemcached-dev \
        freetds-dev 

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && echo 'instantclient,/opt/oracle/instantclient_12_1/' | pecl install oci8-2.0.11 \
    && pecl install redis-2.2.8 \
    && pecl install memcached \
    && pecl install xdebug \
    # && pecl install mongodb \
    && docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,/opt/oracle/instantclient_12_1,12.1 \
    && docker-php-ext-configure pdo_dblib --with-libdir=/lib/x86_64-linux-gnu \
    && docker-php-ext-install \
            intl \
            mcrypt \
            gd \
            mysqli \
            pdo_mysql \
            pdo_oci \
            pdo_dblib \
            soap \
            sockets \
            zip \
            pcntl \
    && docker-php-ext-enable \
            oci8 \
            memcached \
            xdebug \
            # mongodb \
            redis \
            opcache

# COPY redis.tgz /home/redis.tgz
COPY xdebug.tgz /home/xdebug.tgz
COPY xhprof.tgz /home/xhprof.tgz
COPY swoole-1.8.7.tgz /home/swoole.tgz
COPY mongodb-1.1.9.tgz /home/mongodb.tgz

RUN pecl install /home/xhprof.tgz && echo "extension=xhprof.so" > /usr/local/etc/php/conf.d/xhprof.ini \
    && pecl install /home/swoole.tgz && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini \
    && pecl install /home/mongodb.tgz && echo "extension=mongodb.so" >> /usr/local/etc/php/php.ini

    # && pecl install /home/xdebug.tgz && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini    

# install phalcon
COPY phalcon-v3.0.1.tar.gz /home/phalcon.tar.gz
RUN cd /home/ && tar -zxf phalcon.tar.gz \
# && cd /home/cphalcon-3.0.1/build/php5/64bits \
# && export CFLAGS="-O2 -g" \
# && phpize \
# && ./configure --enable-phalcon \
# && make \
# && make install \
&& cd /home/cphalcon-3.0.1/build \
&& ./install \
&& docker-php-ext-enable phalcon \
&& rm -rf /home/cphalcon

# PHP config
ADD php.ini    /usr/local/etc/php/php.ini
ADD php-fpm.conf    /usr/local/etc/php-fpm.conf

WORKDIR /opt

RUN  chown -R www-data:www-data /opt

# Write Permission
RUN usermod -u 1000 www-data

# log files
RUN  mkdir -p /usr/local/etc/logs/
RUN  touch /usr/local/etc/logs/fpm-access.log /usr/local/etc/logs/fpm-error.log
RUN  touch /usr/local/etc/logs/php-slow.log

# Clean repository
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "alias ll='ls $LS_OPTIONS -l'" >> ~/.bashrc
RUN echo "alias la='ls $LS_OPTIONS -la'" >> ~/.bashrc

EXPOSE 9000
VOLUME ["/opt"]
CMD ["php-fpm"]