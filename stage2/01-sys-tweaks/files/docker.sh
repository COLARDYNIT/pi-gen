#!/usr/bin/env bash

sleep 2m
echo starting docker
echo making sure no duplicate containers are running
docker rm -f $(docker ps -a -q)
docker run --restart=always --net=host -p 3306:3306 -v /home/pi/app/mysql:/var/lib/mysql -e MYSQL_USER=root -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_DATABASE=${APP_NAME} -d mitchese/rpi3-mariadb
echo started docker
echo starting app
java -jar /home/pi/app/*.war
echo started app
