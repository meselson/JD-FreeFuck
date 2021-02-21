#!/bin/bash
## Author:SuperManito
## Date:2021-2-21

## 通过添加SSH私钥与公钥解决访问lxk/jd_scripts私有库的权限问题
rm -rf ~/.ssh/id_rsa
wget -P ~/.ssh https://gitee.com/SuperManito/JD-FreeFuck/raw/main/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
## 删除旧的文件
rm -rf scripts
rm -rf git_pull.sh
rm -rf sample/config.sh.sample
## 替换更新文件
wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/git_pull.sh
## 替换配置文件模板
wget -P sample https://gitee.com/SuperManito/JD-FreeFuck/raw/main/config.sh.sample
## 创建配置文件
cp sample/config.sh.sample config/config.sh
cp sample/computer.list.sample config/crontab.list
## 拉取项目文件
bash git_pull.sh
## 更正定时任务
sed -i "s#/home/myid/jd/jd.sh#jd.sh#g" config/crontab.list
