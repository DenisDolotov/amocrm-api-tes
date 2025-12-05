FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip

# Install composer from official image
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files to container
COPY . .

# Install PHP dependencies via Composer
RUN composer install --no-interaction --no-progress --prefer-dist

# Expose Railway's default port 3000 and run PHP built-in server
CMD ["php", "-S", "0.0.0.0:3000", "-t", "/var/www/html"]