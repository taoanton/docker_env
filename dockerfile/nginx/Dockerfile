FROM nginx:1.11

MAINTAINER taoanton@gmail.com

ADD  nginx.conf      /etc/nginx/nginx.conf
# ADD  sites-enabled/*    /etc/nginx/conf.d/
ADD  deployServer.sh    /opt/deployServer.sh
RUN  chmod +x /opt/deployServer.sh
RUN  mkdir /www && mkdir /www/log && mkdir /www/log/nginx

RUN apt-get update && apt-get install --no-install-recommends -y \
        wget \
        vim \
        git \
        unzip

RUN  chown -R www-data:www-data /www /www/log
RUN  chmod -R 777 /www/log/nginx
RUN  mkdir -p /etc/nginx/logs/
RUN  touch /etc/nginx/logs/default.access.log /etc/nginx/logs/default.error.log
RUN  touch /etc/nginx/logs/laravelpackages.access.log /etc/nginx/logs/laravelpackages.error.log

EXPOSE 80
VOLUME ["/opt"]

# ENTRYPOINT ["/opt/deployServer.sh"]