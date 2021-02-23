#!/bin/bash
## Author:SuperManito
## Date:2021-2-23
## 更新说明：修复了Crontab定时配置错误的问题

## 编写新的一键更新脚本
rm -rf manual-update.sh
touch manual-update.sh
cat >manual-update.sh <<\EOF
#!/bin/bash
## Author:SuperManito
## Modified:2021-2-22

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
sed -i "s#/home/myid/jd/##g" config/crontab.list
sed -i "s#jd.sh#jd#g" config/crontab.list
sed -i "s/git_pull/manual-update/g" config/crontab.list
EOF
## 修改非活动脚本的定时配置
sed -i "s#/home/myid/jd/##g" config/crontab.list
## 更新活动脚本
bash manual-update.sh

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
