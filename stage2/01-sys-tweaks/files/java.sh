#!/usr/bin/env bash

DB_UP=0
while [  $DB_UP -ne 0 ]; do
   nc -z -v -w 5 127.0.0.1 3306
   let DB_OK=$?
   sleep .5
done
echo DB UP!
java -jar /home/pi/app/*.war &> /home/pi/app/logs/app.log