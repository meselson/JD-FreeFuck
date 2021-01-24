#!/bin/bash
#Author:SuperManito
ls /etc | grep redhat-release -qw
if [ $? -eq 0 ];then
    yum -y install net-tools
else
    apt -y install net-tools
fi
IP=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6 | awk '{print $2}' | tr -d "addr:"`
systemctl disable --now firewalld
cd /home/myid/jd
cp sample/auth.json config/auth.json
cd panel
npm install || npm install --registry=https://registry.npm.taobao.org
npm install -g pm2
pm2 start server.js
echo -e "\033[32m 本机访问   http://127.0.0.1:5678 \033[0m"
echo -e "\033[32m 局域网访问 http://$IP:5678 \033[0m"
echo -e "\033[32m 初始用户名：admin，初始密码：adminadmin \033[0m"
echo -e "\033[32m 启动命令： pm2 start server.js \033[0m"
