__如果您觉得这个项目不错的话可以在右上角点个小星星吗？方便分享给更多的朋友吗？ (∩_∩)__

***

2021/1/12\
通知：因活动列表有所变化，本人改善了一键更新脚本的代码，1月12日前已部署本人项目的朋友请执行更新命令，教程在下方第四部分第3条。

***

# 《京东薅羊毛》一键部署脚本 For Linux
## 用途：通过JavaScript自动化脚本参与京东商城的各种活动从而白嫖京豆
## 适用系统：Ubuntu 20 & CentOS 8 _简体中文_
- Ubuntu本人测试环境为Ubuntu 20.04 LTS，建议优先使用Ubuntu系统
- CentOS本人测试环境为CentOS 8.3，不适用7及更低版本，如果是最小化安装，请通过SSL方式进入到终端
## 原作者GitHub项目地址：
### [lxk0301/jd_scripts](https://github.com/lxk0301/jd_scripts)  #此项目核心JavaScript京东活动脚本作者
### [EvineDeng/jd-base](https://github.com/EvineDeng/jd-base)   #此项目Linux环境作者，在其项目[Issues](https://github.com/EvineDeng/jd-base/issues/185)有分帖
    
***

# 下面进入正题，部署教程共三步，请认真阅读下面的内容
    
***

## 一、环境部署
### 脚本一键部署
Ubuntu：

    bash <(curl -L https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-ubuntu.sh)
CentOS：

    bash <(curl -L https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-centos.sh)
_注：请根据你的操作系统，选择上面对应的命令复制到终端并执行_\
\
附1：如果提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：

    apt install -y curl 或 yum install -y curl
附2：如果没有科学上网方式会提示无法连接，可通过添加Github解析记录以解决连通性问题，命令如下：

    echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
    
***

## 二、接下来我们需要您京东账户的“身份证”，它由`Cookie部分内容`组成，在[Wiki](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)有详细的图文教程，请点击链接自行获取

***

## 三、配置脚本
### 根据[Wiki](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)教程将获得的`Cookie部分内容`填入下面命令中的“双引号”内，复制完整命令到终端并执行。（必填）
    sed -i '27c Cookie1=""' /home/myid/jd/config/config.sh
_参考命令：sed -i '27c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' /home/myid/jd/config/config.sh_
\
### 附.该项目可同时运行多个账号（最多6个），请按顺序填入下面命令中的“双引号”内，用几个就执行几条对应的命令。（选择步骤）

    sed -i '28c Cookie2=""' /home/myid/jd/config/config.sh
    sed -i '29c Cookie3=""' /home/myid/jd/config/config.sh
    sed -i '30c Cookie4=""' /home/myid/jd/config/config.sh
    sed -i '31c Cookie5=""' /home/myid/jd/config/config.sh
    sed -i '32c Cookie6=""' /home/myid/jd/config/config.sh

### _到此部署就结束了，是不是很快OvO_

***

## 四、使用与更新
### 1.如何运行脚本开始白嫖京豆？
    bash run-all.sh
### 2.如何更新京东活动脚本？
    bash manual-update.sh
_注：建议每次运行活动脚本前执行一次，京东活动经常变化，原作者更新也很频繁。_
### 3.如何更新一键更新脚本？
    bash <(curl -L https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/manual-update.sh)
_注：适用于后期维护，当需要更新时会在项目置顶通知。_
### 4.一键部署后遇到报错怎么办？
- 多次执行`manual-update.sh`更新脚本尝试
- 删除/home/myid整个目录后重新一键部署\
_注：如果仍然报错导致项目无法正常运作，说明是原作者环境库的问题，请换个时间重试。_
    
***

## 五、脚本定义
`run-all.sh`为本人编写的一键执行所有活动脚本，`manual-update.sh`为本人编写的一键更新脚本，其余均为原作者脚本。
## 六、项目需知
1.该项目运行主目录为/home/myid/jd\
2.为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误\
3.run-all.sh为执行所有活动脚本，仍可通过原作者 bash jd.sh 命令查看教程并执行特定活动脚本\
4.执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z/C 跳过继续执行剩余活动脚本\
5.由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本\
6.如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可\
7.因为本人每天也在使用，遇到错误会在第一时间解决，遇到任何与部署和环境相关的问题都可访问本项目寻求帮助
    
***

## 如果您有意见与建议欢迎在项目Issuse提问
