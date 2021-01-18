#!/bin/bash
#Author:SuperManito
#Update Date:2021-1-19
#Project Name:《京东薅羊毛》一键部署脚本 For Linux，通过参与京东商城的各种活动白嫖京豆
#适用系统: Ubuntu 16.04 ~ 20.10

#将Cookie部分内容填入”双引号“内：（适用于手动搭建）
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'

#当前用户判定：
JudgeUser() {
if [ $UID -ne 0 ]; then
  echo -e '\033[31m ------------ Permission no enough, please use user ROOT! ------------ \033[0m'
  return
fi
}

#网络环境判定：
JudgeNetwork() {
ping -c 1 www.baidu.com >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo -e "\033[31m ----- Network connection error.Please check the network environment and try again later! ----- \033[0m"
  return
fi
}

#环境部署：
EnvDeploy() {
VERSION=`lsb_release -c --short`
VERSION_NUMBER=``
echo -e '\033[37m+---------------------------------------------------+ \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m|   =============================================   | \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m|   欢迎使用《京东薅羊毛》一键部署脚本 For Linux    | \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m|   =============================================   | \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m+---------------------------------------------------+ \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m           提供以下四种国内更新源可供选择： \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m*    1) 阿里源 \033[0m'
echo -e ''
echo -e '\033[37m*    2) 网易源 \033[0m'
echo -e ''
echo -e '\033[37m*    3) 清华源 \033[0m'
echo -e ''
echo -e '\033[37m*    4) 中科大源 \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e "\033[37m           当前系统时间  `date +%Y-%m-%d` `date +%H:%M` \033[0m"
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
CHOICE=`echo -e '\033[32m请输入你想使用的国内更新源[1~4]： \033[0m'`
read -p "$CHOICE" INPUT
case $INPUT in
1)
  SOURCE="mirrors.aliyun.com"
  ;;
2)
  SOURCE="mirrors.163.com"
  ;;
3)
  SOURCE="mirrors.tuna.tsinghua.edu.cn"
  ;;
4)
  SOURCE="mirrors.ustc.edu.cn"
  ;;
*)
  SOURCE="mirrors.aliyun.com"
  echo -e ''
  echo -e '\033[33m----------输入错误，更新源将默认使用阿里源---------- \033[0m'
  sleep 3s
  ;;
esac
cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
sleep 2s
sed -i '1,$d' /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $VERSION main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $VERSION main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
apt-get update
apt-get install -y git wget curl perl moreutils
if [ $VERSION_NUMBER -eq 20 ];then
  apt-get install -y nodejs npm
else
  curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
  sed -i "1c deb https://mirrors.ustc.edu.cn/nodesource/deb/node_14.x stretch main" >> /etc/apt/sources.list.d/nodesource.list
  sed -i "2c deb-src https://mirrors.ustc.edu.cn/nodesource/deb/node_14.x stretch main" >> /etc/apt/sources.list.d/nodesource.list
  sed -i "3c deb https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_14.x/ bionic main" >> /etc/apt/sources.list.d/nodesource.list
  sed -i "4c deb-src https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_14.x/ bionic main" >> /etc/apt/sources.list.d/nodesource.list
  apt-get update
  apt-get install -y nodejs npm
fi
apt-get dist-upgrade -y
apt-get autoremove
}

#项目部署：
ScriptInstall() {
git clone -b v3 https://gitee.com/evine/jd-base /home/myid/jd
cd /home/myid/jd
mkdir config
cp sample/config.sh.sample config/config.sh && cp sample/computer.list.sample config/crontab.list
bash git_pull.sh
cd /home/myid/jd/scripts
npm install || npm install --registry=https://registry.npm.taobao.org
cd /home/myid/jd
}

#更改配置文件：
CookieConfig() {
sed -i "27c Cookie1=$COOKIE1" config/config.sh
sed -i "28c Cookie2=$COOKIE2" config/config.sh
sed -i "29c Cookie3=$COOKIE3" config/config.sh
sed -i "30c Cookie4=$COOKIE4" config/config.sh
sed -i "31c Cookie5=$COOKIE5" config/config.sh
sed -i "32c Cookie6=$COOKIE6" config/config.sh
}

#编写一键执行脚本：
RunAll() {
touch /home/myid/jd/run-all.sh
bash jd.sh | grep _ >>/home/myid/jd/run-all.sh
sed -i '1d' /home/myid/jd/run-all.sh
sed -i 's/^/bash jd.sh &/g' /home/myid/jd/run-all.sh
sed -i 's/$/& now/g' /home/myid/jd/run-all.sh
sed -i '1i\#!/bin/bash' /home/myid/jd/run-all.sh
}

#编写一键更新脚本：
ManualUpdate() {
touch /home/myid/jd/manual-update.sh
cat >/home/myid/jd/manual-update.sh <<EOF
#!/bin/bash
bash git_pull.sh
rm -rf run-all.sh
touch run-all.sh
bash jd.sh | grep _ >> run-all.sh
sed -i '1d' run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/$/& now/g' run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
EOF
}

#结束语：
Tips() {
echo -e "\033[32m ------------------- 环境部署完成，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
echo -e "\033[32m +=================================================================================================+ \033[0m"
echo -e "\033[32m | 注意：该项目主运行目录为/home/myid/jd                                                           | \033[0m"
echo -e "\033[32m | 注意：为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                      | \033[0m"
echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z 跳过继续执行剩余活动脚本        | \033[0m"
echo -e "\033[32m | 注意：run-all.sh为执行所有活动脚本，仍可通过原作者 bash jd.sh 命令查看教程并执行特定活动脚本    | \033[0m"
echo -e "\033[32m | 注意：由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本        | \033[0m"
echo -e "\033[32m | 注意：如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可     | \033[0m"
echo -e "\033[32m | 注意：之前填入的Cookie部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新  | \033[0m"
echo -e "\033[32m | 定义：run-all.sh 为本人编写的一键执行所有活动脚本，manual-update.sh 为本人编写的一键更新脚本    | \033[0m"
echo -e "\033[32m +=================================================================================================+ \033[0m"
echo -e "\033[32m -------------------- 更多帮助请访问 https://github.com/SuperManito/JD-FreeFuck -------------------- \033[0m"
}

JudgeUser
JudgeNetwork
EnvDeploy
ScriptInstall
CookieConfig
RunAll
ManualUpdate
Tips
