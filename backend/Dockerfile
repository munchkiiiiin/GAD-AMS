# Use official PHP 8.2 Apache image
FROM php:8.2-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install intl zip mysqli pdo_mysql

# Enable Apache mod_rewrite (required for CodeIgniter 4 routing)
RUN a2enmod rewrite

# Copy composer from the official composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Set permissions for writable directory
RUN chown -R www-data:www-data /var/www/html/writable

# Update Apache configuration to point to the public directory
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80
