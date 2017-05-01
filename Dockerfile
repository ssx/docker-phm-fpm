FROM php:fpm

MAINTAINER Scott Wilcox <scott@dor.ky>

# Stop upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# Dependancies for extensions
RUN apt-get update -yqq
RUN apt-get install libcurl3-dev libicu-dev libpng-dev libjpeg-dev libxml2-dev libbz2-dev  -yqq

# Install extensions
RUN docker-php-ext-install curl json intl gd xml zip bz2 opcache

# Installer composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

EXPOSE 9000

CMD ["php-fpm"]