#!/bin/bash
## Author:SuperManito
## Date:2021-2-21
## 更新说明：解决了lxk/jd_scripts私有库的权限问题，从而可以正常更新活动脚本


## 安装目录
BASE="/opt/jd"

## 安装SSH软件包
ls /etc | grep redhat-release -qw
if [ $? -eq 0 ]; then
  yum install -y openssh-server >/dev/null 2>&1
else
  apt install -y openssh-server
fi

## 配置SSH服务
service ssh enable >/dev/null 2>&1
service ssh start >/dev/null 2>&1
echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
service ssh restart >/dev/null 2>&1
## 配置SSH密钥文件夹
ls ~ | grep .ssh -rwq
if [ $? -eq 0 ];then
  ## 检测当前用户是否存在私钥
  ls ~/.ssh | grep id_rsa.bak -wq
  if [ $? -eq 0 ];then
    echo -e "\033[31m检测到已备份的私钥，跳过备份操作...... \033[0m"
    sleep 2s
  else
    mv ~/.ssh/id_rsa ~/.ssh/id_rsa.bak >/dev/null 2>&1
    rm -rf ~/.ssh/id_rsa
  fi
  ## 检测当前用户是否存在公钥wq
  ls ~/.ssh | grep id_rsa.pub.bak -wq
  if [ $? -eq 0 ];then
    echo -e "\033[31m检测到已备份的公钥，跳过备份操作...... \033[0m"
    sleep 2s
  else
    mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.bak >/dev/null 2>&1
    rm -rf ~/.ssh/id_rsa.pub
  fi
else
  mkdir -p ~/.ssh 
fi

## 通过添加SSH私钥与公钥解决访问lxk/jd_scripts私有库的权限问题
wget -P ~/.ssh https://gitee.com/SuperManito/JD-FreeFuck/raw/main/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

## 获取新的更新文件
rm -rf $BASE/git_pull.sh
wget -P $BASE https://gitee.com/SuperManito/JD-FreeFuck/raw/main/git_pull.sh

## 拉取活动脚本
bash $BASE/git_pull.sh

echo -e "\033[32m +------------------------ 更 新 成 功 ------------------------+ \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m | 特别提示：后续使用遇到问题请访问本人项目页寻求帮助          | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m |           我不是原项目的开发者，所有活动问题与我无关        | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m |           但我会维护我的两个原创一键脚本，请持续关注此项目  | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m | 项目网址：https://github.com/SuperManito/JD-FreeFuck        | \033[0m"
echo -e "\033[32m |           https://gitee.com/SuperManito/JD-FreeFuck         | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m +-------------------------------------------------------------+ \033[0m"
