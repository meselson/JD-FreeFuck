#!/bin/bash
#Author:King'S HAN
#Update Date:2021-1-7
#Project Name:《京东薅羊毛》一键部署脚本，通过参与京东商城的各种活动白嫖京豆
#本人为了懒人一键部署而写此脚本，此脚本内容涵盖编写了所有该项目所需要的环境软件包和原创一键脚本
#此脚本核心内容来自于lxk0301大神托管至GitHub的项目，定期更新核心JavaScript脚本内容，所有京东活动脚本最终解释权归他所有
#此脚本环境内容来自于EvineDeng托管至GitHub的项目，使用了他提供的所有JavaScript脚本环境组件
#适用系统：Ubuntu 20.x简体中文，本人测试环境为Ubuntu 20.04 LTS，系统装完后联网即可
#！！！！！！请认真阅读第42~48行内容并填入对应的值，如果使用Github一键教程则不用在此手动填入了！！！！！！
#当前用户判定：
if [ $UID -ne 0 ];then
    echo -e '\033[31m ------------ Permission no enough, please use user ROOT! ------------ \033[0m'
    return
fi
#网络环境判定：
ping -c 1 www.baidu.com > /dev/null 2>&1
if [ $? -ne 0 ];then
    echo -e "\033[31m ----- Network connection error.Please check the network environment and try again later! ----- \033[0m"
    return
fi
#环境部署：
sed -i '1,$d' /etc/apt/sources.list
cat > /etc/apt/sources.list <<EOF
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF
apt-get update
apt install -y git curl nodejs npm perl moreutils
#核心内容：
git clone -b v3 https://gitee.com/evine/jd-base /home/myid/jd  #该项目环境作者同时在Github和码云Gitee都有托管此项目，考虑到网络因素故使用码云Gitee
cd /home/myid/jd
mkdir config
cp sample/config.sh.sample config/config.sh && cp sample/computer.list.sample config/crontab.list
bash git_pull.sh
sed -i '27c Cookie1=""' config/config.sh  #根据教程将获得的值填入”双引号“内,可同时跑6个账号，格式已在下方保留，同理按顺序填入即可
#sed -i '28c Cookie2=""' config/config.sh
#sed -i '29c Cookie3=""' config/config.sh
#sed -i '30c Cookie4=""' config/config.sh
#sed -i '31c Cookie5=""' config/config.sh
#sed -i '32c Cookie6=""' config/config.sh
#sed -i '70c export PUSH_KEY=""' config/config.sh  #此处内容用于Server酱微信消息推送功能，如有需要请取消注释并在”双引号“内填入SCKEY值
cd /home/myid/jd/scripts
npm install || npm install --registry=https://registry.npm.taobao.org
cd /home/myid/jd
#编写一键执行脚本：
touch /home/myid/jd/run-all.sh
chmod +x /home/myid/jd/run-all.sh
bash jd.sh | grep jd_ >> /home/myid/jd/run-all.sh
sed -i '1d' /home/myid/jd/run-all.sh
sed -i 's/^/bash jd.sh &/g' /home/myid/jd/run-all.sh
sed -i 's/$/& now/g' /home/myid/jd/run-all.sh
sed -i '1i\#!/bin/bash' /home/myid/jd/run-all.sh
#编写一键更新脚本：
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
sed -i '1i\#!/bin/bash' run-all.sh
EOF
#结束语：
echo -e "\033[32m ------------------- 环境部署完成，请执行 bash run-all.sh 命令开始你的薅羊毛行为 ------------------- \033[0m"
echo -e "\033[32m +=================================================================================================+ \033[0m"
echo -e "\033[32m | 注意：该项目主运行目录为/home/myid/jd                                                           | \033[0m"
echo -e "\033[32m | 注意：为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                      | \033[0m"
echo -e "\033[32m | 注意：执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z 跳过继续执行剩余活动脚本        | \033[0m"
echo -e "\033[32m | 注意：run-all.sh为执行所有活动脚本，仍可通过原作者 bash jd.sh 命令查看教程并执行特定活动脚本    | \033[0m"
echo -e "\033[32m | 注意：由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本        | \033[0m"
echo -e "\033[32m | 注意：如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可     | \033[0m"
echo -e "\033[32m | 注意：之前填入的Cookie部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新  | \033[0m"
echo -e "\033[32m | 定义：run-all.sh 为本人编写的一键执行所有活动脚本，manual-update.sh 为本人编写的一键更新脚本    | \033[0m"
echo -e "\033[32m +=================================================================================================+ \033[0m"
echo -e "\033[32m -------------------- 更多帮助请访问 https://github.com/SuperManito/JD-FreeFuck -------------------- \033[0m"
