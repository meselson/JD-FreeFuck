#!/bin/bash
## Author:SuperManito
## Date:2021-2-22
## 更新说明：修复了Crontab定时配置错误的问题

docker exec -it jd rm -rf manual-update.sh
docker exec -it jd wget https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/manual-update.sh
docker exec -it jd bash manual-update.sh
docker exec -it jd sed -i "s#/home/myid/jd/##g" config/crontab.list

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
