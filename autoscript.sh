#!/bin/bash
## Author:SuperManito
## Modified:2021-2-8

## 一键更新脚本：
function AutoScript() {
  touch manual-update.sh
  cat >manual-update.sh <<\EOF
#!/bin/bash
## 项目安装目录
BASE=""

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
  echo -e '\033[32m请在此文件内容中定义您项目的安装目录，并将此文件移动到项目所在目录。 \033[0m'
  echo -e '\033[32m执行此一键更新脚本后会自动生成一键执行所有活动脚本。 \033[0m'
}
AutoScript
