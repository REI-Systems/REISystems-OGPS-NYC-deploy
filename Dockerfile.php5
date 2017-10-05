FROM vutran/docker-nginx-php5-fpm

RUN apt-get update --fix-missing && apt-get -y install php5-intl php5-pgsql && service php5-fpm restart
