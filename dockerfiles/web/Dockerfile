FROM nginx:1.15.5-alpine

LABEL MAINTAINER="shiomi.yuji@showcase-tv.com”

# ensure www-data user exists
RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    # 82 is the standard uid/gid for "www-data" in Alpine
    # http://git.alpinelinux.org/cgit/aports/tree/main/apache2/apache2.pre-install?h=v3.3.2
    # http://git.alpinelinux.org/cgit/aports/tree/main/lighttpd/lighttpd.pre-install?h=v3.3.2
    # http://git.alpinelinux.org/cgit/aports/tree/main/nginx-initscripts/nginx-initscripts.pre-install?h=v3.3.2
    && apk add --no-cache \
    tzdata
WORKDIR /var/www

## 環境変数を定義
#
# PROJECT_FOLDER_ADMIN: admin 用ディレクトリ
##
ENV PROJECT_FOLDER_ADMIN application

# config ファイルの転送
COPY ./dockerfiles/web/config/nginx.conf /etc/nginx/
COPY ./dockerfiles/web/config/admin.conf /etc/nginx/conf.d/
COPY ./dockerfiles/web/config/00-log_format.conf /etc/nginx/conf.d/

RUN echo $PROJECT_FOLDER_ADMIN

# ドキュメントルートの作成
RUN mkdir -p $PROJECT_FOLDER_ADMIN

WORKDIR /var/www/$PROJECT_FOLDER_ADMIN

# Set environment value at run container
COPY ./dockerfiles/web/entrypoint.sh /entrypoint.sh
RUN chmod 744 /entrypoint.sh

CMD ["/entrypoint.sh"]

EXPOSE 80
