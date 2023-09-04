FROM ubuntu:18.04
USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN echo "America/New_York" > /etc/timezone

# Install dependencies
RUN apt-get update && \
 apt-get -y install apache2 git software-properties-common apt-transport-https wget

RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb

RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

RUN apt-get update && \
 apt-get -y install code maven default-jdk postgresql postgresql-contrib dotnet-sdk-7.0 aspnetcore-runtime-7.0

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