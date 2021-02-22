#!/bin/bash
## Author:SuperManito
## Modified:2021-2-22

## 通过添加SSH私钥与公钥解决访问lxk/jd_scripts私有库的权限问题
rm -rf ~/.ssh/id_rsa
wget -P ~/.ssh https://gitee.com/SuperManito/JD-FreeFuck/raw/main/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
## 删除旧的文件
rm -rf scripts
rm -rf git_pull.sh
rm -rf sample/config.sh.sample
## 下载新版更新文件
wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/git_pull.sh
## 下载新版配置文件模板
wget -P sample https://gitee.com/SuperManito/JD-FreeFuck/raw/main/config.sh.sample
## 创建配置文件
rm -rf config.sh
cp -f sample/config.sh.sample config/config.sh
cp -f sample/computer.list.sample config/crontab.list
## 拉取项目文件
bash git_pull.sh
## 更正定时任务
sed -i "s#/home/myid/jd/jd.sh#jd#g" config/crontab.list
sed -i "s#/home/myid/jd/##g" config/crontab.list
## 编写一键更新脚本
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
sed -i "s#/home/myid/jd/jd.sh#jd#g" config/crontab.list
sed -i "s/git_pull/manual-update/g" config/crontab.list
EOF
## 执行更新命令
bash manual-update.sh
