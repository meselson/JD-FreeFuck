#!/bin/bash
## Author:SuperManito
## Modified:2021-2-18

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
  ## 定义一些变量（系统名称、系统版本、系统版本号）
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
  ## 由此到第1000行的内容均为更换国内更新源
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
  ## 安装CentOS扩展EPEL源并启用PowerTools仓库
  if [ $SYSTEM_NAME = "CentOS" ]; then
    yum install -y epel-release
    sed -i 's|^metalink=|#metalink=|g' /etc/yum.repos.d/epel.repo
    sed -i 's|^#baseurl=https\?://download.fedoraproject.org/pub/epel/|baseurl=https://mirrors.ustc.edu.cn/epel/|g' /etc/yum.repos.d/epel.repo
    yum makecache
  fi
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
enabled=1
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
  ## 基于 Debian 的安装方法
  if [ $SYSTEM = "Debian" ]; then
    ## 卸载旧版本Node版本，从而确保安装新版本
    apt remove -y nodejs npm >/dev/null 2>&1
    rm -rf /etc/apt/sources.list.d/nodesource.list >/dev/null 2>&1
    ## 安装需要的软件包
    apt install -y git wget curl perl moreutils
    ## 安装Nodejs与NPM
    curl -sL https://deb.nodesource.com/setup_14.x | bash -
    sed -i '1,$d' /etc/apt/sources.list.d/nodesource.list
    echo "deb https://mirrors.ustc.edu.cn/nodesource/deb/node_14.x $SYSTEM_VERSION main" >>/etc/apt/sources.list.d/nodesource.list
    echo "deb-src https://mirrors.ustc.edu.cn/nodesource/deb/node_14.x $SYSTEM_VERSION main" >>/etc/apt/sources.list.d/nodesource.list
    apt update
    apt install -y nodejs
    apt autoremove -y
  ## 基于 RedHat 的安装方法
  elif [ $SYSTEM = "RedHat" ]; then
    ## 卸载旧版本Node版本，从而确保安装新版本
    yum remove -y nodejs npm >/dev/null 2>&1
    rm -rf /etc/yum.repos.d/nodesource-*.repo >/dev/null 2>&1
    ## 安装需要的软件包
    yum install -y git wget curl perl moreutils
    ## 安装Nodejs与NPM
    curl -sL https://rpm.nodesource.com/setup_14.x | bash -
    sed -i "s#rpm.nodesource.com#mirrors.ustc.edu.cn/nodesource/rpm#" /etc/yum.repos.d/nodesource-*.repo
    yum makecache
    yum install -y nodejs
    yum autoremove -y
  fi
  ## 安装Nodejs与NPM备用方案
  VERIFICATION=$(node -v | cut -c2)
  if [ $VERIFICATION != 1 ]; then
    echo -e '\033[37m常规方法未安装成功，正在执行备用方案，下载网速可能过慢请耐心等候...... \033[0m'
    sleep 3s
    if [ $SYSTEM = "Debian" ]; then
      apt remove -y nodejs npm >/dev/null 2>&1
      rm -rf /etc/apt/sources.list.d/nodesource.list >/dev/null 2>&1
      curl -sL https://deb.nodesource.com/setup_14.x | bash -
      apt install -y nodejs
    elif [ $SYSTEM = "RedHat" ]; then
      yum remove -y nodejs npm >/dev/null 2>&1
      rm -rf /etc/yum.repos.d/nodesource-*.repo >/dev/null 2>&1
      curl -sL https://rpm.nodesource.com/setup_14.x | bash -
      apt install -y nodejs
    fi
  fi
}

## 项目部署：
function ProjectDeployment() {
  ## 检测是否存在之前Docker旧版本的配置文件，执行备份操作
  ls /opt | grep jd/config -wq
  if [ $? -eq 0 ]; then
    cp /opt/jd/config/config.sh /opt/config.sh.bak
    cp /opt/jd/config/crontab.list /opt/crontab.list.bak
    rm -rf /opt/jd
  fi
  ## 下载源码并解压至目录
  wget -P /opt https://gitee.com/SuperManito/JD-FreeFuck/attach_files/610490/download/jd.tar.gz
  mkdir -p $BASE
  tar -zxvf /opt/jd.tar.gz -C $BASE
  rm -rf /opt/jd.tar.gz
  mkdir $BASE/config
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
  ## 编写一键执行所有活动脚本：
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
  ## 编写一键更新脚本：
  touch $BASE/manual-update.sh
  cat >$BASE/manual-update.sh <<\EOF
#!/bin/bash
## 项目安装目录
BASE="/opt/jd"

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
sed -i "s#/home/myid/jd#$BASE#g" $BASE/config/crontab.list
EOF
}

#部署结果判定：
function ResultJudgment() {
  ## 判定旧版本配置文件备份结果
  ls /opt | grep jd/config.sh.bak -wq
  if [ $? -eq 0 ]; then
    echo -e "\033[32m安装期间检测到旧版本项目文件，已备份旧的 config 与 crontab 配置文件至/opt目录，请不要覆盖现有配置文件...... \033[0m"
    sleep 3s
  fi
  ## 判定Nodejs是否安装成功
  VERIFICATION=$(node -v | cut -c2)
  if [ $VERIFICATION = "1" ]; then
    echo -e ''
    echo -e "\033[32m +------- 已 启 用 控 制 面 板 功 能 -------+ \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m | 本地访问：http://127.0.0.1:5678          | \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m | 外部访问：http://内部或外部IP地址:5678   | \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m | 初始用户名：admin，初始密码：adminadmin  | \033[0m"
    echo -e "\033[32m |                                          | \033[0m"
    echo -e "\033[32m +------------------------------------------+ \033[0m"
    echo -e ''
    sleep 3s
    echo -e "\033[32m --------------------------- 一键部署成功，请执行 bash run-all.sh 命令开始你的薅羊毛行为 --------------------------- \033[0m"
    echo -e "\033[32m +=================================================================================================================+ \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 定义：run-all.sh 为一键执行所有活动脚本，manual-update.sh 为一键更新脚本                                        | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       如果想要单独执行或延迟执行特定活动脚本，请通过命令 bash jd.sh 查看教程                                    | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 注意：1. 该项目文件以及一键脚本的默认所在目录为$BASE                                                          | \033[0m"
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
    echo -e "\033[32m |       6. 如果需要更新活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可，它会同步更新 run-all.sh 脚本  | \033[0m"
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
    echo -e "\033[32m --------------------------- 更多帮助请访问:  https://github.com/SuperManito/JD-FreeFuck --------------------------- \033[0m"
    echo -e ''
    echo -e "\033[32m ---------------------------------------- 如果老板成功薅到羊毛，赏5块钱可否 ---------------------------------------- \033[0m"
  else
    echo -e "\033[31m -------------- 一键部署失败 -------------- \033[0m"
    echo -e "\033[31m 原因：Nodejs未安装成功，请检查网络相关问题 \033[0m"
  fi
}

EnvJudgment
SystemJudgment
ReplaceMirror
EnvStructures
ProjectDeployment
SetConfig
AutoScript
ResultJudgment
