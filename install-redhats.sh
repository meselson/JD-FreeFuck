#!/bin/bash
#Author:SuperManito
#Update Date:2021-1-23
#Project Name:《京东薅羊毛》一键部署脚本 For Linux，通过参与京东商城的各种活动白嫖京豆
#适用系统: CentOS 7.0 ~ 8.3 | Fedora 28 ~ 33   CentOS如果是最小化安装，请通过SSH方式进入到终端

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
SYSTEM_NAME=`cat /etc/redhat-release | cut -c1-6`
SYSTEM_VERSION_CENTOS=`cat /etc/redhat-release | cut -c22`
echo -e '\033[37m+---------------------------------------------------+ \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m|   =============================================   | \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m|   欢迎使用《京东薅羊毛》一键部署脚本 For Linux    | \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m|   =============================================   | \033[0m'
echo -e '\033[37m|                                                   | \033[0m'
echo -e '\033[37m+---------------------------------------------------+ \033[0m'
sleep 2s
setenforce 0
yum install -y wget
mkdir /etc/yum.repos.d.bak
cp -a /etc/yum.repos.d/* /etc/yum.repos.d.bak
echo -e '\033[32m已备份原有YUM源至/etc/yum.repos.d.bak ...... \033[0m'
sleep 3s
rm -rf /etc/yum.repos.d/*
echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
if [ $SYSTEM_VERSION_CENTOS = "8" ];then
  wget -O /etc/yum.repos.d/CentOS-Linux-AppStream.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/CentOS-Linux-AppStream.repo
  wget -O /etc/yum.repos.d/CentOS-Linux-Base.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/CentOS-Linux-BaseOS.repo
  wget -O /etc/yum.repos.d/CentOS-Linux-Extras.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/CentOS-Linux-Extras.repo
  wget -O /etc/yum.repos.d/CentOS-Linux-PowerTools.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/CentOS-Linux-PowerTools.repo
  wget -O /etc/yum.repos.d/CentOS-Linux-Plus.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/CentOS-Linux-Plus.repo
  yum makecache > /dev/null 2>&1
  yum install -y epel-release
  sed -i 's|^metalink=|#metalink=|g' /etc/yum.repos.d/epel.repo
  sed -i 's|^#baseurl=https\?://download.fedoraproject.org/pub/epel/|baseurl=https://mirrors.ustc.edu.cn/epel/|g' /etc/yum.repos.d/epel.repo
  yum makecache
elif [ $SYSTEM_VERSION_CENTOS = "7" ];then
  wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/CentOS-Base.repo
  yum makecache > /dev/null 2>&1
  yum install -y epel-release
  sed -i 's|^metalink=|#metalink=|g' /etc/yum.repos.d/epel.repo
  sed -i 's|^#baseurl=https\?://download.fedoraproject.org/pub/epel/|baseurl=https://mirrors.ustc.edu.cn/epel/|g' /etc/yum.repos.d/epel.repo
  yum makecache
elif [ $SYSTEM_NAME = "Fedora" ];then
  wget -O /etc/yum.repos.d/fedora.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/fedora.repo
  wget -O /etc/yum.repos.d/fedora-modular.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/fedora-modular.repo
  wget -O /etc/yum.repos.d/fedora-updates.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/fedora-updates.repo
  wget -O /etc/yum.repos.d/fedora-updates-modular.repo https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/RedHats%20Sources/fedora-updates-modular.repo
  yum makecache
fi
}

#环境搭建：
EnvStructures() {
yum remove -y nodejs npm
if [ $SYSTEM_VERSION_CENTOS -eq "8" ];then
  yum install -y https://mirrors.ustc.edu.cn/centos/8.3.2011/PowerTools/x86_64/os/Packages/perl-IO-Tty-1.12-11.el8.x86_64.rpm
  yum install -y https://mirrors.ustc.edu.cn/centos/8.3.2011/PowerTools/x86_64/os/Packages/perl-IPC-Run-0.99-1.el8.noarch.rpm
fi
yum install -y git wget curl perl moreutils
curl -sL https://rpm.nodesource.com/setup_14.x | bash -
sed -i "s#rpm.nodesource.com#mirrors.ustc.edu.cn/nodesource/rpm#" /etc/yum.repos.d/nodesource-*.repo
yum makecache
yum install -y nodejs
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
VERIFICATION=`node -v | cut -c2`
if [ $VERIFICATION -eq "1" ]; then
  echo -e "\033[32m ------------------- 环境部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
  echo -e "\033[32m +=================================================================================================+ \033[0m"
  echo -e "\033[32m | 注意：该项目主运行目录为/home/myid/jd                                                           | \033[0m"
  echo -e "\033[32m | 注意：为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                      | \033[0m"
  echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + C 跳过继续执行剩余活动脚本        | \033[0m"
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
