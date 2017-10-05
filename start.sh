#!/bin/bash

if [ -e /etc/init.d/nginx ]
then
    service nginx start
fi

if [ -e /etc/init.d/php7.0-fpm ]
then
    service php7.0-fpm start
fi

/usr/sbin/sshd -D
