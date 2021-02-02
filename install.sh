#!/bin/bash
#Author:SuperManito
#Modified:2021-2-3

## 项目名称:《京东薅羊毛》一键部署 For Linux，通过参与京东商城的各种活动白嫖京豆
## 适用系统: Ubuntu 16.04 ~ 20.10 | Debian 9.0 ~ 10.7 | CentOS 8.0 ~ 8.3 | Fedora 32 ~ 33
## 请确认安装环境是否支持简体中文，CentOS如果是最小化安装，请通过SSH方式进入到终端

## 如果需要在此一键脚本中直接配置Config配置文件，请定义下面的变量
## 本项目可同时运行无限个账号，从第7个账户开始需要自行在项目Config.sh配置文件中定义变量

## 将Cookie部分内容填入"双引号"内：
## 例：COOKIE1='"pt_key=xxxxxx;pt_pin=xxxxxx;"'
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'

## Server酱微信推送功能，将SCKEY填入"双引号"内：
SERVERJIANG='""'


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
  RedHatOfficialMirror
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

## 生成基于RedHat系Linux发行版的repo官方更新源：
function RedHatOfficialMirror() {
  SYSTEM_NAME=$(cat /etc/redhat-release | cut -c1-6)
  CENTOS_VERSION=$(cat /etc/redhat-release | cut -c22)
  ls /etc | grep yum.repos.d.bak -qw
  if [ $? -eq 0 ]; then
    echo -e '\033[32m检测到已备份的 repo源 文件，跳过备份操作...... \033[0m'
  else
    mkdir -p /etc/yum.repos.d.bak
    cp -rf /etc/yum.repos.d/* /etc/yum.repos.d.bak
    echo -e '\033[32m已备份原有 repo源 文件至 /etc/yum.repos.d.bak ...... \033[0m'
  fi
    sleep 3s
  if [ $CENTOS_VERSION = "8" ]; then
    rm -rf /etc/yum.repos.d/CentOS-Linux-AppStream.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-ContinuousRelease.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Debuginfo.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Devel.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Extras.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-FastTrack.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-HighAvailability.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Media.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Plus.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
    rm -rf /etc/yum.repos.d/CentOS-Linux-Sources.repo
    touch /etc/yum.repos.d/CentOS-Linux-AppStream.repo
    touch /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
    touch /etc/yum.repos.d/CentOS-Linux-ContinuousRelease.repo
    touch /etc/yum.repos.d/CentOS-Linux-Debuginfo.repo
    touch /etc/yum.repos.d/CentOS-Linux-Devel.repo
    touch /etc/yum.repos.d/CentOS-Linux-Extras.repo
    touch /etc/yum.repos.d/CentOS-Linux-FastTrack.repo
    touch /etc/yum.repos.d/CentOS-Linux-HighAvailability.repo
    touch /etc/yum.repos.d/CentOS-Linux-Media.repo
    touch /etc/yum.repos.d/CentOS-Linux-Plus.repo
    touch /etc/yum.repos.d/CentOS-Linux-PowerTools.repo
    touch /etc/yum.repos.d/CentOS-Linux-Sources.repo
    cat >/etc/yum.repos.d/CentOS-Linux-AppStream.repo <<\EOF
# CentOS-Linux-AppStream.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[appstream]
name=CentOS Linux $releasever - AppStream
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=AppStream&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/AppStream/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-BaseOS.repo <<\EOF
# CentOS-Linux-BaseOS.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[baseos]
name=CentOS Linux $releasever - BaseOS
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=BaseOS&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-ContinuousRelease.repo <<\EOF
# CentOS-Linux-ContinuousRelease.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.
#
# The Continuous Release (CR) repository contains packages for the next minor
# release of CentOS Linux.  This repository only has content in the time period
# between an upstream release and the official CentOS Linux release.  These
# packages have not been fully tested yet and should be considered beta
# quality.  They are made available for people willing to test and provide
# feedback for the next release.

[cr]
name=CentOS Linux $releasever - ContinuousRelease
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=cr&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/cr/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Debuginfo.repo <<\EOF
# CentOS-Linux-Debuginfo.repo
#
# All debug packages are merged into a single repo, split by basearch, and are
# not signed.

[debuginfo]
name=CentOS Linux $releasever - Debuginfo
baseurl=http://debuginfo.centos.org/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Devel.repo <<\EOF
# CentOS-Linux-Devel.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[devel]
name=CentOS Linux $releasever - Devel WARNING! FOR BUILDROOT USE ONLY!
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=Devel&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/Devel/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Extras.repo <<\EOF
# CentOS-Linux-Extras.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[extras]
name=CentOS Linux $releasever - Extras
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/extras/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-FastTrack.repo <<\EOF
# CentOS-Linux-FastTrack.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[fasttrack]
name=CentOS Linux $releasever - FastTrack
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/fasttrack/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-HighAvailability.repo <<\EOF
# CentOS-Linux-HighAvailability.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[ha]
name=CentOS Linux $releasever - HighAvailability
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=HighAvailability&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/HighAvailability/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Media.repo <<\EOF
# CentOS-Linux-Media.repo
#
# You can use this repo to install items directly off the installation media.
# Verify your mount point matches one of the below file:// paths.

[media-baseos]
name=CentOS Linux $releasever - Media - BaseOS
baseurl=file:///media/CentOS/BaseOS
        file:///media/cdrom/BaseOS
        file:///media/cdrecorder/BaseOS
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[media-appstream]
name=CentOS Linux $releasever - Media - AppStream
baseurl=file:///media/CentOS/AppStream
        file:///media/cdrom/AppStream
        file:///media/cdrecorder/AppStream
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Plus.repo <<\EOF
# CentOS-Linux-Plus.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[plus]
name=CentOS Linux $releasever - Plus
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/centosplus/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-PowerTools.repo <<\EOF
# CentOS-Linux-PowerTools.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[powertools]
name=CentOS Linux $releasever - PowerTools
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=PowerTools&infra=$infra
#baseurl=http://mirror.centos.org/$contentdir/$releasever/PowerTools/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    cat >/etc/yum.repos.d/CentOS-Linux-Sources.repo <<\EOF
# CentOS-Linux-Sources.repo


[baseos-source]
name=CentOS Linux $releasever - BaseOS - Source
baseurl=http://vault.centos.org/$contentdir/$releasever/BaseOS/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[appstream-source]
name=CentOS Linux $releasever - AppStream - Source
baseurl=http://vault.centos.org/$contentdir/$releasever/AppStream/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[extras-source]
name=CentOS Linux $releasever - Extras - Source
baseurl=http://vault.centos.org/$contentdir/$releasever/extras/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[plus-source]
name=CentOS Linux $releasever - Plus - Source
baseurl=http://vault.centos.org/$contentdir/$releasever/centosplus/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
  elif [ $CENTOS_VERSION = "7" ]; then
    rm -rf /etc/yum.repos.d/CentOS-BaseOS.repo
    rm -rf /etc/yum.repos.d/CentOS-CR.repo
    rm -rf /etc/yum.repos.d/CentOS-Debuginfo.repo
    rm -rf /etc/yum.repos.d/CentOS-fasttrack.repo
    rm -rf /etc/yum.repos.d/CentOS-Media.repo
    rm -rf /etc/yum.repos.d/CentOS-Sources.repo
    rm -rf /etc/yum.repos.d/CentOS-Vault.repo
    touch /etc/yum.repos.d/CentOS-BaseOS.repo
    touch /etc/yum.repos.d/CentOS-CR.repo
    touch /etc/yum.repos.d/CentOS-Debuginfo.repo
    touch /etc/yum.repos.d/CentOS-fasttrack.repo
    touch /etc/yum.repos.d/CentOS-Media.repo
    touch /etc/yum.repos.d/CentOS-Sources.repo
    touch /etc/yum.repos.d/CentOS-Vault.repo
    cat >/etc/yum.repos.d/CentOS-BaseOS.repo <<\EOF
# CentOS-Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the 
# remarked out baseurl= line instead.
#
#

[base]
name=CentOS-$releasever - Base
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates 
[updates]
name=CentOS-$releasever - Updates
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
    cat >/etc/yum.repos.d/CentOS-CR.repo <<\EOF
# CentOS-CR.repo
#
# The Continuous Release ( CR )  repository contains rpms that are due in the next
# release for a specific CentOS Version ( eg. next release in CentOS-7 ); these rpms
# are far less tested, with no integration checking or update path testing having
# taken place. They are still built from the upstream sources, but might not map 
# to an exact upstream distro release.
#
# These packages are made available soon after they are built, for people willing 
# to test their environments, provide feedback on content for the next release, and
# for people looking for early-access to next release content.
#
# The CR repo is shipped in a disabled state by default; its important that users 
# understand the implications of turning this on. 
#
# NOTE: We do not use a mirrorlist for the CR repos, to ensure content is available
#       to everyone as soon as possible, and not need to wait for the external
#       mirror network to seed first. However, many local mirrors will carry CR repos
#       and if desired you can use one of these local mirrors by editing the baseurl
#       line in the repo config below.
#

[cr]
name=CentOS-$releasever - cr
baseurl=http://mirror.centos.org/centos/$releasever/cr/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=0
EOF
    cat >/etc/yum.repos.d/CentOS-Debuginfo.repo <<\EOF
# CentOS-Debug.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#

# All debug packages from all the various CentOS-7 releases
# are merged into a single repo, split by BaseArch
#
# Note: packages in the debuginfo repo are currently not signed
#

[base-debuginfo]
name=CentOS-7 - Debuginfo
baseurl=http://debuginfo.centos.org/7/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-7
enabled=0
#
EOF
    cat >/etc/yum.repos.d/CentOS-fasttrack.repo <<\EOF
[fasttrack]
name=CentOS-7 - fasttrack
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/fasttrack/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
    cat >/etc/yum.repos.d/CentOS-Media.repo <<\EOF
# CentOS-Media.repo
#
#  This repo can be used with mounted DVD media, verify the mount point for
#  CentOS-7.  You can use this repo and yum to install items directly off the
#  DVD ISO that we release.
#
# To use this repo, put in your DVD and use it with the other repos too:
#  yum --enablerepo=c7-media [command]
#  
# or for ONLY the media repo, do this:
#
#  yum --disablerepo=\* --enablerepo=c7-media [command]

[c7-media]
name=CentOS-$releasever - Media
baseurl=file:///media/CentOS/
        file:///media/cdrom/
        file:///media/cdrecorder/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
    cat >/etc/yum.repos.d/CentOS-Sources.repo <<\EOF
# CentOS-Sources.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the 
# remarked out baseurl= line instead.
#
#

[base-source]
name=CentOS-$releasever - Base Sources
baseurl=http://vault.centos.org/centos/$releasever/os/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates 
[updates-source]
name=CentOS-$releasever - Updates Sources
baseurl=http://vault.centos.org/centos/$releasever/updates/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras-source]
name=CentOS-$releasever - Extras Sources
baseurl=http://vault.centos.org/centos/$releasever/extras/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus-source]
name=CentOS-$releasever - Plus Sources
baseurl=http://vault.centos.org/centos/$releasever/centosplus/Source/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
  elif [ $SYSTEM_NAME = "Fedora" ]; then
    rm -rf /etc/yum.repos.d/fedora-cisco-openh264.repo
    rm -rf /etc/yum.repos.d/fedora.repo
    rm -rf /etc/yum.repos.d/fedora-updates.repo
    rm -rf /etc/yum.repos.d/fedora-modular.repo
    rm -rf /etc/yum.repos.d/fedora-updates-modular.repo
    rm -rf /etc/yum.repos.d/fedora-updates-testing.repo
    rm -rf /etc/yum.repos.d/fedora-updates-testing-modular.repo
    touch /etc/yum.repos.d/fedora-cisco-openh264.repo
    touch /etc/yum.repos.d/fedora.repo
    touch /etc/yum.repos.d/fedora-updates.repo
    touch /etc/yum.repos.d/fedora-modular.repo
    touch /etc/yum.repos.d/fedora-updates-modular.repo
    touch /etc/yum.repos.d/fedora-updates-testing.repo
    touch /etc/yum.repos.d/fedora-updates-testing-modular.repo
    cat >/etc/yum.repos.d/fedora-cisco-openh264.repo <<\EOF
[fedora-cisco-openh264]
name=Fedora $releasever openh264 (From Cisco) - $basearch
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-cisco-openh264-$releasever&arch=$basearch
type=rpm
enabled=1
metadata_expire=14d
repo_gpgcheck=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=True

[fedora-cisco-openh264-debuginfo]
name=Fedora $releasever openh264 (From Cisco) - $basearch - Debug
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-cisco-openh264-debug-$releasever&arch=$basearch
type=rpm
enabled=0
metadata_expire=14d
repo_gpgcheck=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=True
EOF
    cat >/etc/yum.repos.d/fedora.repo <<\EOF
[fedora]
name=Fedora $releasever - $basearch
#baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/$basearch/debug/tree/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-debug-$releasever&arch=$basearch
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False

[fedora-source]
name=Fedora $releasever - Source
#baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Everything/source/tree/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-source-$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/$basearch/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/$basearch/debug/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-debug-f$releasever&arch=$basearch
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False

[updates-source]
name=Fedora $releasever - Updates Source
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Everything/SRPMS/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-source-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/$basearch/os/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-modular-$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/$basearch/debug/tree/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-modular-debug-$releasever&arch=$basearch
enabled=0
metadata_expire=7d
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False

[fedora-modular-source]
name=Fedora Modular $releasever - Source
#baseurl=http://download.example/pub/fedora/linux/releases/$releasever/Modular/source/tree/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-modular-source-$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-modular-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/debug/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-modular-debug-f$releasever&arch=$basearch
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False

[updates-modular-source]
name=Fedora Modular $releasever - Updates Source
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/SRPMS/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-modular-source-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/$basearch/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/$basearch/debug/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-debug-f$releasever&arch=$basearch
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False

[updates-testing-source]
name=Fedora $releasever - Test Updates Source
#baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Everything/SRPMS/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-source-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/testing/$releasever/Modular/$basearch/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-modular-f$releasever&arch=$basearch
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
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/$basearch/debug/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-modular-debug-f$releasever&arch=$basearch
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False

[updates-testing-modular-source]
name=Fedora Modular $releasever - Test Updates Source
#baseurl=http://download.example/pub/fedora/linux/updates/$releasever/Modular/SRPMS/
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-modular-source-f$releasever&arch=$basearch
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=False
EOF
  fi
}

## 环境搭建：
function EnvStructures() {
  ## 安装Docker
  if [ $SYSTEM = "Debian" ]; then
    DOCKERJUDGMENT="dpkg -l"
  elif [ $SYSTEM = "RedHat" ]; then
    DOCKERJUDGMENT="rpm -qa"
  fi
  $DOCKERJUDGMENT | grep docker -wq  
  if [ $? -ne 0 ];then
    if [ $SYSTEM_NAME = "Ubuntu" ]; then
      apt remove -y docker docker-engine docker.io containerd runc
      apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
      add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $SYSTEM_VERSION stable"
      apt update
      apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Debian" ]; then
      apt remove -y docker docker-engine docker.io containerd runc
      apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
      curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
      add-apt-repository -y "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian $SYSTEM_VERSION stable"
      apt update
      apt install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "CentOS" ]; then
      firewall-cmd --zone=public --add-port=5678/tcp --permanent
      systemctl reload firewalld
      yum remove -y docker* runc
      yum install -y yum-utils device-mapper-persistent-data lvm2
      yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
      yum makecache
      yum install -y docker-ce docker-ce-cli containerd.io
    elif [ $SYSTEM_NAME = "Fedora" ]; then
      firewall-cmd --zone=public --add-port=5678/tcp --permanent
      systemctl reload firewalld
      yum remove -y docker* runc
      yum -y install yum-utils device-mapper-persistent-data lvm2
      yum config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/fedora/docker-ce.repo
      yum makecache
      yum install -y docker-ce docker-ce-cli containerd.io
    else
      firewall-cmd --zone=public --add-port=5678/tcp --permanent
      systemctl reload firewalld
    fi
  fi
  ## 配置国内镜像仓库加速
  ls /etc | grep /docker/daemon.json -wq
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
  ## 从镜像仓库中拉取大佬镜像
  docker pull evinedeng/jd:gitee
}

## 项目部署：
function ProjectDeployment() {
  ## 启动容器
  docker run -dit \
  -v /opt/jd/config:/jd/config `# 设置配置文件的主机挂载目录为/opt` \
  -v /opt/jd/log:/jd/log `# 设置日志的主机挂载目录为/opt` \
  -p 5678:5678 `# 设置端口映射，格式为 "内部端口号:外部端口号" ，外部端口号可自定义` \
  -e ENABLE_HANGUP=true `# 启用挂机功能` \
  -e ENABLE_WEB_PANEL=true `# 启用控制面板功能` \
  --name jd `# 设置容器名为jd` \
  --network bridge `# 设置网络为桥接，直连主机` \
  --hostname jd `# 设置主机名为jd` \
  --restart always `# 设置容器开机自启` \
  evinedeng/jd:gitee
}

## 一键脚本：
function AutoScript() {
  docker exec -it jd bash git_pull.sh > /dev/null 2>&1
  ## 编写一键执行所有活动脚本：
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
cat /opt/jd/run-all.sh | grep jd_crazy_joy_coin -wq
if [ $? -eq 0 ];then
  sed -i "s/docker exec -it jd bash jd.sh jd_crazy_joy_coin now//g" /opt/jd/run-all.sh
  sed -i '/^\s*$/d' /opt/jd/run-all.sh
  echo "docker exec -it jd bash jd.sh jd_crazy_joy_coin now" >>/opt/jd/run-all.sh
fi
dos2unix /opt/jd/run-all.sh
EOF
  if [ $SYSTEM = "Debian" ]; then
    apt install -y dos2unix
  elif [ $SYSTEM = "RedHat" ]; then
    yum install -y dos2unix
  fi
  ## 格式化一键脚本
  dos2unix /opt/jd/run-all.sh
  dos2unix /opt/jd/manual-update.sh
  ## 更新活动脚本
  bash /opt/jd/manual-update.sh
}

## 更改配置文件：
function SetConfig() {
  sed -i "27c Cookie1=$COOKIE1" /opt/jd/config/config.sh
  sed -i "28c Cookie2=$COOKIE2" /opt/jd/config/config.sh
  sed -i "29c Cookie3=$COOKIE3" /opt/jd/config/config.sh
  sed -i "30c Cookie4=$COOKIE4" /opt/jd/config/config.sh
  sed -i "31c Cookie5=$COOKIE5" /opt/jd/config/config.sh
  sed -i "32c Cookie6=$COOKIE6" /opt/jd/config/config.sh
  sed -i "70c export PUSH_KEY=$SERVERJIANG" /opt/jd/config/config.sh
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
    echo -e "\033[32m --------------------- 一键部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 --------------------- \033[0m"
    echo -e "\033[32m +=====================================================================================================+ \033[0m"
    echo -e "\033[32m | 注意：1. 该项目配置文件以及一键脚本所在目录为/opt/jd                                                | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       2. 此项目涉及 Docker 容器技术，如果你对 Docker基础命令 一无所知，那么请不要随意改动容器       | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       3. 执行 run-all 脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl+C 跳过继续执行剩余活动脚本  | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       4. 由于京东活动一直变化所以会出现无法参加活动、报错等正常现象，可手动更新活动脚本             | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       5. 如果需要更新活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可                    | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       6. 之前填入的 Cookie 部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新 | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       7. 如果需要查看帮助文档以及获取更多功能，请通过 docker exec -it jd cat readme.md 命令进行查看 | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m | 定义：run-all.sh 为本人编写的一键执行所有活动脚本，manual-update.sh 为本人编写的一键更新脚本        | \033[0m"
    echo -e "\033[32m |                                                                                                     | \033[0m"
    echo -e "\033[32m |       仍可通过原作者 docker exec -it jd bash jd.sh 命令查看活动列表并执行特定活动脚本               | \033[0m"
    echo -e "\033[32m +=====================================================================================================+ \033[0m"
    echo -e "\033[32m --------------------- 更多帮助请访问:  https://github.com/SuperManito/JD-FreeFuck --------------------- \033[0m"
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
SetConfig
ResultJudgment
