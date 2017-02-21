FROM tomcat:8.0-jre8

MAINTAINER taoanton@gmail.com

#RUN echo "alias la='ls -lA'" >> /etc/bash.bashrc
#RUN echo "alias ll='ls -alF" >> /etc/bash.bashrc

RUN rm -rf /usr/local/tomcat/webapps/ROOT/*
ADD deployWar.sh /usr/local/tomcat/deployWar.sh
RUN chmod +x /usr/local/tomcat/deployWar.sh
