#!/bin/env bash
## Author:SuperManito
## Date:2021-3-5


## 代理链接
Proxy_URL=https://ghproxy.com/
## 一键更新脚本地址
Git_Pull_URL=https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/source/git_pull.sh
## 配置文件模板地址
Config_URL=https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/source/sample/config.sh.sample
## 定时配置模板
Crontab_URL=https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/source/sample/computer.list.sample

## 删除旧的脚本
rm -rf manual-update.sh
## 更新一键脚本
wget $Proxy_URL$Git_Pull_URL -O git_pull.sh
## 更新配置文件模板
wget $Proxy_URL$Config_URL -O sample/config.sh.sample
## 更新定时配置模板
wget $Proxy_URL$Crontab_URL -O sample/computer.list.sample
## 备份当前配置文件
mv config/config.sh config/config.sh.bak
echo -e ''
echo -e "已备份当前使用配置文件至 config/config.sh.bak ... "
echo -e ''
## 替换新的配置文件
cp -f sample/config.sh.sample config/config.sh
## 替换新的定时配置文件
cp -f /sample/computer.list.sample /config/crontab.list
## 更新活动脚本
bash git_pull.sh


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
