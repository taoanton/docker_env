FROM openresty/openresty:jessie

MAINTAINER taoanton@gmail.com

# Add aliyun repository
# RUN echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list
# RUN echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
# RUN echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list

ADD  nginx.conf      /usr/local/openresty/nginx/conf/nginx.conf

ADD  deployServer.sh    /opt/deployServer.sh
RUN  chmod +x /opt/deployServer.sh
RUN  mkdir /www && mkdir /www/log && mkdir /www/log/nginx && mkdir /usr/local/openresty/nginx/conf/conf.d

RUN apt-get update && apt-get install --no-install-recommends -y \
        wget \
        vim \
        git \
        unzip

RUN apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  chown -R www-data:www-data /www /www/log
RUN  chmod -R 777 /www/log/nginx
RUN  mkdir -p /usr/local/openresty/nginx/logs/
RUN  touch /usr/local/openresty/nginx/logs/default.access.log /usr/local/openresty/nginx/logs/default.error.log
RUN  touch /usr/local/openresty/nginx/logs/laravelpackages.access.log /usr/local/openresty/nginx/logs/laravelpackages.error.log

RUN echo "export PATH=/usr/local/openresty/bin:$PATH" >> ~/.bashrc

EXPOSE 80
VOLUME ["/opt"]

# ENTRYPOINT ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
