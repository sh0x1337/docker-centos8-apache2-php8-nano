FROM centos:centos8

MAINTAINER "sh0x1337" <sh0x1337@protonmail.com>

ENV container docker

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

# normal updates
RUN yum -y update

# enable php 8.0
RUN dnf -y install dnf-utils
RUN dnf -y module install php:remi-8.0
RUN dnf update

# nano
RUN yum -y install nano

# git
RUN yum -y install git

# php && httpd
RUN yum -y install mod_php php-opcache php-cli php-common php-gd php-intl php-mbstring php-mcrypt php-mysql php-pdo php-pear php-soap php-xml php-xmlrpc php-zip httpd

# pagespeed
RUN curl -O https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm
RUN dnf -y install at
RUN rpm -U mod-pagespeed-stable_current_x86_64.rpm
RUN yum clean all
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir=bin --filename=composer \
 && php -r "unlink('composer-setup.php');" \
 && rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# we want some config changes
COPY config/php_settings.ini /etc/php.d/
COPY config/v-host.conf /etc/httpd/conf.d/

# create webserver-default directory
RUN mkdir -p /var/www/page/public

EXPOSE 80

RUN dnf -y install crontabs

RUN systemctl enable httpd
RUN systemctl enable crond

CMD ["/usr/sbin/init"]