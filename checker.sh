#!/bin/bash
USERNAME=ubuntu
SERVER=`cat instance_public_ip.txt`
CORRECT_VERSION='1.0.6'
OKO=$(ssh -i mykey -o StrictHostKeyChecking=no $USERNAME@$SERVER grep "1.0.6" /usr/share/nginx/html/version.txt)


echo "Checking the version on the remote server..."
if [ $CORRECT_VERSION = $OKO ] ; then
	echo "Version is correct - $CORRECT_VERSION"
else
	echo "Version is not correct"
fi


echo \
############################################

echo "Checking if Nginx process is running..."
ssh -i mykey $USERNAME@$SERVER ps aux | grep -v grep | grep "nginx" > /dev/null
if [ $? -eq 0 ]
then
    echo "Nginx process is running."
else
    echo "Nginx process is not running."
		echo "Starting the process."
		echo "sudo service nginx start"
		ssh -i mykey $USERNAME@$SERVER sudo service nginx start
fi
