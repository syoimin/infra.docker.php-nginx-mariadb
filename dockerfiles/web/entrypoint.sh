#!/bin/sh

# ドキュメントルートフォルダ置換
sed -i -e "s/ENV_DOCROOT_FOLDER_ADMIN/$ENV_DOCROOT_FOLDER_ADMIN/g" /etc/nginx/conf.d/admin.conf

# サーバネーム置換
sed -i -e "s/ENV_SERVER_NAME_ADMIN/$ENV_SERVER_NAME_ADMIN/g" /etc/nginx/conf.d/admin.conf

# PHP-fpm ホスト置換
sed -i -e "s/ENV_PHP_FPM_HOST/$ENV_PHP_FPM_HOST/g" /etc/nginx/conf.d/admin.conf

/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
