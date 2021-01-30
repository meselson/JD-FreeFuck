#!/bin/bash

## Author:SuperManito
## Modified： 2021-01-31
## Project Name:《京东薅羊毛》一键部署 For Linux，通过参与京东商城的各种活动白嫖京豆
## 适用系统: Ubuntu 16.04 ~ 20.10 | Debian 9.0 ~ 10.7 | CentOS 8.0 ~ 8.3 | Fedora 32 ~ 33
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
}

## 当前系统判定：
function SystemJudgment() {
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
  echo -e '\033[37m+---------------------------------------------------+ \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|   =============================================   | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|      欢迎使用《京东薅羊毛》一键部署 For Linux     | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|   =============================================   | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m+---------------------------------------------------+ \033[0m'
  echo -e ''
  echo -e '\033[37m##################################################### \033[0m'
  echo -e ''
  echo -e '\033[37m            提供以下国内更新源可供选择： \033[0m'
  echo -e ''
  echo -e '\033[37m##################################################### \033[0m'
  echo -e ''
  echo -e '\033[37m *  1)    中科大 \033[0m'
  echo -e '\033[37m *  2)    华为云 \033[0m'
  echo -e '\033[37m *  3)    阿里云 \033[0m'
  echo -e '\033[37m *  4)    网易 \033[0m'
  echo -e '\033[37m *  4)    搜狐 \033[0m'
  echo -e '\033[37m *  6)    清华大学 \033[0m'
  echo -e '\033[37m *  7)    浙江大学 \033[0m'
  echo -e '\033[37m *  8)    南京大学 \033[0m'
  echo -e '\033[37m *  9)    重庆大学 \033[0m'
  echo -e '\033[37m *  10)   兰州大学 \033[0m'
  echo -e '\033[37m *  11)   上海交通大学 \033[0m'
  echo -e '\033[37m *  12)   北京交通大学 \033[0m'
  echo -e '\033[37m *  13)   北京理工大学 \033[0m'
  echo -e '\033[37m *  14)   南京邮电大学 \033[0m'
  echo -e '\033[37m *  15)   华中科技大学 \033[0m'
  echo -e '\033[37m *  16)   哈尔滨工业大学 \033[0m'
  echo -e '\033[37m *  17)   北京外国语大学 \033[0m'
  echo -e ''
  echo -e '\033[37m##################################################### \033[0m'
  echo -e ''
  echo -e "\033[37m      当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER \033[0m"
  echo -e "\033[37m      当前系统时间  $(date +%Y-%m-%d) $(date +%H:%M) \033[0m"
  echo -e ''
  echo -e '\033[37m##################################################### \033[0m'
  echo -e ''
  CHOICE=$(echo -e '\033[32m请输入您想使用的国内更新源 [ 1~17 ]：\033[0m')
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
    SOURCE="mirrors.sohu.com"
    ;;
  6)
    SOURCE="mirrors.tuna.tsinghua.edu.cn"
    ;;
  7)
    SOURCE="mirrors.zju.edu.cn"
    ;;
  8)
    SOURCE="mirrors.nju.edu.cn"
    ;;
  9)
    SOURCE="mirrors.cqu.edu.cn"
    ;;
  10)
    SOURCE="mirror.lzu.edu.cn"
    ;;
  11)
    SOURCE="ftp.sjtu.edu.cn"
    ;;
  12)
    SOURCE="mirror.bjtu.edu.cn"
    ;;
  13)
    SOURCE="mirror.bit.edu.cn"
    ;;
  14)
    SOURCE="mirrors.njupt.edu.cn"
    ;;
  15)
    SOURCE="mirrors.hust.edu.cn"
    ;;
  16)
    SOURCE="mirrors.hit.edu.cn"
    ;;
  17)
    SOURCE="mirrors.bfsu.edu.cn"
    ;;
  *)
    SOURCE="mirrors.ustc.edu.cn"
    echo -e ''
    echo -e '\033[33m----------输入错误，更新源将默认使用中科大源---------- \033[0m'
    sleep 3s
    ;;
  esac

  if [ $SYSTEM = "Debian" ]; then
    DebianMirrors
  elif [ $SYSTEM = "RedHat" ]; then
    RedHatMirrors
  fi
}

## 基Debian系Linux发行版的Source更新源：
function DebianMirrors() {
  ls /etc/apt | grep sources.list.bak -qw
  if [ $? -eq 0 ]; then
    echo -e '\033[32m检测到已备份的 source.list源 文件，跳过备份操作...... \033[0m'
  else
    cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
    echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
  fi
  sleep 3s
  sed -i '1,$d' /etc/apt/sources.list
  if [ $SYSTEM_NAME = "Ubuntu" ]; then
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >>/etc/apt/sources.list
  elif [ $SYSTEM_NAME = "Debian" ]; then
    echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION main contrib non-free" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION-updates main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION-updates main contrib non-free" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/debian/ $SYSTEM_VERSION-backports main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian/ $SYSTEM_VERSION-backports main contrib non-free" >>/etc/apt/sources.list
    echo "deb https://$SOURCE/debian-security $SYSTEM_VERSION/updates main contrib non-free" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/debian-security $SYSTEM_VERSION/updates main contrib non-free" >>/etc/apt/sources.list
  elif [ $SYSTEM_NAME = "Kali" ]; then
    echo "deb https://$SOURCE/kali $SYSTEM_VERSION main non-free contrib" >>/etc/apt/sources.list
    echo "deb-src https://$SOURCE/kali $SYSTEM_VERSION main non-free contrib" >>/etc/apt/sources.list
  fi
  apt update
}

## 基于RedHat系Linux发行版的repo更新源：
function RedHatMirrors() {
  ## 此处调用基于RedHat系列Linux官方repo源生成脚本，由于内容过长所以没有直接加入到此脚本中
  bash <(curl -sL https://gitee.com/SuperManito/LinuxMirrors/raw/main/RedHat-Official-Mirror-Generation.sh)
  if [ $SYSTEM_NAME = "CentOS" ]; then
    sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/*
    sed -i 's|^#baseurl=http://mirror.centos.org/$contentdir|baseurl=https://mirror.centos.org/centos|g' /etc/yum.repos.d/*
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://mirror.centos.org|g' /etc/yum.repos.d/*
    sed -i "s|mirror.centos.org|$SOURCE|g" /etc/yum.repos.d/*
  elif [ $SYSTEM_NAME = "Fedora" ]; then
    sed -i 's|^metalink=|#metalink=|g' \
      /etc/yum.repos.d/fedora.repo \
      /etc/yum.repos.d/fedora-updates.repo \
      /etc/yum.repos.d/fedora-modular.repo \
      /etc/yum.repos.d/fedora-updates-modular.repo \
      /etc/yum.repos.d/fedora-updates-testing.repo \
      /etc/yum.repos.d/fedora-updates-testing-modular.repo
    sed -i 's|^#baseurl=|baseurl=|g' /etc/yum.repos.d/*
    sed -i "s|http://download.example/pub/fedora/linux|https://$SOURCE/fedora|g" \
      /etc/yum.repos.d/fedora.repo \
      /etc/yum.repos.d/fedora-updates.repo \
      /etc/yum.repos.d/fedora-modular.repo \
      /etc/yum.repos.d/fedora-updates-modular.repo \
      /etc/yum.repos.d/fedora-updates-testing.repo \
      /etc/yum.repos.d/fedora-updates-testing-modular.repo
  fi
  yum makecache
}

## 环境搭建：
function EnvStructures() {
  if [ $SYSTEM = "Debian" ]; then
    DOCKERJUDGMENT="dpkg -l"
  elif [ $SYSTEM = "RedHat" ]; then
    DOCKERJUDGMENT="rpm -qa"
  fi
  $DOCKERJUDGMENT | grep docker -wq  
  if [ $? -ne 0 ];then
    if [ $SYSTEM_NAME = "Ubuntu" ]; then
      apt remove -y docker docker-engine docker.io containerd runc
      apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common dos2unix
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
      add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
      apt update
      apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Debian" ]; then
      apt remove -y docker docker-engine docker.io containerd runc
      apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common dos2unix
      curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
      add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"
      apt update
      apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "CentOS" ]; then
      firewall-cmd --zone=public --add-port=5678/tcp --permanent
      systemctl reload firewalld
      yum remove -y docker* runc
      yum install -y yum-utils device-mapper-persistent-data lvm2 dos2unix
      yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
      yum makecache
      yum install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Fedora" ]; then
      firewall-cmd --zone=public --add-port=5678/tcp --permanent
      systemctl reload firewalld
      yum remove -y docker* runc
      yum -y install yum-utils device-mapper-persistent-data lvm2 dos2unix
      yum config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/fedora/docker-ce.repo
      yum makecache
      yum install -y docker-ce docker-ce-cli containerd.io
    fi
  fi
  ls /etc | grep /docker/daemon.json
  if [ $? -eq 0 ];then
    cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
    echo -e "\033[32m已备份原有daemon.json...... \033[0m"
    sed -i '1,$d' /etc/docker/daemon.json
    echo '{"registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]}' >>/etc/docker/daemon.json
    systemctl daemon-reload
    systemctl restart docker
  else
    mkdir -p /etc/docker
    touch /etc/docker/daemon.json
    echo '{"registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]}' >>/etc/docker/daemon.json
    systemctl daemon-reload
    systemctl restart docker
  fi
  docker pull evinedeng/jd:gitee
}

## 项目部署：
function ProjectDeployment() {
  docker run -dit \
  -v /opt/jd/config:/jd/config `# 设置配置文件的主机挂载目录 /opt` \
  -v /opt/jd/log:/jd/log `# 设置日志的主机挂载目录 /opt` \
  -p 5678:5678 `# 设置端口映射，内部端口为5678，外部端口为5678` \
  -e ENABLE_HANGUP=true `# 启用挂机功能` \
  -e ENABLE_WEB_PANEL=true `# 启用控制面板功能` \
  --name jd `# 设置容器名为jd` \
  --network bridge `# 设置网络为桥接，直连主机` \
  --hostname jd `# 设置主机名为jd` \
  --restart always `# 设置开机自启` \
  evinedeng/jd:gitee
}

## 一键脚本：
function AutoScript() {
  docker exec -it jd bash git_pull.sh > /dev/null 2>&1
  ## 编写一键执行脚本：
  touch /opt/jd/run-all.sh
  docker exec -it jd bash jd.sh | grep -o 'jd_[a-z].*' >/opt/jd/run-all.sh
  docker exec -it jd bash jd.sh | grep -o 'jx_[a-z].*' >>/opt/jd/run-all.sh
  sed -i 's/^/docker exec -it jd bash jd.sh &/g' /opt/jd/run-all.sh
  sed -i 's/.js/ now/g' /opt/jd/run-all.sh
  sed -i '1i\#!/bin/bash' /opt/jd/run-all.sh
  ## 编写一键更新脚本：
  touch /opt/jd/manual-update.sh
  cat >/opt/jd/manual-update.sh <<EOF
#!/bin/bash
docker exec -it jd bash git_pull.sh
rm -rf /opt/jd/run-all.sh
touch /opt/jd/run-all.sh
docker exec -it jd bash jd.sh | grep -o 'jd_[a-z].*' > /opt/jd/run-all.sh
docker exec -it jd bash jd.sh | grep -o 'jx_[a-z].*' >> /opt/jd/run-all.sh
sed -i 's/^/docker exec -it jd bash jd.sh &/g' /opt/jd/run-all.sh
sed -i 's/.js/ now/g' /opt/jd/run-all.sh
sed -i '1i\#!/bin/bash' /opt/jd/run-all.sh
dos2unix /opt/jd/run-all.sh
EOF
  dos2unix /opt/jd/run-all.sh
  dos2unix /opt/jd/manual-update.sh
  bash /opt/jd/manual-update.sh
}

## 更改配置文件：
function CookieConfig() {
  sed -i "27c Cookie1=$COOKIE1" /opt/jd/config/config.sh
  sed -i "28c Cookie2=$COOKIE2" /opt/jd/config/config.sh
  sed -i "29c Cookie3=$COOKIE3" /opt/jd/config/config.sh
  sed -i "30c Cookie4=$COOKIE4" /opt/jd/config/config.sh
  sed -i "31c Cookie5=$COOKIE5" /opt/jd/config/config.sh
  sed -i "32c Cookie6=$COOKIE6" /opt/jd/config/config.sh
}

#部署结果判定：
function ResultJudgment() {
  docker ps | grep evinedeng/jd:gitee -wq
  if [ $? -eq 0 ]; then
    echo -e ''
    echo -e "\033[32m +----------- 已启用控制面板功能 -----------+ \033[0m"
    echo -e "\033[32m | 本机访问   http://127.0.0.1:5678         | \033[0m"
    echo -e "\033[32m | 局域网访问 http://本机外部网络IP:5678    | \033[0m"
    echo -e "\033[32m | 登录用户名：admin，初始密码：adminadmin  | \033[0m"
    echo -e "\033[32m +------------------------------------------+ \033[0m"
    echo -e ''
    sleep 3s
    echo -e "\033[32m ------------------- 一键部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
    echo -e "\033[32m +==================================================================================================+ \033[0m"
    echo -e "\033[32m | 注意：该项目配置文件以及一键脚本所在目录为/opt/jd                                                | \033[0m"
    echo -e "\033[32m | 注意：此项目涉及 docker 容器技术，如果你对 docker基础命令 一无所知，那么请不要随意改动容器       | \033[0m"
    if [ $SYSTEM = "Debian" ]; then
      echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z 跳过继续执行剩余活动脚本         | \033[0m"
    elif [ $SYSTEM = "RedHat" ]; then
      echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + C 跳过继续执行剩余活动脚本         | \033[0m"
    fi
    echo -e "\033[32m | 注意：由于京东活动一直变化所以会出现无法参加活动、报错等正常现象，可手动更新活动脚本             | \033[0m"
    echo -e "\033[32m | 注意：之前填入的 Cookie 部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新 | \033[0m"
    echo -e "\033[32m | 注意：如果需要查看帮助文档以及获取更多功能，请通过 docker exec -it jd cat readme.md 命令进行查看 | \033[0m"
    echo -e "\033[32m | 定义：run-all.sh 为本人编写的一键执行所有活动脚本，manual-update.sh 为本人编写的一键更新脚本     | \033[0m"
    echo -e "\033[32m |       仍可通过原作者 docker exec -it jd bash jd.sh 命令查看活动列表并执行特定活动脚本            | \033[0m"
    echo -e "\033[32m +==================================================================================================+ \033[0m"
    echo -e "\033[32m -------------------- 更多帮助请访问: https://github.com/SuperManito/JD-FreeFuck -------------------- \033[0m"
  else
    echo -e "\033[31m -------------- 一键部署失败 -------------- \033[0m"
  fi
}

EnvJudgment
SystemJudgment
ReplaceMirror
EnvStructures
ProjectDeployment
AutoScript
CookieConfig
ResultJudgment
