#!/bin/bash
#Author:SuperManito
systemctl disable --now firewalld
cd /home/myid/jd
cp sample/auth.json config/auth.json
cd panel
npm install || npm install --registry=https://registry.npm.taobao.org
npm install -g pm2
pm2 start server.js
