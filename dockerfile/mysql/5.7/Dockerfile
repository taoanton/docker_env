FROM mysql:5.7

MAINTAINER taoanton@gmail.com

# Write Permission
RUN usermod -u 1000 mysql && chown mysql.mysql /var/run/mysqld/
# RUN usermod -u 1000 mysql 

# ADD run.sh /root/run.sh
# RUN chmod u+x /root/run.sh

# RUN /etc/init.d/mysql start && \
# mysql -e "grant all privileges on *.* to 'root'@'%' identified by '123456';" && \
# mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '123456';" && \
# mysql -u root -p123456 -e "show databases;"

# ENV MYSQL_ROOT_PASSWORD 123456
# ENV MYSQL_USER test
# ENV MYSQL_PASSWORD 123456 


# EXPOSE 3306
# VOLUME ["/opt"]
# CMD ["mysql"]

