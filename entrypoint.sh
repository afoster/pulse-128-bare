#!/bin/bash
# 
# php artisan websockets:serve &
php artisan queue:work &
php-fpm