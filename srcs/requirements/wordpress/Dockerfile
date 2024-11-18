FROM wordpress:php7.4-fpm

RUN apt-get update && apt-get install -y less

COPY conf /usr/local/etc/php/conf.d

CMD ["php-fpm"]