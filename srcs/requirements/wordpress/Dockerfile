FROM wordpress:php7.4-fpm

# Install additional tools if needed
RUN apt-get update && apt-get install -y less net-tools procps curl

RUN sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /usr/local/etc/php-fpm.d/www.conf
# Copy custom PHP configurations
COPY conf /usr/local/etc/php/conf.d

# Use the default CMD, which starts PHP-FPM
CMD ["php-fpm"]
