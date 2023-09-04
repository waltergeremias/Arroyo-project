FROM ubuntu:18.04
USER root
# Install dependencies
RUN apt-get update && \
 apt-get -y install apache2

# Install apache and write hello world message
RUN echo 'Hello World!' > /var/www/html/index.html

# Configure apache
RUN echo '. /etc/apache2/envvars' > /root/apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/apache.sh && \
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/apache.sh

RUN chmod 755 /root/apache.sh

EXPOSE 80

CMD /root/apache.sh