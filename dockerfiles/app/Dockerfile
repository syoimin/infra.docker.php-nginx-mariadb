FROM node:14.15.1-alpine

LABEL MAINTAINER="syoimin.server@gmail.com"

WORKDIR /var
COPY ./public ./public
COPY ./resources ./resources
COPY ./webpack.mix.js ./webpack.mix.js
COPY ./webpack.config.js ./webpack.config.js
COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json
RUN rm -rf ./node_modules \
  && npm install \
  && npm run production

FROM php:7.4.2-fpm-alpine

LABEL MAINTAINER="shoimin.server@gmail.com"

WORKDIR /tmp
ARG pip_installer="https://bootstrap.pypa.io/get-pip.py"
ARG awscli_version="1.16.300"
# Laravel 必須ライブラリのインストール
RUN apk add --no-cache \
  unzip \
  libxml2-dev \
  mysql-client \
  tzdata \
  oniguruma-dev \
  bash \
  python \
  curl \
  groff \
  jq \
  less \
  libpng-dev \
  # php 拡張パッケージインストール
  && /usr/local/bin/docker-php-ext-install \
  mbstring \
  pdo_mysql \
  xml \
  exif \
  gd \
  # exif のコンパイルオプション設定
  && docker-php-ext-enable exif \
  # composer のインストール
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer
# Install awscli
RUN curl ${pip_installer} | python && \
  pip install awscli==${awscli_version}
WORKDIR /var/www

## 環境変数を定義
#
# PROJECT_FOLDER_ADMIN: admin 用ディレクトリ
##
ENV PROJECT_FOLDER_ADMIN application

# composer root 許可
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

# ドキュメントルートの作成
RUN mkdir -p $PROJECT_FOLDER_ADMIN

WORKDIR /var/www/$PROJECT_FOLDER_ADMIN

# ドキュメントルートの転送
COPY ./ ./

# compoer install
RUN composer install

# node コンテナから public フォルダの転送
COPY --from=0 /var/public  ./public

# Set environment value at run container
COPY ./dockerfiles/app/entrypoint.sh /entrypoint.sh

# 所有者・パーミッションの変更・環境変数のリネーム
RUN cp -pr ./.env.example ./.env \
  && chown -R www-data:www-data ./public \
  && chmod -R 777 ./storage \
  && chmod -R 777 ./bootstrap/cache/ \
  && chmod 744 /entrypoint.sh

VOLUME /var/www/application

CMD ["/entrypoint.sh"]

EXPOSE 9000
