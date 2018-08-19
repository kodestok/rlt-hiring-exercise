#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done


# install nginx
apt-get update
apt-get install nginx -y
# start nginx
service nginx start

# mkdir -p /usr/share/nginx/html/
echo "1.0.6" > /usr/share/nginx/html/version.txt

# install Docker
sudo apt-get update

sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual -y

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce -y

# run MySQL Server in the Docker container
sudo docker run --name rootleveltech-mysqlserver -e MYSQL_ROOT_PASSWORD=rootleveltechpassword -p 3306:3306 -d mysql/mysql-server
