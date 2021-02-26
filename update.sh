#!/bin/bash
## Author:SuperManito
## Date:2021-2-26


## 项目安装目录
BASE="/opt/jd"

wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/sample/computer.list.sample -O $BASE/sample/computer.list.sample
rm -rf $BASE/config/crontab.list
cp $BASE/sample/computer.list.sample $BASE/config/crontab.list
sed -i "s#BASE#$BASE#g" $BASE/config/crontab.list
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
