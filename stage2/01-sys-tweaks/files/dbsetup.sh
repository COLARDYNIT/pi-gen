#!/usr/bin/env bash
sudo mysql -u root -proot -e "CREATE USER 'app'@'localhost' IDENTIFIED BY 'apppwd';GRANT ALL ON *.* TO 'app'@'localhost';CREATE DATABASE IF NOT EXISTS fullstackdev_2017B;"