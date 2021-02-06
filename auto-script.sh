#!/bin/bash
## Author:SuperManito
## Modified:2021-2-7

## 一键更新脚本：
function AutoScript() {
  touch manual-update.sh
  cat >manual-update.sh <<EOF
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
  echo -e '\033[32m请将此文件移动到项目所在目录，执行此一键更新脚本后会自动生成一键执行脚本。 \033[0m'
}
AutoScript
