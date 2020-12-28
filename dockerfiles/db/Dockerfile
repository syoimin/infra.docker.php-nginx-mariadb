#MySQLのバージョンを指定
FROM mariadb:10.2

LABEL MAINTAINER="syoimin.server@gmail.com"

#cnfファイルをdockerにアップ
COPY ./dockerfiles/db/mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
