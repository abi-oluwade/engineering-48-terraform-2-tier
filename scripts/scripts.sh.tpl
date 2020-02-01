#!/bin/bash

cd /home/ubuntu/app
export DB_HOST=mongodb://${var.db-instance-private-ip}:27017/posts
node seeds/seed.js
sudo npm install
sudo npm start
