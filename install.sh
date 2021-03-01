#!/bin/env bash
## Author:SuperManito
## Modified:2021-3-1

## ======================================== 说 明 =========================================================
##                                                                                                        #
## 项目名称：《京东薅羊毛》一键部署 For Linux                                                                #
## 项目用途：通过参与京东商城的各种活动白嫖京豆                                                               #
## 适用系统：仅支持 Debian 与 Redhat 发行版和及其衍生发行版                                                   #
## 温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文，CentOS如果是最小化安装，请通过SSH方式进入到终端   #
##                                                                                                        #
## 本项目基于 Evine 前辈公布的源码，目前由本人维护并继续开发                                                   #
## 本项目使用的活动脚本来自 lxk0301 大佬的 jd_scripts 项目                                                   #
## 本人能力有限，这可能是最终版本，感谢 Evine 对此项目做出的贡献                                               #
##                                                                                                        #
## ========================================================================================================

## ======================================= 定 义 相 关 变 量 ===============================================
## 安装目录
BASE="/opt/jd"
## 代理链接
Proxy_URL="https://ghproxy.com/"
## 项目分支
JD_BASE_BRANCH="source"
## 项目地址
JD_BASE_URL="https://github.com/SuperManito/JD-FreeFuck.git"
## 一键更新脚本地址a
Manual_Update_URL="https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/manual-update.sh"
## 私钥
KEY="-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn\nNhAAAAAwEAAQAAAQEAvRQk2oQqLB01iVnJKrnI3tTfJyEHzc2ULVor4vBrKKWOum4dbTeT\ndNWL5aS+CJso7scJT3BRq5fYVZcz5ra0MLMdQyFL1DdwurmzkhPYbwcNrJrB8abEPJ8ltS\nMoa0X9ecmSepaQFedZOZ2YeT/6AAXY+cc6xcwyuRVQ2ZJ3YIMBrRuVkF6nYwLyBLFegzhu\nJJeU5o53kfpbTCirwK0h9ZsYwbNbXYbWuJHmtl5tEBf2Hz+5eCkigXRq8EhRZlSnXfhPr2\n32VCb1A/gav2/YEaMPSibuBCzqVMVruP5D625XkxMdBdLqLBGWt7bCas7/zH2bf+q3zac4\nLcIFhkC6XwAAA9BjE3IGYxNyBgAAAAdzc2gtcnNhAAABAQC9FCTahCosHTWJWckqucje1N\n8nIQfNzZQtWivi8GsopY66bh1tN5N01YvlpL4ImyjuxwlPcFGrl9hVlzPmtrQwsx1DIUvU\nN3C6ubOSE9hvBw2smsHxpsQ8nyW1IyhrRf15yZJ6lpAV51k5nZh5P/oABdj5xzrFzDK5FV\nDZkndggwGtG5WQXqdjAvIEsV6DOG4kl5TmjneR+ltMKKvArSH1mxjBs1tdhta4kea2Xm0Q\nF/YfP7l4KSKBdGrwSFFmVKdd+E+vbfZUJvUD+Bq/b9gRow9KJu4ELOpUxWu4/kPrbleTEx\n0F0uosEZa3tsJqzv/MfZt/6rfNpzgtwgWGQLpfAAAAAwEAAQAAAQEAnMKZt22CBWcGHuUI\nytqTNmPoy2kwLim2I0+yOQm43k88oUZwMT+1ilUOEoveXgY+DpGIH4twusI+wt+EUVDC3e\nlyZlixpLV+SeFyhrbbZ1nCtYrtJutroRMVUTNf7GhvucwsHGS9+tr+96y4YDZxkBlJBfVu\nvdUJbLfGe0xamvE114QaZdbmKmtkHaMQJOUC6EFJI4JmSNLJTxNAXKIi3TUrS7HnsO3Xfv\nhDHElzSEewIC1smwLahS6zi2uwP1ih4fGpJJbU6FF/jMvHf/yByHDtdcuacuTcU798qT0q\nAaYlgMd9zrLC1OHMgSDcoz9/NQTi2AXGAdo4N+mnxPTHcQAAAIB5XCz1vYVwJ8bKqBelf1\nw7OlN0QDM4AUdHdzTB/mVrpMmAnCKV20fyA441NzQZe/52fMASUgNT1dQbIWCtDU2v1cP6\ncG8uyhJOK+AaFeDJ6NIk//d7o73HNxR+gCCGacleuZSEU6075Or2HVGHWweRYF9hbmDzZb\nCLw6NsYaP2uAAAAIEA3t1BpGHHek4rXNjl6d2pI9Pyp/PCYM43344J+f6Ndg3kX+y03Mgu\n06o33etzyNuDTslyZzcYUQqPMBuycsEb+o5CZPtNh+1klAVE3aDeHZE5N5HrJW3fkD4EZw\nmOUWnRj1RT2TsLwixB21EHVm7fh8Kys1d2ULw54LVmtv4+O3cAAACBANkw7XZaZ/xObHC9\n1PlT6vyWg9qHAmnjixDhqmXnS5Iu8TaKXhbXZFg8gvLgduGxH/sGwSEB5D6sImyY+DW/OF\nbmIVC4hwDUbCsTMsmTTTgyESwmuQ++JCh6f2Ams1vDKbi+nOVyqRvCrAHtlpaqSfv8hkjK\npBBqa/rO5yyYmeJZAAAAFHJvb3RAbmFzLmV2aW5lLnByZXNzAQIDBAUG\n-----END OPENSSH PRIVATE KEY-----"
## ========================================================================================================

## ======================================= 定 义 账 户 Cookie =======================================
## 京东账户
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'
##
## 配置京东账户注意事项：
## 1. 将 Cookie部分内容 填入"双引号"内，例 Cookie1='"pt_key=xxxxxx;pt_pin=xxxxxx;"'
## 2. 本项目可同时运行无限个账号，从第7个账户开始需要自行在项目 config.sh 配置文件中定义变量例如Cookie7=""
## ========================================================================================================

## 系统判定变量：
## 判定系统是基于 Debian 还是 RedHat
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
        CENTOS_VERSION=$(cat /etc/redhat-release | cut -c22)
    elif [ $SYSTEM_NAME = "Fedora" ]; then
        SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c16-18)
    fi
fi

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

## 环境搭建：
function EnvStructures() {
    echo -e ''
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
    sleep 2s
    ## CentOS 启用仓库
    if [ $SYSTEM_NAME = "CentOS" ]; then
        ## 安装扩展 EPEL 源
        yum install -y epel-release
        ## CentOS 8启用 PowerTools 仓库
        if [ $CENTOS_VERSION == "8" ]; then
            sed -i "s/enabled=0/enabled=1/g" /etc/yum.repos.d/*PowerTools.repo
        fi
        ## 重新建立缓存
        yum makecache
    fi
    ## 修改系统时区：
    timedatectl set-timezone "Asia/Shanghai"
    ## 基于 Debian 发行版和及其衍生发行版的软件包安装
    if [ $SYSTEM = "Debian" ]; then
        ## 卸载旧版本Node版本，从而确保安装新版本
        apt remove -y nodejs npm >/dev/null 2>&1
        rm -rf /etc/apt/sources.list.d/nodesource.list
        ## 安装需要的软件包
        apt install -y wget curl net-tools openssh-server git perl moreutils
        ## 安装Nodejs与NPM
        curl -sL https://deb.nodesource.com/setup_14.x | bash -
        sed -i '1,$d' /etc/apt/sources.list.d/nodesource.list
        echo "deb https://mirrors.ustc.edu.cn/nodesource/deb/node_14.x $SYSTEM_VERSION main" >>/etc/apt/sources.list.d/nodesource.list
        echo "deb-src https://mirrors.ustc.edu.cn/nodesource/deb/node_14.x $SYSTEM_VERSION main" >>/etc/apt/sources.list.d/nodesource.list
        apt update
        apt install -y nodejs
        apt autoremove -y
    ## 基于 RedHat 发行版和及其衍生发行版的软件包安装
    elif [ $SYSTEM = "RedHat" ]; then
        ## 卸载旧版本Node版本，从而确保安装新版本
        yum remove -y nodejs npm >/dev/null 2>&1
        rm -rf /etc/yum.repos.d/nodesource-*.repo
        ## 安装需要的软件包
        yum install -y wget curl net-tools openssh-server git perl moreutils
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
        echo -e '\033[37m常规方法未成功安装 nodejs ，开始执行备用方案，下载网速可能过慢请耐心等候...... \033[0m'
        sleep 3s
        if [ $SYSTEM = "Debian" ]; then
            apt remove -y nodejs npm >/dev/null 2>&1
            rm -rf /etc/apt/sources.list.d/nodesource.list
            curl -sL https://deb.nodesource.com/setup_14.x | bash -
            apt install -y nodejs
        elif [ $SYSTEM = "RedHat" ]; then
            yum remove -y nodejs npm >/dev/null 2>&1
            rm -rf /etc/yum.repos.d/nodesource-*.repo
            curl -sL https://rpm.nodesource.com/setup_14.x | bash -
            apt install -y nodejs
        fi
    fi
}

## 安装私钥：
function PrivateKeyInstallation() {
    mkdir -p /root/.ssh
    ## 检测当前用户是否存在私钥，如存在执行备份操作
    ls /root/.ssh | grep id_rsa.bak -wq
    if [ $? -eq 0 ]; then
        rm -rf /root/.ssh/id_rsa
        echo -e "\033[31m检测到已备份的私钥，跳过备份操作...... \033[0m"
        sleep 2s
    else
        mv /root/.ssh/id_rsa /root/.ssh/id_rsa.bak >/dev/null 2>&1
    fi
    ## 检测当前用户是否存在公钥，如存在执行备份操作
    ls /root/.ssh | grep id_rsa.pub.bak -wq
    if [ $? -eq 0 ]; then
        rm -rf /root/.ssh/id_rsa.pub
        echo -e "\033[31m检测到已备份的公钥，跳过备份操作...... \033[0m"
        sleep 2s
    else
        mv /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub.bak >/dev/null 2>&1
    fi
    ## 安装私钥
    chmod 700 /root/.ssh
    cd /root/.ssh
    echo -e $KEY >/root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
    ssh-keyscan gitee.com >/root/.ssh/known_hosts
}

## 项目部署：
function ProjectDeployment() {
    ## 克隆源码
    git clone -b $JD_BASE_BRANCH $Proxy_URL$JD_BASE_URL $BASE
    ## 创建目录
    mkdir $BASE/config
    mkdir $BASE/log
    ## 配置定时任务的所在目录
    sed -i "s#BASE#$BASE#g" $BASE/sample/computer.list.sample
    ## 创建项目配置文件与定时任务配置文件
    cp $BASE/sample/config.sh.sample $BASE/config/config.sh
    cp $BASE/sample/computer.list.sample $BASE/config/crontab.list
    ## 拉取活动脚本
    bash $BASE/git_pull.sh
    bash $BASE/git_pull.sh >/dev/null 2>&1

}

## 安装控制面板：
function PanelInstallation() {
    ## 安装控制面板功能
    firewall-cmd --zone=public --add-port=5678/tcp --permanent >/dev/null 2>&1
    systemctl reload firewalld >/dev/null 2>&1
    cp $BASE/sample/auth.json $BASE/config/auth.json
    cd $BASE/panel
    npm install || npm install --registry=https://registry.npm.taobao.org
    npm install -g pm2
    pm2 start server.js
    cd $BASE
    ## 赋权所有项目文件
    chmod 777 $BASE/*
    ## 判定控制面板是否安装成功
    netstat -anp | grep 5678 -wq
    if [ $? -eq 0 ]; then
        echo -e ''
        echo -e ''
        echo -e "\033[32m +--------- 控 制 面 板 安 装 成 功 并 已 启 动 ---------+ \033[0m"
        echo -e "\033[32m |                                                       | \033[0m"
        echo -e "\033[32m |      本地访问：http://127.0.0.1:5678                  | \033[0m"
        echo -e "\033[32m |                                                       | \033[0m"
        echo -e "\033[32m |      外部访问：http://内部或外部IP地址:5678           | \033[0m"
        echo -e "\033[32m |                                                       | \033[0m"
        echo -e "\033[32m |      初始用户名：useradmin  初始密码：supermanito     | \033[0m"
        echo -e "\033[32m |                                                       | \033[0m"
        echo -e "\033[32m |      控制面板默认开机自启，如若失效请自行重启         | \033[0m"
        echo -e "\033[32m |                                                       | \033[0m"
        echo -e "\033[32m |      关于更多使用帮助请通过《使用与更新》教程获取     | \033[0m"
        echo -e "\033[32m |                                                       | \033[0m"
        echo -e "\033[32m +-------------------------------------------------------+ \033[0m"

    else
        echo -e ''
        echo -e "\033[31m ------------------- 控制面板安装失败 ------------------- \033[0m"
    fi
    echo -e ''
    echo -e ''
    sleep 3s
}

## 更改配置文件：
function SetConfig() {
    sed -i "35c Cookie1=$COOKIE1" $BASE/config/config.sh
    sed -i "36c Cookie2=$COOKIE2" $BASE/config/config.sh
    sed -i "37c Cookie3=$COOKIE3" $BASE/config/config.sh
    sed -i "38c Cookie4=$COOKIE4" $BASE/config/config.sh
    sed -i "39c Cookie5=$COOKIE5" $BASE/config/config.sh
    sed -i "40c Cookie6=$COOKIE6" $BASE/config/config.sh
}

## 一键脚本：
function AutoScript() {
    ## 编写 run-all 一键执行所有活动脚本
    touch $BASE/run-all.sh
    bash $BASE/jd.sh | grep -o 'j[drx]_[a-z].*' >$BASE/run-all.sh
    sed -i "s#^#bash $BASE/jd.sh &#g" $BASE/run-all.sh
    sed -i 's#.js# now#g' $BASE/run-all.sh
    sed -i '1i\#!/bin/bash' $BASE/run-all.sh
    cat $BASE/run-all.sh | grep jd_crazy_joy_coin -wq
    if [ $? -eq 0 ]; then
        sed -i '/jd_crazy_joy_coin/d' $BASE/run-all.sh
        echo "bash $BASE/jd.sh jd_crazy_joy_coin now" >>$BASE/run-all.sh
    fi
    ## 去除不需要加入到此脚本中的活动
    sed -i '/jd_delCoupon/d' $BASE/run-all.sh ## 不执行 "京东家庭号" 任务
    sed -i '/jd_family/d' $BASE/run-all.sh    ## 不执行 "删除优惠券" 任务
    ## 去除脚本中的空行
    sed -i '/^\s*$/d' $BASE/run-all.sh
    ## 下载最新的 manual-update 一键更新脚本
    wget -q $Proxy_URL$Manual_Update_URL -O $BASE/manual-update.sh
    if [ $? -ne 0 ]; then
        echo -e ''
        echo -e "\033[31m -------------- 一键更新脚本下载失败 -------------- \033[0m"
        echo -e ''
    fi
}

## 使用需知：
function UseNotes() {
    echo -e "\033[32m --------------------------- 一键部署成功，请执行 bash run-all.sh 命令开始您的薅羊毛行为 --------------------------- \033[0m"
    echo -e ''
    echo -e "\033[32m +=================================================================================================================+ \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 定义：run-all.sh 为一键执行所有活动脚本，manual-update.sh 为一键更新脚本                                        | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       如果想要执行特定活动脚本，请通过命令 bash jd.sh 查看教程                                                  | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 注意：1. 该项目文件以及一键脚本的安装目录为$BASE                                                              | \033[0m"
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
    echo -e ''
    echo -e "\033[32m --------------------------- 更多帮助请访问   https://github.com/SuperManito/JD-FreeFuck --------------------------- \033[0m"
    echo -e "\033[32m --------------------------- Github & Gitee   https://gitee.com/SuperManito/JD-FreeFuck  --------------------------- \033[0m"
    echo -e ''
}

## 执行相关函数开始部署：
## 根据各部分函数执行结果判定部署结果，判断环境条件决定是否退出部署脚本
function Installation() {
    EnvJudgment
    EnvStructures
    ## 判定Nodejs是否安装成功，若成功开始部署项目，否则跳出
    VERIFICATION=$(node -v | cut -c2-3)
    if [ $VERIFICATION = "14" ]; then
        PrivateKeyInstallation
        ## 判定私钥是否安装成功，若成功开始部署项目，否则跳出
        ls /root/.ssh | grep id_rsa -wq
        if [ $? -eq 0 ]; then
            ProjectDeployment
            PanelInstallation
            SetConfig
            AutoScript
            UseNotes
        else
            echo -e ''
            echo -e "\033[31m -------------- 私钥安装失败，退出部署脚本 -------------- \033[0m"
            echo -e "\033[31m 原因：1. 在 /root/.ssh 目录下没有检测到私钥文件 \033[0m"
            echo -e "\033[31m      2. 可能由于 /root/.ssh 目录创建失败导致私 \033[0m"
            exit
        fi
    else
        echo -e ''
        echo -e "\033[31m -------------- 一键部署失败，退出部署脚本 -------------- \033[0m"
        echo -e "\033[31m 原因：1. Nodejs未安装成功，请检查网络相关问题 \033[0m"
        echo -e "\033[31m      2. 或由于其它软件包未安装成功间接导致 Nodejs 安装失败 \033[0m"
        exit
    fi
}
Installation
