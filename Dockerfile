# Build the frontend
FROM node:lts-bullseye as frontend-build
WORKDIR /app
COPY . .

RUN npm install
RUN npm run build

# Build the backend
FROM php:8.2-fpm-bullseye
WORKDIR /app
COPY . .
COPY docker/php-ini-overrides.ini /usr/local/etc/php/conf.d/99-docker.ini
COPY --from=frontend-build /app/public/build /app/public/build

# PHP & Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN composer --version && php -v
RUN apt update && apt install -y --no-install-recommends git unzip wget libmagickwand-dev libzip-dev less jpegoptim optipng pngquant gifsicle ffmpeg libpng-dev build-essential
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install mysqli pdo pdo_mysql zip gd exif opcache \
    && docker-php-ext-enable mysqli zip gd exif

# Imagick
RUN pecl install -o -f imagick && docker-php-ext-enable imagick
RUN pecl install -o -f redis && docker-php-ext-enable redis

RUN composer install --no-dev --optimize-autoloader

EXPOSE 9000

# Run both the websocket server and the php-fpm server
CMD ./entrypoint.sh