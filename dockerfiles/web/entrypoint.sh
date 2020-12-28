#!/bin/sh

# ドキュメントルートフォルダ置換
sed -i -e "s/ENV_DOCROOT_FOLDER_ADMIN/$ENV_DOCROOT_FOLDER_ADMIN/g" /etc/nginx/conf.d/admin.conf
sed -i -e "s/ENV_DOCROOT_FOLDER_FRONT/$ENV_DOCROOT_FOLDER_FRONT/g" /etc/nginx/conf.d/front.conf

# サーバネーム置換
sed -i -e "s/ENV_SERVER_NAME_ADMIN/$ENV_SERVER_NAME_ADMIN/g" /etc/nginx/conf.d/admin.conf
sed -i -e "s/ENV_SERVER_NAME_FRONT/$ENV_SERVER_NAME_FRONT/g" /etc/nginx/conf.d/front.conf

# PHP-fpm ホスト置換
sed -i -e "s/ENV_PHP_FPM_HOST/$ENV_PHP_FPM_HOST/g" /etc/nginx/conf.d/admin.conf
sed -i -e "s/ENV_PHP_FPM_HOST/$ENV_PHP_FPM_HOST/g" /etc/nginx/conf.d/front.conf

/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
