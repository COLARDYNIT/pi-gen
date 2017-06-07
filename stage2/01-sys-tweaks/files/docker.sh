#!/usr/bin/env bash

echo starting docker
echo making sure no duplicate containers are running
docker rm -f $(docker ps -a -q)
NAME="database"
docker run --name=$NAME --restart=always --net=host -p 3306:3306 -v /home/pi/app/mysql:/var/lib/mysql -e MYSQL_USER=root -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=fullstackdev_2017B -d mitchese/rpi3-mariadb & PID=$!
echo started docker
wait $PID
sudo docker exec -i $NAME /bin/bash < dbsetup.sh
echo starting app
sudo java -jar /home/pi/app/*.war &> /var/logs/fullstackdev_2017B.log
echo started app
