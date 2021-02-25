#!/bin/bash
## Author:SuperManito
## Modified:2021-2-25


## =========== 定 义 项 目 的 安 装 目 录 ===========
## 项目安装目录
BASE="/opt/jd"
## ================================================


## ====================== 定 义 同 步 的 d i y 脚 本 链 接 =======================
## diy脚本链接
DIYURL="https://gitee.com/SuperManito/JD-FreeFuck/raw/main/sample/diy.sh"

## 默认同步本人项目中的 diy.sh 脚本
## 不建议您使用其它人的脚本，因为本项目中的 diy 脚本高度适配
## 您可以使用本项目中的 diy.sh.sample 模板定制一个属于您自己的脚本
## 然后您可以将定制的 diy.sh 脚本放在您自己项目库的中以此来同步
## =============================================================================

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
sed -i "s#/home/myid/jd#$BASE#g" config/crontab.list
sed -i "s#git_pull#manual-update#g" config/crontab.list

## 自动更新 Diy 脚本（默认禁用此功能，请手动启用）
function DiyUpdate() {
  echo -e "\033[37m开始同步diy.sh脚本... \033[0m"
  echo -e ''
  wget -q $DIYURL -O $BASE/config/diy.sh
  echo -e "\033[37mdiy.sh脚本同步完成... \033[0m"
  echo -e ''
}
## 将下方 " #DiyUpdate " 内容取消注释修改为 " DiyUpdate " 即代表启用此功能
#DiyUpdate
