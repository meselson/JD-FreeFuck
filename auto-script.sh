#!/bin/bash
## Author:SuperManito
## Modified:2021-2-6

## 安装目录
BASE="/opt/jd"

## 一键脚本：
function AutoScript() {
  ## 编写一键执行所有活动脚本：
  touch $BASE/run-all.sh
  bash $BASE/jd.sh | grep -o 'jd_[a-z].*' >$BASE/run-all.sh
  bash $BASE/jd.sh | grep -o 'jx_[a-z].*' >>$BASE/run-all.sh
  sed -i 's/^/bash jd.sh &/g' $BASE/run-all.sh
  sed -i 's/.js/ now/g' $BASE/run-all.sh
  sed -i '1i\#!/bin/bash' $BASE/run-all.sh
  cat $BASE/run-all.sh | grep jd_crazy_joy_coin -wq
  if [ $? -eq 0 ]; then
    sed -i "s/bash jd.sh jd_crazy_joy_coin now//g" $BASE/run-all.sh
    sed -i '/^\s*$/d' $BASE/run-all.sh
    echo "bash jd.sh jd_crazy_joy_coin now" >>$BASE/run-all.sh
  fi
  ## 编写一键更新脚本：
  touch $BASE/manual-update.sh
  cat >$BASE/manual-update.sh <<EOF
#!/bin/bash
bash git_pull.sh
rm -rf run-all.sh
touch run-all.sh
bash jd.sh | grep -o 'jd_[a-z].*' >run-all.sh
bash jd.sh | grep -o 'jx_[a-z].*' >>run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/.js/ now/g' run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
cat run-all.sh | grep jd_crazy_joy_coin -wq
if [ $? -eq 0 ];then
  sed -i "s/bash jd.sh jd_crazy_joy_coin now//g" run-all.sh
  sed -i '/^\s*$/d' run-all.sh
  echo "bash jd.sh jd_crazy_joy_coin now" >>run-all.sh
fi
EOF
}
AutoScript
