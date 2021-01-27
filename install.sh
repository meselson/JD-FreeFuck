#!/bin/bash
#Author:SuperManito
#Update Date:2021-1-27
#Project Name:《京东薅羊毛》一键部署脚本 For Linux，通过参与京东商城的各种活动白嫖京豆
## 适用系统: Ubuntu 16.04 ~ 20.10 | Debian 8.0 ~ 10.7 | Kali 2018 ~ 2020.4
## 适用系统: CentOS 7.0 ~ 8.3 | Fedora 28 ~ 33   CentOS如果是最小化安装，请通过SSH方式进入到终端

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
  if [ $? -eq 0 ];then
    SYSTEM="RedHat"
  else
    SYSTEM="Debian"
  fi

  if [ $SYSTEM = "Debian" ];then
    SYSTEM_NAME=`lsb_release -is`
    SYSTEM_VERSION=`lsb_release -cs`
    SYSTEM_VERSION_NUMBER=`lsb_release -rs`
  elif [ $SYSTEM = "RedHat" ];then
    SYSTEM_NAME=`cat /etc/redhat-release | cut -c1-6`
    if [ $SYSTEM_NAME = "CentOS" ];then
      SYSTEM_VERSION_NUMBER=`cat /etc/redhat-release | cut -c22-24`
    elif [ $SYSTEM_NAME = "Fedora" ];then
      SYSTEM_VERSION_NUMBER=`cat /etc/redhat-release | cut -c16-18`
    fi
  fi
}

## 更换国内更新源：
function SourceChange() {
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
    SOURCE="mirrors.ustc.edu.cn"
    echo -e ''
    echo -e '\033[33m----------输入错误，更新源将默认使用中科大源---------- \033[0m'
    sleep 3s
    ;;
  esac
  
  if [ $SYSTEM = "Debian" ];then
    DebianSource
  elif [ $SYSTEM = "RedHat" ];then
    RedHatSource
  fi
}

## 基Debian系Linux发行版的Source更新源：
function DebianSource() {
ls /etc/apt | grep sources.list.bak -qw
if [ $? -eq 0 ];then
  echo -e '\033[32m检测到已备份的 source.list源 文件，跳过备份操作...... \033[0m'
else
  cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
  echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
fi
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

## 基于RedHat系Linux发行版的repo更新源：
function RedHatSource() {
  ls /etc | grep yum.repos.d.bak -qw
  if [ $? -eq 0 ];then
    echo -e '\033[32m检测到已备份的 repo源 文件，跳过备份操作...... \033[0m'
  else
    mkdir -p /etc/yum.repos.d.bak
    cp -rf /etc/yum.repos.d/* /etc/yum.repos.d.bak
    echo -e '\033[32m已备份原有 repo源 文件至 /etc/yum.repos.d.bak ...... \033[0m'
  fi
  sleep 2s
  CENTOS_VERSION=`cat /etc/redhat-release | cut -c22`
  if [ $CENTOS_VERSION = "8" ];then
    rm -rf /etc/yum.repos.d/CentOS-Linux-AppStream.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Extras.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
    touch /etc/yum.repos.d/CentOS-Linux-AppStream.repo
    touch /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
    touch /etc/yum.repos.d/CentOS-Linux-Extras.repo
    touch /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
    cat >/etc/yum.repos.d/CentOS-Linux-AppStream.repo <<\EOF
[appstream]
name=CentOS Linux $releasever - AppStream
baseurl=http://mirror.centos.org/centos/$releasever/AppStream/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-BaseOS.repo <<\EOF
[baseos]
name=CentOS Linux $releasever - BaseOS
baseurl=http://mirror.centos.org/centos/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Extras.repo <<\EOF
[extras]
name=CentOS Linux $releasever - Extras
baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-PowerTools.repo <<\EOF
[powertools]
name=CentOS Linux $releasever - PowerTools
baseurl=http://mirror.centos.org/centos/$releasever/PowerTools/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    sed -i "s|http://mirror.centos.org|https://$SOURCE|g" \
    /etc/yum.repos.d/CentOS-Linux-AppStream.repo \
    /etc/yum.repos.d/CentOS-Linux-BaseOS.repo \
    /etc/yum.repos.d/CentOS-Linux-Extras.repo \
    /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
  elif [ $CENTOS_VERSION = "7" ];then
    rm -rf /etc/yum.repos.d/CentOS-BaseOS.repo
    touch /etc/yum.repos.d/CentOS-BaseOS.repo
    cat >/etc/yum.repos.d/CentOS-BaseOS.repo <<\EOF
[base]
name=CentOS-$releasever - Base
baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[updates]
name=CentOS-$releasever - Updates
baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[extras]
name=CentOS-$releasever - Extras
baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
[centosplus]
name=CentOS-$releasever - Plus
baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
    sed -i "s|http://mirror.centos.org|https://$SOURCE|g" /etc/yum.repos.d/CentOS-BaseOS.repo
  elif [ $SYSTEM_NAME = "Fedora" ];then
    rm -rf /etc/yum.repos.d/fedora.repo
    rm -rf /etc/yum.repos.d/fedora-updates.repo
    rm -rf /etc/yum.repos.d/fedora-modular.repo
    rm -rf /etc/yum.repos.d/fedora-updates-modular.repo
    touch /etc/yum.repos.d/fedora.repo
    touch /etc/yum.repos.d/fedora-updates.repo
    touch /etc/yum.repos.d/fedora-modular.repo
    touch /etc/yum.repos.d/fedora-updates-modular.repo
    cat >/etc/yum.repos.d/fedora.repo <<\EOF
[fedora]
name=Fedora $releasever - $basearch
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/
enabled=1
countme=1
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-debuginfo]
name=Fedora $releasever - $basearch - Debug
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/$basearch/debug/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-source]
name=Fedora $releasever - Source
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/source/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
    cat >/etc/yum.repos.d/fedora-updates.repo <<\EOF
[updates]
name=Fedora $releasever - $basearch - Updates
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/$basearch/
enabled=1
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-debuginfo]
name=Fedora $releasever - $basearch - Updates - Debug
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-source]
name=Fedora $releasever - Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
    cat >/etc/yum.repos.d/fedora-modular.repo <<\EOF
[fedora-modular]
name=Fedora Modular $releasever - $basearch
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/$basearch/os/
enabled=1
countme=1
#metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-modular-debuginfo]
name=Fedora Modular $releasever - $basearch - Debug
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/$basearch/debug/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[fedora-modular-source]
name=Fedora Modular $releasever - Source
baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/source/tree/
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
    cat >/etc/yum.repos.d/fedora-updates-modular.repo <<\EOF
[updates-modular]
name=Fedora Modular $releasever - $basearch - Updates
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/
enabled=1
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-modular-debuginfo]
name=Fedora Modular $releasever - $basearch - Updates - Debug
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-modular-source]
name=Fedora Modular $releasever - Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
    cat >/etc/yum.repos.d/fedora-updates-testing.repo <<\EOF
[updates-testing]
name=Fedora $releasever - $basearch - Test Updates
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/$basearch/
enabled=0
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-debuginfo]
name=Fedora $releasever - $basearch - Test Updates Debug
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-source]
name=Fedora $releasever - Test Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
    cat >/etc/yum.repos.d/fedora-updates-testing-modular.repo <<\EOF
[updates-testing-modular]
name=Fedora Modular $releasever - $basearch - Test Updates
baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Modular/$basearch/
enabled=0
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-modular-debuginfo]
name=Fedora Modular $releasever - $basearch - Test Updates Debug
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/debug/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
[updates-testing-modular-source]
name=Fedora Modular $releasever - Test Updates Source
baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/SRPMS/
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
    sed -i "s|http://download.example/pub/fedora/linux|https://$SOURCE/fedora|g" \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo \
    /etc/yum.repos.d/fedora-modular.repo \
    /etc/yum.repos.d/fedora-updates-modular.repo
  fi
  yum makecache
## CentOS安装扩展YUM源：
  if [ $SYSTEM_NAME = "CentOS" ];then
    yum install -y epel-release
    sed -i 's|^metalink=|#metalink=|g' /etc/yum.repos.d/epel.repo
    sed -i 's|^#baseurl=https\?://download.fedoraproject.org/pub/epel/|baseurl=https://mirrors.ustc.edu.cn/epel/|g' /etc/yum.repos.d/epel.repo
    yum makecache
  fi
}

## 环境搭建：
function EnvStructures() {
  if [ $SYSTEM = "Debian" ];then
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
  elif [ $SYSTEM = "RedHat" ];then
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
  wget wget https://github.com/SuperManito/JD-FreeFuck/raw/main/jd.tar.gz
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
function AutoScript {
## 编写一键执行脚本：
  touch /home/myid/jd/run-all.sh
  bash jd.sh | grep -o 'jd_[a-z].*' > run-all.sh
  bash jd.sh | grep -o 'jx_[a-z].*' >> run-all.sh
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
VERIFICATION=`node -v | cut -c2`
  if [ $VERIFICATION -eq "1" ]; then
    echo -e "\033[32m ------------------- 环境部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
    echo -e "\033[32m +=================================================================================================+ \033[0m"
    echo -e "\033[32m | 注意：该项目主运行目录为/home/myid/jd                                                           | \033[0m"
    echo -e "\033[32m | 注意：为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                      | \033[0m"
    if [ $SYSTEM = "Debian" ];then
      echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z 跳过继续执行剩余活动脚本        | \033[0m"
    elif [ $SYSTEM = "RedHat" ];then
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
SourceChange
EnvStructures
ProjectDeployment
CookieConfig
AutoScript
ResultJudgment
