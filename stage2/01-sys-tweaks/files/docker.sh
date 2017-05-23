#!/usr/bin/env bash

sleep 5m
echo starting docker
echo making sure no duplicate containers are running
docker rm -f $(docker ps -a -q)
docker run --restart=always --net=host -p 3306:3306 -v /home/pi/app/mysql:/var/lib/mysql -e MYSQL_USER=root -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_DATABASE=logopihipsterv2 -d mitchese/rpi3-mariadb
echo started docker
echo starting logocontrol
docker run --restart=always -p 8088:8088 -v /home/pi/app/logocontrol:/var/lib/logocontrol colardynit/logocontrolpi
echo started logocontrol