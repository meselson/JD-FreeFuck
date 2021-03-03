#!/bin/env bash
## Author:SuperManito
## Date:2021-3-4

## 项目安装目录
BASE="/opt/jd"

## 代理链接
Proxy_URL=https://ghproxy.com/
## 一键更新脚本地址
Git_Pull_URL=https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/source/git_pull.sh
## 配置文件模板地址
Config_URL=https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/source/sample/config.sh.sample


## 删除旧的脚本
rm -rf $BASE/manual-update.sh
## 更新一键脚本
wget $Proxy_URL$Git_Pull_URL -O $BASE/git_pull.sh
## 更新配置文件模板
wget $Proxy_URL$Config_URL -O $BASE/sample/config.sh.sample
## 备份当前配置文件
mv $BASE/config/config.sh $BASE/config/config.sh.bak
echo -e "已备份当前使用配置文件至 $BASE/config/config.sh.bak ... "
## 替换新的配置文件
cp -f $BASE/sample/config.sh.sample $BASE/config/config.sh

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
