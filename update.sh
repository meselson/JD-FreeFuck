#!/bin/bash
## Author:SuperManito
## Date:2021-2-8
## 更新说明：1. 修复一键脚本关于“疯狂的JOY”挂机活动重复的问题
##          2. 修复了定时目录不正确的问题
##          3. 删除了不该在一键脚本运行的任务

## 安装目录
BASE="/opt/jd"

## 修复定时配置文件的目录问题
sed -i "s#/home/myid/jd#$BASE#g" $BASE/config/crontab.list
## 一键更新脚本
rm -rf $BASE/manual-update.sh
touch $BASE/manual-update.sh
cat >$BASE/manual-update.sh <<\EOF
#!/bin/bash
## 项目安装目录
BASE="/opt/jd"

## 执行更新命令
bash git_pull.sh
## 重新生成一键执行所有活动脚本
rm -rf run-all.sh
touch run-all.sh
bash jd.sh | grep -o 'jd_[a-z].*' >run-all.sh
bash jd.sh | grep -o 'jx_[a-z].*' >>run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/.js/ now/g' run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
sed -i "s/bash jd.sh jd_delCoupon now//g" run-all.sh  #不执行京东家庭号任务
sed -i "s/bash jd.sh jd_family now//g" run-all.sh     #不执行删除优惠券任务
cat run-all.sh | grep jd_crazy_joy_coin -wq
if [ $? -eq 0 ];then
  sed -i "s/bash jd.sh jd_crazy_joy_coin now//g" run-all.sh
  echo "bash jd.sh jd_crazy_joy_coin now" >>run-all.sh
fi
sed -i '/^\s*$/d' run-all.sh
## 配置定时任务
sed -i "s#/home/myid/jd#$BASE#g" $BASE/config/crontab.list
EOF

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
