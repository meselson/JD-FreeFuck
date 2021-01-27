#!/bin/bash

## Author:SuperManito
## Modified： 2021-01-28
## Project Name:《京东薅羊毛》一键部署脚本 For Linux，通过参与京东商城的各种活动白嫖京豆
## 适用系统: Ubuntu 16.04 ~ 20.10 | Debian 8.0 ~ 10.7 | Kali 2018 ~ 2020.4 | CentOS 7.0 ~ 8.3 | Fedora 28 ~ 33
## 请确认安装环境是否支持简体中文，CentOS如果是最小化安装，请通过SSH方式进入到终端

## 将Cookie部分内容填入”双引号“内：（适用于手动搭建）
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'

## 环境判定：
function EnvJudgment() {
  ## 当前用户判定：
  if [ $UID -ne 0 ]; then
    echo -e '\033[31m ------------ Permission no enough, please use user ROOT! ------------ \033[0m'
    return
  fi
  ## 网络环境判定：
  ping -c 1 www.baidu.com >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo -e "\033[31m ----- Network connection error.Please check the network environment and try again later! ----- \033[0m"
    return
  fi
  ## 当前系统判定：
  ls /etc | grep redhat-release -qw
  if [ $? -eq 0 ]; then
    SYSTEM="RedHat"
  else
    SYSTEM="Debian"
  fi

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
}

## 更换国内源：
function ReplaceMirror() {
  ## 此处调用一键更换国内更新源（定制版）脚本 内容过长所以没有直接加入到此脚本中
  bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/ReplaceMirrors.sh)
}

## 环境搭建：
function EnvStructures() {
  if [ $SYSTEM = "Debian" ]; then
    apt remove -y nodejs npm
    apt install -y git wget curl perl moreutils
    curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
    tail /etc/apt/sources.list.d/nodesource.list >>/etc/apt/sources.list.d/nodesource.list
    sed -i "1 s#deb.nodesource.com#mirrors.ustc.edu.cn/nodesource/deb#" /etc/apt/sources.list.d/nodesource.list
    sed -i "2 s#deb.nodesource.com#mirrors.ustc.edu.cn/nodesource/deb#" /etc/apt/sources.list.d/nodesource.list
    sed -i "3 s#deb.nodesource.com/node_14.x#mirrors.tuna.tsinghua.edu.cn/nodesource/deb_14.x/#" /etc/apt/sources.list.d/nodesource.list
    sed -i "4 s#deb.nodesource.com/node_14.x#mirrors.tuna.tsinghua.edu.cn/nodesource/deb_14.x/#" /etc/apt/sources.list.d/nodesource.list
    apt update
    apt install -y nodejs
    apt dist-upgrade -y
    apt autoremove -y
  elif [ $SYSTEM = "RedHat" ]; then
    yum remove -y nodejs npm
    yum install -y git wget curl perl moreutils
    curl -sL https://rpm.nodesource.com/setup_14.x | bash -
    sed -i "s#rpm.nodesource.com#mirrors.ustc.edu.cn/nodesource/rpm#" /etc/yum.repos.d/nodesource-*.repo
    yum makecache
    yum install -y nodejs
  fi
}

## 项目部署：
function ProjectDeployment() {
  wget --no-check-certificate https://pd.zwc365.com/seturl/https://github.com/SuperManito/JD-FreeFuck/releases/download/jd_backup/jd.tar.gz
  mkdir -p /home/myid
  tar -zxvf jd.tar.gz -C /home/myid
  cd /home/myid/jd
  bash git_pull.sh
  cd /home/myid/jd/scripts
  npm install || npm install --registry=https://registry.npm.taobao.org
  cd /home/myid/jd
}

## 更改配置文件：
function CookieConfig() {
  sed -i "27c Cookie1=$COOKIE1" config/config.sh
  sed -i "28c Cookie2=$COOKIE2" config/config.sh
  sed -i "29c Cookie3=$COOKIE3" config/config.sh
  sed -i "30c Cookie4=$COOKIE4" config/config.sh
  sed -i "31c Cookie5=$COOKIE5" config/config.sh
  sed -i "32c Cookie6=$COOKIE6" config/config.sh
}

## 一键脚本：
function AutoScript() {
  ## 编写一键执行脚本：
  touch /home/myid/jd/run-all.sh
  bash jd.sh | grep -o 'jd_[a-z].*' >run-all.sh
  bash jd.sh | grep -o 'jx_[a-z].*' >>run-all.sh
  sed -i 's/^/bash jd.sh &/g' /home/myid/jd/run-all.sh
  sed -i 's/$/& now/g' /home/myid/jd/run-all.sh
  sed -i '1i\#!/bin/bash' /home/myid/jd/run-all.sh
  ## 编写一键更新脚本：
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
function ResultJudgment() {
  VERIFICATION=$(node -v | cut -c2)
  if [ $VERIFICATION -eq "1" ]; then
    echo -e "\033[32m ------------------- 环境部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
    echo -e "\033[32m +=================================================================================================+ \033[0m"
    echo -e "\033[32m | 注意：该项目主运行目录为/home/myid/jd                                                           | \033[0m"
    echo -e "\033[32m | 注意：为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                      | \033[0m"
    if [ $SYSTEM = "Debian" ]; then
      echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z 跳过继续执行剩余活动脚本        | \033[0m"
    elif [ $SYSTEM = "RedHat" ]; then
      echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + C 跳过继续执行剩余活动脚本        | \033[0m"
    fi
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

EnvJudgment
ReplaceMirror
EnvStructures
ProjectDeployment
CookieConfig
AutoScript
ResultJudgment
