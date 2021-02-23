#!/bin/bash
## Author:SuperManito
## Modified:2021-2-24

## ============================================== 项 目 说 明 ==============================================
##                                                                                                        #
## 项目名称：《京东薅羊毛》一键部署 For Linux                                                                #
## 项目用途：通过参与京东商城的各种活动白嫖京豆                                                               #
## 适用系统：Ubuntu 16.04 ~ 20.10    Fedora 28 ~ 33                                                        #
##          Debian 9.0 ~ 10.7       CentOS 7.0 ~ 8.3                                                      #
## 温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文，CentOS如果是最小化安装，请通过SSH方式进入到终端   #
##                                                                                                        #
## 本项目基于 Evine 公布的源码，活动脚本基于 lxk0301 大佬的 jd_scripts 项目                                   #
## 本人能力有限，这可能是最终版本，感谢 Evine 对此项目做出的贡献                                               #
## 核心活动脚本项目地址：https://gitee.com/lxk0301/jd_scripts/tree/master                                   #
##                                                                                                        #
## ========================================================================================================

## ======================================= 本 地 部 署 定 义 的 变 量 =======================================
## 安装目录
BASE="/opt/jd"
## 京东账户
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'
##
## 配置京东账户注意事项：
## 1. 将 Cookie部分内容 填入"双引号"内，例 COOKIE1='"pt_key=xxxxxx;pt_pin=xxxxxx;"'
## 2. 本项目可同时运行无限个账号，从第7个账户开始需要自行在项目 config.sh 配置文件中定义变量例如Cookie7=""
## ========================================================================================================

## 环境判定：
function EnvJudgment() {
  ## 当前用户判定：
  if [ $UID -ne 0 ]; then
    echo -e '\033[31m ------------ Permission no enough, please use user ROOT! ------------ \033[0m'
    exit
  fi
  ## 网络环境判定：
  ping -c 1 www.baidu.com >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo -e "\033[31m ----- Network connection error.Please check the network environment and try again later! ----- \033[0m"
    exit
  fi
}

## 系统判定：
function SystemJudgment() {
  ## 判定系统是基于Debian还是RedHat
  ls /etc | grep redhat-release -qw
  if [ $? -eq 0 ]; then
    SYSTEM="RedHat"
  else
    SYSTEM="Debian"
  fi
  ## 定义一些变量
  if [ $SYSTEM = "Debian" ]; then
    SYSTEM_NAME=$(lsb_release -is)
    SYSTEM_VERSION=$(lsb_release -cs)
    SYSTEM_VERSION_NUMBER=$(lsb_release -rs)
  elif [ $SYSTEM = "RedHat" ]; then
    SYSTEM_NAME=$(cat /etc/redhat-release | cut -c1-6)
    if [ $SYSTEM_NAME = "CentOS" ]; then
      SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c22-24)
    elif [ $SYSTEM_NAME = "Fedora" ]; then
      SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c16-18)
    fi
  fi
  CENTOS_VERSION=$(cat /etc/redhat-release | cut -c22)
}

## 环境搭建：
function EnvStructures() {
  echo -e '\033[37m+---------------------------------------------------+ \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|   =============================================   | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|      欢迎使用《京东薅羊毛》一键部署 For Linux     | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|   =============================================   | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m+---------------------------------------------------+ \033[0m'
  sleep 3s

  ## 修改系统时区：
  timedatectl set-timezone "Asia/Shanghai"

  ## CentOS安装扩展EPEL源
  if [ $SYSTEM_NAME = "CentOS" ]; then
    yum makecache
    yum install -y epel-release
  fi
  ## CentOS8启用PowerTools仓库
  if [ $CENTOS_VERSION = "8" ]; then
    sed -i "s/enabled=0/enabled=1/g" /etc/yum.repos.d/CentOS*PowerTools.repo
  fi

  ## 基于 Debian 的安装方法
  if [ $SYSTEM = "Debian" ]; then
    apt update
    ## 卸载旧版本Node版本，从而确保安装新版本
    apt remove -y nodejs npm >/dev/null 2>&1
    rm -rf /etc/apt/sources.list.d/nodesource.list >/dev/null 2>&1
    ## 安装需要的软件包
    apt install -y wget curl net-tools openssh-server git perl moreutils
    ## 安装Nodejs与NPM
    curl -sL https://deb.nodesource.com/setup_14.x | bash -
    apt install -y nodejs
    apt autoremove -y
  ## 基于 RedHat 的安装方法
  elif [ $SYSTEM = "RedHat" ]; then
    yum makecache
    ## 卸载旧版本Node版本，从而确保安装新版本
    yum remove -y nodejs npm >/dev/null 2>&1
    rm -rf /etc/yum.repos.d/nodesource-*.repo >/dev/null 2>&1
    ## 安装需要的软件包
    yum install -y wget curl net-tools openssh-server git perl moreutils
    ## 安装Nodejs与NPM
    curl -sL https://rpm.nodesource.com/setup_14.x | bash -
    yum install -y nodejs
    yum autoremove -y
  fi
}

## 项目部署：
function ProjectDeployment() {
  ## 配置SSH服务
  service ssh enable >/dev/null 2>&1
  service ssh start >/dev/null 2>&1
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
  service ssh restart >/dev/null 2>&1
  ## 配置SSH密钥文件夹
  ls ~ | grep .ssh -rwq
  if [ $? -eq 0 ];then
  ## 检测当前用户是否存在私钥
    ls ~/.ssh | grep id_rsa.bak -wq
    if [ $? -eq 0 ];then
      rm -rf ~/.ssh/id_rsa
      echo -e "\033[31m检测到已备份的私钥，跳过备份操作...... \033[0m"
      sleep 2s
    else
      mv ~/.ssh/id_rsa ~/.ssh/id_rsa.bak >/dev/null 2>&1
    fi
    ## 检测当前用户是否存在公钥
    ls ~/.ssh | grep id_rsa.pub.bak -wq
    if [ $? -eq 0 ];then
      rm -rf ~/.ssh/id_rsa.pub
      echo -e "\033[31m检测到已备份的公钥，跳过备份操作...... \033[0m"
      sleep 2s
    else
      mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.bak >/dev/null 2>&1
    fi
  else
    mkdir -p ~/.ssh
  fi
  ## 通过添加SSH私钥与公钥解决访问lxk/jd_scripts私有库的权限问题
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/id_rsa -O ~/.ssh/id_rsa
  chmod 600 ~/.ssh/id_rsa
  ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
  ## 下载源码并解压至目录
  wget -P /opt https://gitee.com/SuperManito/JD-FreeFuck/attach_files/616570/download/jd.tar
  mkdir -p $BASE
  tar -xvf /opt/jd.tar -C $BASE
  rm -rf /opt/jd.tar
  mkdir $BASE/config
  ## 更换新的文件
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/jd.sh -O $BASE/jd.sh
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/config.sh.sample -O $BASE/sample/config.sh.sample
  ## 创建项目配置文件与定时任务配置文件
  cp $BASE/sample/config.sh.sample $BASE/config/config.sh
  cp $BASE/sample/computer.list.sample $BASE/config/crontab.list
  ## 更新脚本，导入LXK0301大佬gitee库活动脚本
  bash $BASE/git_pull.sh
  bash $BASE/git_pull.sh >/dev/null 2>&1
  ## 安装控制面板功能
  firewall-cmd --zone=public --add-port=5678/tcp --permanent >/dev/null 2>&1
  systemctl reload firewalld >/dev/null 2>&1
  cp $BASE/sample/auth.json $BASE/config/auth.json
  cd $BASE/panel
  npm install || npm install --registry=https://registry.npm.taobao.org
  npm install -g pm2
  pm2 start server.js
  cd $BASE
  ## 配置定时任务
  sed -i "s#/home/myid/jd#$BASE#g" $BASE/config/crontab.list
}

## 更改配置文件：
function SetConfig() {
  sed -i "28c Cookie1=$COOKIE1" $BASE/config/config.sh
  sed -i "29c Cookie2=$COOKIE2" $BASE/config/config.sh
  sed -i "30c Cookie3=$COOKIE3" $BASE/config/config.sh
  sed -i "31c Cookie4=$COOKIE4" $BASE/config/config.sh
  sed -i "32c Cookie5=$COOKIE5" $BASE/config/config.sh
  sed -i "33c Cookie6=$COOKIE6" $BASE/config/config.sh
}

## 一键脚本：
function AutoScript() {
  ## 编写一键执行所有活动脚本
  touch $BASE/run-all.sh
  bash $BASE/jd.sh | grep -o 'jd_[a-z].*' >$BASE/run-all.sh
  bash $BASE/jd.sh | grep -o 'jx_[a-z].*' >>$BASE/run-all.sh
  sed -i 's/^/bash jd.sh &/g' $BASE/run-all.sh
  sed -i 's/.js/ now/g' $BASE/run-all.sh
  sed -i '1i\#!/bin/bash' $BASE/run-all.sh
  sed -i "s/bash jd.sh jd_delCoupon now//g" run-all.sh
  sed -i "s/bash jd.sh jd_family now//g" run-all.sh
  cat $BASE/run-all.sh | grep jd_crazy_joy_coin -wq
  if [ $? -eq 0 ];then
    sed -i "s/bash jd.sh jd_crazy_joy_coin now//g" run-all.sh
    echo "bash jd.sh jd_crazy_joy_coin now" >>run-all.sh
  fi
  sed -i '/^\s*$/d' run-all.sh
  ## 下载最新的一键更新脚本
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/manual-update.sh -O $BASE/manual-update.sh >/dev/null 2>&1
}

## 部署结果判定：
function ResultJudgment() {
  ## 判定控制面板是否安装成功
  netstat -anp | grep 5678 -wq
  if [ $? -eq 0 ];then
    echo -e "\033[32m +------- 已 启 用 控 制 面 板 功 能 -------+ \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m | 本地访问：http://127.0.0.1:5678          | \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m | 外部访问：http://内部或外部IP地址:5678   | \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m | 初始用户名：admin，初始密码：adminadmin  | \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m +------------------------------------------+ \033[0m"
  else
    echo -e "\033[31m -------------- 控制面板安装失败 -------------- \033[0m"
  fi
  sleep 3s
  ## 判定Nodejs是否安装成功
  VERIFICATION=$(node -v | cut -c2)
  if [ $VERIFICATION = "1" ]; then
    echo -e ''
    echo -e "\033[32m --------------------------- 一键部署成功，请执行 bash run-all.sh 命令开始您的薅羊毛行为 --------------------------- \033[0m"
    echo -e "\033[32m +=================================================================================================================+ \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 定义：run-all.sh 为一键执行所有活动脚本，manual-update.sh 为一键更新脚本                                        | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       如果想要执行特定活动脚本，请通过命令 bash jd.sh 查看教程                                                  | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 注意：1. 该项目文件以及一键脚本的安装目录为$BASE                                                             | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       2. 为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                                   | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       3. 手动执行 run-all.sh 脚本后无需守在电脑旁，会自动在最后运行挂机活动脚本                                 | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    if [ $SYSTEM = "Debian" ]; then
      echo -e "\033[32m |       4. 执行 run-all 脚本期间如果卡住，可按回车键尝试或通过命令 Ctrl + Z 跳过继续执行剩余活动脚本              | \033[0m"
    elif [ $SYSTEM = "RedHat" ]; then
      echo -e "\033[32m |       4. 执行 run-all 脚本期间如果卡住，可按回车键尝试或通过命令 Ctrl + C 跳过继续执行剩余活动脚本              | \033[0m"
    fi
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       5. 由于京东活动一直变化可能会出现无法参加活动、报错等正常现象，可手动更新活动脚本                         | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       6. 如果需要更新活动脚本，请执行 bash manual-update.sh 命令一键更新即可，它会同步更新 run-all.sh 脚本      | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       7. 除手动运行活动脚本外该项目还会通过定时的方式全天候自动运行活动脚本，具体运行记录可通过日志查看         | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       8. 该项目已默认配置好 Crontab 定时任务，定时配置文件 crontab.list 会通过活动脚本的更新而同步更新          | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       9. 之前填入的 Cookie 部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新             | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       10. 我不是活动脚本的开发者，但后续使用遇到任何问题都可访问本项目寻求帮助，制作不易，理解万岁              | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m +=================================================================================================================+ \033[0m"
    echo -e "\033[32m --------------------------- 更多帮助请访问   https://github.com/SuperManito/JD-FreeFuck --------------------------- \033[0m"
    echo -e "\033[32m --------------------------- Github & Gitee   https://gitee.com/SuperManito/JD-FreeFuck  --------------------------- \033[0m"
    echo -e ''
    echo -e "\033[32m ------------------------------- 如果老板成功薅到羊毛，可对我进行打赏，感谢您的支持！------------------------------- \033[0m"
  else
    echo -e "\033[31m -------------- 一键部署失败 -------------- \033[0m"
    echo -e "\033[31m 原因：Nodejs未安装成功，请检查网络相关问题 \033[0m"
  fi
}

EnvJudgment
SystemJudgment
EnvStructures
ProjectDeployment
SetConfig
AutoScript
ResultJudgment
