#!/bin/env bash
## Author:SuperManito
## Date:2021-3-9

## 项目安装目录
BASE=/opt/jd
## 一键更新脚本地址
Git_Pull_URL=https://gitee.com/SuperManito/JD-FreeFuck/raw/source/git_pull.sh

## 删除旧的脚本
rm -rf $BASE/manual-update.sh
## 更新一键脚本
wget $Git_Pull_URL -O git_pull.sh
## 定义全局变量
echo "export JD_DIR=$BASE" >>/etc/profile
source /etc/profile
## 创建软链接
ln -sf $BASE/jd.sh /usr/local/bin/jd
ln -sf $BASE/git_pull.sh /usr/local/bin/git_pull
ln -sf $BASE/rm_log.sh /usr/local/bin/rm_log
ln -sf $BASE/export_sharecodes.sh /usr/local/bin/export_sharecodes
ln -sf /opt/jd/run_all.sh /usr/local/bin/run_all
## 更新活动脚本
bash $BASE/git_pull.sh

echo -e "\033[32m +------------------------ 更 新 成 功 ------------------------+ \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m | 特别提示：后续使用遇到问题请访问本人项目页寻求帮助          | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m |           我不是活动脚本的开发者，所有活动问题与我无关      | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m | 项目地址：https://github.com/SuperManito/JD-FreeFuck        | \033[0m"
echo -e "\033[32m |           https://gitee.com/SuperManito/JD-FreeFuck         | \033[0m"
echo -e "\033[32m |                                                             | \033[0m"
echo -e "\033[32m +-------------------------------------------------------------+ \033[0m"
