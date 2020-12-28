#!/bin/sh

composer install \
&& chown -R www-data:www-data ./public \
&& chmod -R 777 ./storage \
&& chmod -R 777 ./bootstrap/cache/ \
&& php-fpm