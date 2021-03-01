#!/bin/bash
#Author:SuperManito

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
  echo -e '\033[37m|         欢迎使用 Linux 一键更换国内源脚本         | \033[0m'
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

SystemJudgment
ReplaceMirror
