#!/bin/bash
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
