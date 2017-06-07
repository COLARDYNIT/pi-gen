#!/usr/bin/env bash
echo starting docker
echo making sure no duplicate containers are running
docker rm -f $(docker ps -a -q)
NAME="database"
docker run --name=$NAME --restart=always --net=host -p 3306:3306 -v /home/pi/app/mysql:/var/lib/mysql -e MYSQL_USER=root -e MYSQL_ROOT_PASSWORD=root  -d mitchese/rpi3-mariadb & PID=$!
echo started docker
sudo docker exec -i $NAME /bin/bash < dbsetup.sh

