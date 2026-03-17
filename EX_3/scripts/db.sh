#!/bin/bash
#Installation de Maria DB ...
echo ">>> Installation et configuration de MariaDB"
apt update && apt upgrade -y
apt install mariadb-server -y 

#Autoriser l'écoute sur les interfaces 
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

#Création de la base de donnée, table et utilisation de test
mysql -e "CREATE DATABASE IF NOT EXISTS lab_db;"
mysql -e "CREATE USER IF NOT EXISTS 'ais_user'@'%' IDENTIFIED BY '1234';"
mysql -e "GRANT ALL PRIVILEGES ON lab_db.* TO 'ais_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

#Insertion de donnée de test
mysql -D lab_db -e "CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50));"
mysql -D lab_db -e "INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Nathan'), ('Admin');"

echo ">>> Base de données 'lab_db' configurée avec succès ! :D"
