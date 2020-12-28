FROM docker_private_registry_path/nginx-base:1.15.5-alpine

MAINTAINER syimin.server@gmail.com

WORKDIR /var/www

## 環境変数を定義
#
# PROJECT_FOLDER_ADMIN: admin 用ディレクトリ
##

ENV PROJECT_FOLDER_ADMIN application

# config ファイルの転送
COPY ./dockerfiles/web/config/nginx.conf /etc/nginx/
COPY ./dockerfiles/web/config/admin.conf /etc/nginx/conf.d/
COPY ./dockerfiles/web/config/front.conf /etc/nginx/conf.d/
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
