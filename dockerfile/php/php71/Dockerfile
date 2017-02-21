FROM php:7.1-fpm

# Add aliyun repository
RUN echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list


# Install modules
RUN apt-get update && apt-get install -y \
        wget \
        vim \
        git \
        unzip \
        g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        libicu-dev \
        unixodbc-dev \
        libxml2-dev \
        libaio-dev \
        libmemcached-dev \
        freetds-dev \
        libssl-dev \
        sudo \
        gcc \
        make \
        re2c \
        libpcre3 \
        libpcre3-dev 

RUN pecl install mongodb \
    && echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongodb.ini \
    && echo "upload_max_filesize = 5M" > /usr/local/etc/php/conf.d/upload.ini \
    && docker-php-ext-install iconv mcrypt mbstring exif zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && pecl install xdebug \
    && pecl install yaf \
    && docker-php-ext-install \
         pdo_mysql \
         mcrypt \
         mysqli \
         soap \
         xmlrpc \
         zip \
         bcmath \
         intl \
         gd \
    && docker-php-ext-enable \
            xdebug \
            yaf \
            bcmath \
            opcache \
    && requirementsToRemove="g++" \
    && apt-get purge --auto-remove -y $requirementsToRemove

# Add custom settings
RUN touch /usr/local/etc/php/conf.d/custom_settings.ini \
    && echo "display_errors = On" >> /usr/local/etc/php/conf.d/custom_settings.ini \
    && echo "expose_php = Off" >> /usr/local/etc/php/conf.d/custom_settings.ini \
    && echo "upload_max_filesize = 128M" >> /usr/local/etc/php/conf.d/custom_settings.ini \
    && echo "post_max_size = 128M" >> /usr/local/etc/php/conf.d/custom_settings.ini \
    && echo "date.timezone = "Asia/Shanghai"" >> /usr/local/etc/php/conf.d/custom_settings.ini \
    # ÓÃÍê°ü¹ÜÀíÆ÷ºó°²ÅÅ´òÉ¨ÎÀÉú¿ÉÒÔÏÔÖøµÄ¼õÉÙ¾µÏñ´óÐ¡
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install swoole
COPY swoole-1.8.9.tgz /home/swoole.tgz
RUN pecl install swoole-2.0.5 && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini 

# install phalcon
# COPY phalcon-v3.0.1.tar.gz /home/phalcon.tar.gz
# RUN cd /home/ && tar -zxf phalcon.tar.gz \
# && cd /home/cphalcon-3.0.1/build \
# && ./install \
# && docker-php-ext-enable phalcon \
# && rm -rf /home/cphalcon

# Install Oracle Instantclient
COPY instantclient-basic-linux.x64-12.1.0.2.0.zip /opt/oracle/
COPY instantclient-sdk-linux.x64-12.1.0.2.0.zip /opt/oracle/
RUN cd /opt/oracle \
    # && wget http://repo.domain.com/pkg/instantclient-basic-linux.x64-12.1.0.2.0.zip \
    # && wget http://download.oracle.com/otn/linux/instantclient/121020/instantclient-basic-linux.x64-12.1.0.2.0.zip \
    # && wget http://repo.domain.com/pkg/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    # && http://download.oracle.com/otn/linux/instantclient/121020/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && unzip /opt/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
    && unzip /opt/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
    && ln -s /opt/oracle/instantclient_12_1/libclntsh.so.12.1 /opt/oracle/instantclient_12_1/libclntsh.so \
    && ln -s /opt/oracle/instantclient_12_1/libclntshcore.so.12.1 /opt/oracle/instantclient_12_1/libclntshcore.so \
    && ln -s /opt/oracle/instantclient_12_1/libocci.so.12.1 /opt/oracle/instantclient_12_1/libocci.so \
    && rm -rf /opt/oracle/*.zip \
    && echo 'instantclient,/opt/oracle/instantclient_12_1/' | pecl install oci8-2.1.1 \
    && docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,/opt/oracle/instantclient_12_1,12.1 \
    && docker-php-ext-install pdo_oci \
    && docker-php-ext-enable oci8

# clone zephir ²¢°²×°
RUN cd /root && \
        git clone https://github.com/phalcon/zephir && \
        cd zephir && \
        # ./install-json && \
        ./install -c

# PHP config
ADD php.ini    /usr/local/etc/php/php.ini
ADD php-fpm.conf    /usr/local/etc/php-fpm.conf

# Composer
ADD composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

WORKDIR /opt

RUN  chown -R www-data:www-data /opt

# Write Permission
RUN usermod -u 1000 www-data

# log files
RUN  mkdir -p /usr/local/etc/logs/
RUN  touch /usr/local/etc/logs/fpm-access.log /usr/local/etc/logs/fpm-error.log
RUN  touch /usr/local/etc/logs/php-slow.log

RUN echo "alias ll='ls $LS_OPTIONS -l'" >> ~/.bashrc
RUN echo "alias la='ls $LS_OPTIONS -la'" >> ~/.bashrc

EXPOSE 9000
VOLUME ["/opt"]
CMD ["php-fpm"]
