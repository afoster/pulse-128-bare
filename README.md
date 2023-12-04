This demo repo was created with:

```
composer create-project laravel/laravel pulse-128-bare
```

I copied in the Docker environment:

* `docker-compose.yml`

**App**

* `docker/php-ini-overrides.ini` # Custom php config
* `Dockerfile` # Dockerfile for the app (php-fpm) container
* `entrypoint.sh` # start script for the app container

**Webserver**

* `Dockerfile.webserver` # Dockerfile for the nginx container
* `docker/nginx.conf`

I installed base Laravel deps:

```
docker-compose up
docker-compose exec app composer install
```

The app is now available at http://localhost:9002.

Now Pulse:

```
docker-compose exec app composer require laravel/pulse
docker-compose exec app php artisan migrate
```

Pulse is now available at http://localhost:9002/pulse.