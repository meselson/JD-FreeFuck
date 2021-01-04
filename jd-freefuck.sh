#!/bin/bash
#Author；King'S HAN
#《京东薅羊毛》一键部署脚本，通过参与京东商城的各种活动白嫖京豆
#本人为了懒人一键部署而写此脚本，此脚本内容涵盖编写了所有该项目所需要的环境软件包和原创一键脚本
#此脚本核心内容来自于lxk0301大神托管至GitHub的项目，定期更新核心JavaScript脚本内容
#原作者官方托管GitHub项目网址：
#https://github.com/EvineDeng/jd-base   #此环境原作者
#https://github.com/lxk0301/jd_scripts  #此项目核心JavaScript脚本原作者
#适用系统：CentOS 8简体中文，不适用7及更低版本，本人测试环境为最新CentOS 8.2，系统装完后联网即可，无需其它任何操作
#！！！！！！请认真阅读第45~52行内容并填入对应的值！！！！！！教程网址为：https://github.com/SuperManito/JD-FreeFuck/wiki/Cookie-Get
#环境部署部分：
systemctl disable --now firewalld
sed -i "7c SELINUX=disabled" /etc/selinux/config
setenforce 0
yum -y install wget
rm -rf /etc/yum.repos.d/*
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo
yum makecache
yum install -y https://mirrors.aliyun.com/epel/epel-release-latest-8.noarch.rpm
yum makecache
yum install -y vim net-tools curl git perl nodejs npm
yum install -y http://rpmfind.net/linux/centos/8.3.2011/PowerTools/x86_64/os/Packages/perl-IO-Tty-1.12-11.el8.x86_64.rpm
yum install -y http://rpmfind.net/linux/centos/8.3.2011/PowerTools/x86_64/os/Packages/perl-IPC-Run-0.99-1.el8.noarch.rpm
yum install -y moreutils
yum update -y 
#语言环境验证：
locale | grep 'LANG=zh_CN.UTF-8' -q
if [ $? -eq 0 ];then
    echo "\033[32m ------------ 语言环境正确，继续执行脚本 --------------- \033[0m"
    sleep 2s
else
    yum -y install langpacks-zh_CN
    locale -a
    echo 'LANG="zh_CN.utf8"' > /etc/locale.conf
    . /etc/locale.conf
    type locale
    echo -e "\033[31m ------------ Please reboot your system !!! --------------- \033[0m"
    return
fi
#脚本核心内容：
git clone -b v3 https://gitee.com/evine/jd-base /home/myid/jd
cd /home/myid/jd
mkdir config
cp sample/config.sh.sample config/config.sh && cp sample/computer.list.sample config/crontab.list
sed -i '27c Cookie1=""' config/config.sh   #根据https://github.com/SuperManito/JD/wiki/Cookie-Get教程将获得的值填入”双引号“内,可同时跑6个账号，格式已在下方保留，同理按顺序填入即可
#例：sed -i '27c Cookie1="pt_pin=xxxxxx;pt_key=xxxxxx;"' config/config.sh
#sed -i '28c Cookie2=""' config/config.sh
#sed -i '29c Cookie3=""' config/config.sh
#sed -i '30c Cookie4=""' config/config.sh
#sed -i '31c Cookie5=""' config/config.sh
#sed -i '32c Cookie6=""' config/config.sh
#sed -i '70c export PUSH_KEY=""' config/config.sh   #此处内容用于微信消息推送功能，会将结果利用Wechat公众号推送到你的Wechat上，如有需要请取消注释并在”双引号“处填入SCKEY值，详细教程请访问 http://sc.ftqq.com/3.version/
cd /home/myid/jd/scripts
npm install || npm install --registry=https://registry.npm.taobao.org
cd /home/myid/jd
bash git_pull.sh
#一键执行所有活动脚本：
touch /home/myid/jd/run-all.sh
chmod +x /home/myid/jd/run-all.sh
bash jd.sh | grep jd_ >> /home/myid/jd/run-all.sh
sed -i '1d' /home/myid/jd/run-all.sh
sed -i 's/^/bash jd.sh &/g' /home/myid/jd/run-all.sh
sed -i 's/$/& now/g' /home/myid/jd/run-all.sh
echo "bash jd.sh jr_sign now" >> /home/myid/jd/run-all.sh
sed -i '1i\#!/bin/bash' /home/myid/jd/run-all.sh
#一键更新脚本：
touch /home/myid/jd/manual-update.sh
chmod +x /home/myid/jd/manual-update.sh
cat > /home/myid/jd/manual-update.sh << EOF
#!/bin/bash
bash git_pull.sh
rm -rf run-all.sh
touch run-all.sh
chmod +x run-all.sh
bash jd.sh | grep jd_ >> run-all.sh
sed -i '1d' run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/$/& now/g' run-all.sh
echo "bash jd.sh jr_sign now" >> run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
EOF
#结束语：
echo -e "\033[32m ------------ 环境部署完成，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------ \033[0m"
echo -e "\033[32m 注意：该脚本主目录为/home/myid/jd \033[0m"
echo -e "\033[32m 注意：执行脚本期间可能会卡住，可通过命令 Ctrl + C 继续执行 \033[0m"
echo -e "\033[32m 注意：之前填入的Cookie部分内容具有一定的时效性，若失效请重新获取并手动更新 \033[0m"
echo -e "\033[32m 注意：为了保证脚本正常运行，请不要更改任何组件的位置以避免出现未知的错误 \033[0m"
echo -e "\033[32m 注意：由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本 \033[0m"
echo -e "\033[32m 注意：如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可 \033[0m"
