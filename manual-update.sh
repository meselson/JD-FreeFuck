#!/bin/bash
## Author:SuperManito
## Version 1.1
## Modified:2021-2-26

## ================== 定 义 项 目 的 安 装 目 录 ================================
## 项目安装目录
BASE="/opt/jd"
################################################################################

## ================== 定 义  d i y 脚 本 同 步 链 接 ============================
## diy 自定义脚本链接
DIYURL="https://gitee.com/SuperManito/JD-FreeFuck/raw/main/sample/diy.sh"
## 此脚本用于执行非 lxk 的第三方脚本
## 默认同步本人项目中的 diy.sh 脚本
## 不建议您直接使用其它人的脚本，因为本项目中的 diy 脚本高度定制
## 您可以使用本项目中的 diy.sh.sample 模板定制一个属于您自己的脚本
## 然后您可以将定制的 diy.sh 脚本放在您自己的项目库中以此来同步
################################################################################

## ================== 更 新 活 动 脚 本 =========================================
## 执行更新命令
bash git_pull.sh
################################################################################

## ================= 一 键 执 行 所 有 活 动 脚 本 ===============================
## 生成一键执行所有活动脚本
## 默认将 "jd、jx、jr" 开头的活动脚本加入其中
rm -rf $BASE/run-all.sh
bash jd.sh | grep -o 'j[drx]_[a-z].*' >$BASE/run-all.sh
sed -i "s#^#bash $BASE/jd.sh &#g" $BASE/run-all.sh
sed -i 's#.js# now#g' $BASE/run-all.sh
sed -i '1i\#!/bin/bash' $BASE/run-all.sh
## 自定义添加脚本
## 例：echo "bash $BASE/jd.sh xxx now" >>$BASE/run-all.sh


## 将挂机活动移至末尾从而最后执行
## 检测是否存在此活动，如若存在就加入其中
## 目前仅有 "疯狂的JOY" 这一个活动
## 模板如下 ：
## cat run-all.sh | grep xxx -wq
## if [ $? -eq 0 ];then
##   sed -i '/xxx/d' $BASE/run-all.sh
##   echo "bash jd.sh xxx now" >>$BASE/run-all.sh
## fi
cat run-all.sh | grep jd_crazy_joy_coin -wq
if [ $? -eq 0 ]; then
  sed -i '/jd_crazy_joy_coin/d' $BASE/run-all.sh
  echo "bash $BASE/jd.sh jd_crazy_joy_coin now" >>$BASE/run-all.sh
fi

## 去除不想加入到此脚本中的活动
## 例：sed -i '/xxx/d' $BASE/run-all.sh
sed -i '/jd_delCoupon/d' $BASE/run-all.sh   ## 不执行 "京东家庭号" 任务
sed -i '/jd_family/d' $BASE/run-all.sh      ## 不执行 "删除优惠券" 任务


## 去除脚本中的空行
sed -i '/^\s*$/d' $BASE/run-all.sh
################################################################################

## ================= 同 步 d i y 脚 本 功 能 ====================================
## 自动更新 Diy 脚本（默认禁用此功能，请手动启用）
function DiyUpdate() {
  echo -e "\033[37m开始同步diy.sh脚本... \033[0m"
  echo -e ''
  wget -q $DIYURL -O $BASE/config/diy.sh
  echo -e "\033[37mdiy.sh脚本同步完成... \033[0m"
  echo -e ''
}
#DiyUpdate    ## 将 " #DiyUpdate " 取消注释修改为 " DiyUpdate " 即代表启用此功能
################################################################################
