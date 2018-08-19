#!/bin/bash
USERNAME=ubuntu
SERVER=`cat instance_public_ip.txt`

ssh -i mykey -o StrictHostKeyChecking=no $USERNAME@$SERVER
