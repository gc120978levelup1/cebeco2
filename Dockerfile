FROM php:8.4-apache
RUN apt update
RUN apt install -y libzip-dev libpq-dev zip
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo pdo_pgsql
# RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
COPY 000-default.conf /etc/apache2/sites-enabled/
WORKDIR /var/www/html
COPY . .
RUN a2enmod rewrite
RUN apachectl restart
RUN chown -R root:root /var/www/html
RUN chmod -R 777 /var/www/html
RUN php artisan key:generate
RUN php artisan storage:link
RUN php artisan migrate