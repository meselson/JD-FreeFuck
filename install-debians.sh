#!/bin/bash
#Author:SuperManito
#Update Date:2021-1-22
#Project Name:《京东薅羊毛》一键部署脚本 For Linux，通过参与京东商城的各种活动白嫖京豆
#适用系统: Ubuntu 16.04 ~ 20.10 | Debian 8.0 ~ 10.7 | Kali 2018 ~ 2020.4

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

#更换国内源
SourceChange() {
SYSTEM_NAME=`lsb_release -is`
SYSTEM_VERSION=`lsb_release -cs`
SYSTEM_VERSION_NUMBER=`lsb_release -rs`
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
echo -e '\033[37m           提供以下六种国内更新源可供选择： \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m*    1) 中科大 \033[0m'
echo -e ''
echo -e '\033[37m*    2) 华为云 \033[0m'
echo -e ''
echo -e '\033[37m*    3) 阿里云 \033[0m'
echo -e ''
echo -e '\033[37m*    4) 网易 \033[0m'
echo -e ''
echo -e '\033[37m*    5) 清华大学 \033[0m'
echo -e ''
echo -e '\033[37m*    6) 浙江大学 \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e "\033[37m           当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER \033[0m"
echo -e "\033[37m           当前系统时间  `date +%Y-%m-%d` `date +%H:%M` \033[0m"
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
CHOICE=`echo -e '\033[32m请输入你想使用的国内更新源[1~6]： \033[0m'`
read -p "$CHOICE" INPUT
case $INPUT in
1)
  SOURCE="mirrors.ustc.edu.cn"
  ;;
2)
  SOURCE="mirrors.huaweicloud.com"
  ;;
3)
  SOURCE="mirrors.aliyun.com"
  ;;
4)
  SOURCE="mirrors.163.com"
  ;;
5)
  SOURCE="mirrors.tuna.tsinghua.edu.cn"
  ;;
6)
  SOURCE="mirrors.zju.edu.cn"
  ;;
*)
  SOURCE="mirrors.huaweicloud.com"
  echo -e ''
  echo -e '\033[33m----------输入错误，更新源将默认使用华为源---------- \033[0m'
  sleep 3s
  ;;
esac
cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
sleep 2s
sed -i '1,$d' /etc/apt/sources.list
if [ $SYSTEM_NAME = "Ubuntu" ];then
  echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
elif [ $SYSTEM_NAME = "Debian" ];then
  echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION main contrib non-free" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION-backports main contrib non-free" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION-backports main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://$SOURCE/debian-security $SYSTEM_VERSION/updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/debian-security $SYSTEM_VERSION/updates main contrib non-free" >> /etc/apt/sources.list
elif [ $SYSTEM_NAME = "Kali" ];then
  echo "deb https://$SOURCE/kali $SYSTEM_VERSION main non-free contrib" >> /etc/apt/sources.list
  echo "deb-src https://$SOURCE/kali $SYSTEM_VERSION main non-free contrib" >> /etc/apt/sources.list
fi
apt update
}

#环境搭建：
EnvStructures() {
apt remove -y nodejs npm
apt install -y git wget curl perl moreutils
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
tail /etc/apt/sources.list.d/nodesource.list >> /etc/apt/sources.list.d/nodesource.list
sed -i "1 s#deb.nodesource.com#mirrors.ustc.edu.cn/nodesource/deb#" /etc/apt/sources.list.d/nodesource.list
sed -i "2 s#deb.nodesource.com#mirrors.ustc.edu.cn/nodesource/deb#" /etc/apt/sources.list.d/nodesource.list
sed -i "3 s#deb.nodesource.com/node_14.x#mirrors.tuna.tsinghua.edu.cn/nodesource/deb_14.x/#" /etc/apt/sources.list.d/nodesource.list
sed -i "4 s#deb.nodesource.com/node_14.x#mirrors.tuna.tsinghua.edu.cn/nodesource/deb_14.x/#" /etc/apt/sources.list.d/nodesource.list
apt update
apt install -y nodejs
apt dist-upgrade -y
apt autoremove -y
}

#项目部署：
ProjectDeployment() {
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
bash jd.sh | grep -o 'jd_[a-z].*' > run-all.sh
bash jd.sh | grep -o 'jx_[a-z].*' >> run-all.sh
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
bash jd.sh | grep -o 'jd_[a-z].*' > run-all.sh
bash jd.sh | grep -o 'jx_[a-z].*' >> run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/$/& now/g' run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
EOF
}

#部署结果判定：
JudgeResult() {
cd /home/myid/jd
VERIFICATION=`node -v | cut -c2`
if [ $VERIFICATION -eq "1" ]; then
  echo -e "\033[32m ------------------- 环境部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
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
else
  echo -e "\033[31m -------------- 一键部署失败 -------------- \033[0m"
fi
}

JudgeUser
JudgeNetwork
SourceChange
EnvStructures
ProjectDeployment
CookieConfig
RunAll
ManualUpdate
JudgeResult
