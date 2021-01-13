#!/bin/bash
#Author:SuperManito
#Update Date:2021-1-13
#Project Name:《京东薅羊毛》一键部署脚本 For Linux，通过参与京东商城的各种活动白嫖京豆
#适用系统：CentOS 8简体中文，不适用7及更低版本，本人测试环境为最新CentOS 8.3，如果是最小化安装CentOS，请通过SSL方式进入到终端

#将Cookie部分内容填入”双引号“内：（适用于手动搭建）
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'

#当前用户判定：
JudgeUser() {
  if [ $UID -ne 0 ];then
      echo -e '\033[31m ------------ Permission no enough, please use user ROOT! ------------ \033[0m'
      return
  fi
}

#网络环境判定：
JudgeNetwork() {
  ping -c 1 www.baidu.com > /dev/null 2>&1
  if [ $? -ne 0 ];then
      echo -e "\033[31m ----- Network connection error.Please check the network environment and try again later! ----- \033[0m"
      return
  fi
}

#环境部署：
EnvDeploy() {
  systemctl disable --now firewalld
  sed -i "7c SELINUX=disabled" /etc/selinux/config
  setenforce 0
  rm -rf /etc/yum.repos.d/*
  wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo
  yum makecache > /dev/null 2>&1
  yum install -y https://mirrors.aliyun.com/epel/epel-release-latest-8.noarch.rpm
  yum makecache
  yum install -y https://mirrors.aliyun.com/centos/8.3.2011/PowerTools/x86_64/os/Packages/perl-IO-Tty-1.12-11.el8.x86_64.rpm
  yum install -y https://mirrors.aliyun.com/centos/8.3.2011/PowerTools/x86_64/os/Packages/perl-IPC-Run-0.99-1.el8.noarch.rpm
  yum install -y net-tools git curl wget nodejs npm perl moreutils
}

#语言环境判定：
JudgeLocale() {
  locale | grep 'LANG=zh_CN' -q
  if [ $? -eq 0 ];then
      echo "\033[32m ------------ 语言环境正确，开始部署项目核心环境 ------------ \033[0m"
      sleep 2s
  else
      yum -y install langpacks-zh_CN
      locale -a
      echo 'LANG="zh_CN.utf8"' > /etc/locale.conf
      . /etc/locale.conf
      type locale
      echo -e "\033[33m -------- Please reboot your system and try again，Because the locale was updated. -------- \033[0m"
      return
  fi
}

#部署项目环境：
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
AutoRun() {
  touch /home/myid/jd/run-all.sh
  chmod +x /home/myid/jd/run-all.sh
  bash jd.sh | grep _ >> /home/myid/jd/run-all.sh
  sed -i '1d' /home/myid/jd/run-all.sh
  sed -i 's/^/bash jd.sh &/g' /home/myid/jd/run-all.sh
  sed -i 's/$/& now/g' /home/myid/jd/run-all.sh
  sed -i '1i\#!/bin/bash' /home/myid/jd/run-all.sh
}

#编写一键更新脚本：
ManualUpdate() {
  touch /home/myid/jd/manual-update.sh
  chmod +x /home/myid/jd/manual-update.sh
  cat > /home/myid/jd/manual-update.sh << EOF
#!/bin/bash
bash git_pull.sh
rm -rf run-all.sh
touch run-all.sh
chmod +x run-all.sh
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
  echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + C 跳过继续执行剩余活动脚本        | \033[0m"
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
JudgeLocale
ScriptInstall
CookieConfig
AutoRun
ManualUpdate
Tips

