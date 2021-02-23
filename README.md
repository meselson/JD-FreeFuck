__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__

***

## 通知与更新
- __2021/2/24 2:00 更新__

ㅤ增加了本人深度定制的`diy`脚本，可通过下面的步骤部署到您的项目中：

    1. 为了确保使用最新版的配置文件，请先根据《使用与更新》中的第12条教程更新您的配置文件
    2. 通过《使用与更新》中的第5条命令启用该功能后一键导入脚本到项目
    3. 执行 bash manual-update.sh 更新命令完成部署
`Docker`用户请前往`Wiki`项目页查看具体更新命令ㅤ[ 点击此处前往 ](https://github.com/SuperManito/JD-FreeFuck/wiki/Docker-Install-(-Soft-Router-&-NAS-&-Other-Linux-))

- __2021/2/23 13:50 通知__

ㅤ修复了关于Docker版本`定时任务`配置不正确的问题，请所有已部署`Docker版本`的朋友更新，[ 点击此处 ](https://github.com/SuperManito/JD-FreeFuck/wiki/Docker-Install-(-Soft-Router-&-NAS-&-Other-Linux-))前往`Wiki`项目页查看具体更新命令。

- __2021/2/21 通知（重要）__

ㅤ由于活动脚本作者lxk0301的库触发Gitee监控机制被官方封禁，解封后库从公开状态变为私有状态，目前已修复完毕，请所有已部署的朋友根据《使用与更新》中`卸载此项目`的第一条命令删除整个项目文件夹后重新部署，遇到问题还请立即反馈。

***

# 《JD薅羊毛》一键部署 For Linux
## 用途：通过自动化脚本参与JD商城的各种活动从而白嫖京豆
## 已适配的 GNU/Linux 发行版（简体中文）：
- __`Ubuntu`：16.04 ~ 20.10 ㅤㅤ ㅤ`Fedora`：28 ~ 33__
- __`Debian`：9.0 ~ 10.7ㅤㅤㅤㅤㅤ`CentOS`：7.0 ~ 8.3__

 _附：[ Windows10 安装 WSL Ubuntu 教程](https://github.com/SuperManito/JD-FreeFuck/wiki/Windows10-Install-WSL-Ubuntu)_

 _附：[基于 Docker 的部署教程（ 软路由、NAS、其它 GNU/Linux 发行版 ）](https://github.com/SuperManito/JD-FreeFuck/wiki/Docker-Install-(-Soft-Router-&-NAS-&-Other-Linux-))_

#### 此项目`码云Gitee`同步更新，如果您所在的环境经常无法访问Github，建议收藏国内项目发布页[ 点击此处访问 ](https://gitee.com/SuperManito/JD-FreeFuck)
#### 温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文，CentOS如果是最小化安装请通过SSH方式进入到终端

***

# 下面进入正题，请认真阅读下面的内容
    
***

## 一、命令部署
### 部署前需知：
#### 1. 检查系统是否符合支持范围、是否联网等基本条件
#### 2. 执行部署命令前请切换至`root用户`，切换命令为`sudo -i`
#### 3. 本项目默认安装目录为`/opt/jd`，如果您不想安装到该目录请自行下载部署脚本并更改相关变量手动部署
#### 4. 由于某些组件的安装受国外网络影响，如果部署失败或遇到报错请再次尝试，否则请严格按照模板提交至[ Issues ](https://github.com/SuperManito/JD-FreeFuck/issues)寻求帮助
#### 5. 下方`Github`与`Gitee`对应两种部署途径，国内用户如果没有科学上网方式可使用码云`Gitee`命令部署此项目
#### 6. `PC 环境`与`VPS 环境`对应两种部署方案，区别在于是否使用国内更新源加速，根据您的使用环境选择其一即可，不要重复部署
#### 7. 使用`VPS 环境`部署前请进入您所使用平台的防火墙功能，检查是否已开放相关端口、允许`HTTP/HTTPS`流量通过等重要设置
ㅤ
### 从`Github`部署：
- PC 环境

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install.sh)
- VPS 环境

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-vps.sh)
### 从`Gitee`部署：
- PC 环境

      bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/install.sh)
- VPS 环境

      bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/install-vps.sh)
ㅤ
### 常见问题与帮助：
#### 1. 如果执行部署脚本命令后提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：
    
    apt install -y curl 或 yum install -y curl
#### 2. 如果执行部署脚本命令后没有反应直接结束并跳回终端交互说明您的网络环境存在问题，请检查您的网络连通性以及相关设置。
#### 3. 如果使用`Github命令`部署项目时提示`无法解决Hosts`，可通过添加解析记录以解决连通性问题，添加命令如下：

    echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
    echo "151.101.228.133 raw.githubusercontent.com" >> /etc/hosts
#### 4. 如果控制面板功能未安装成功提示`npm error`相关字样，请执行下面的命令重新安装：

    cd /opt/jd/panel
    npm install || npm install --registry=https://registry.npm.taobao.org
    npm install -g pm2
    pm2 start server.js
#### 5. 拉取更新失败提示`ssh: connect to host gitee.com port 22: Connection timed out`是因为`SSH 22端口`不可用。
#### 6. 部署成功后无法访问`控制面板`是由于`5678 端口`外部不能访问所导致。
    
***

## 二、获取账号信息
__接下来我们需要您JD账户的“身份证”，它由`Cookie部分内容`组成，下面是获取途径：__
- 通过`控制面板`功能进入WEB网页手机扫码获取，此方式获取的“身份证”有效期为3个月。（优先推荐）
- 通过浏览器开发工具获取，在[ Wiki-GetCookies ](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)有详细的图文教程，此方式获取的“身份证”有效期为1个月。

***

## 三、手动配置信息
_注：以下全部内容也可在控制面板功能中的WEB网页完成配置，可取代在终端输入命令。_
- __将获得的`Cookie部分内容`填入下面命令中的“双引号”内，复制完整命令到终端并执行：__

      sed -i '28c Cookie1=""' /opt/jd/config/config.sh
    _参考命令：sed -i '28c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' /opt/jd/config/config.sh_
- __其它配置信息（选填）：__
1. 该项目可同时运行多个账号，请按顺序填入下面命令中的“双引号”内，用几个就执行几条对应的命令，复制完整命令到终端并执行：

       sed -i "29c Cookie2=$COOKIE2" /opt/jd/config/config.sh
       sed -i "30c Cookie3=$COOKIE3" /opt/jd/config/config.sh
       sed -i "31c Cookie4=$COOKIE4" /opt/jd/config/config.sh
       sed -i "32c Cookie5=$COOKIE5" /opt/jd/config/config.sh
       sed -i "33c Cookie6=$COOKIE6" /opt/jd/config/config.sh
    _注：账号无上限，超出6个账号后需要自行在`config.sh`配置文件创建变量，自行查看配置文件中的注释。_
2. 如果需要使用[ Server酱 ](http://sc.ftqq.com/)微信推送功能请将`SCKEY`填入下面的双引号内，复制完整命令到终端并执行：

       sed -i '95c export PUSH_KEY=""' /opt/jd/config/config.sh

***

## 四、使用与更新
#### 1. 进入项目安装目录：
    cd /opt/jd
_注：进入项目安装目录内才能使用所有功能。_
#### 2. 运行一键脚本开始您的薅羊毛行为：
    bash run-all.sh
_注：此一键脚本内容为执行所有活动脚本。_
#### 3. 更新活动脚本与一键脚本：
    bash manual-update.sh
_注：为了正确配置定时任务，请使用此脚本更新项目活动脚本，您还可对照此脚本中的内容定制`run-all.sh`一键执行所有活动脚本。_
#### 4. 执行特定活动脚本：
    bash jd.sh xxx      # 如果设置了随机延迟并且当时时间不在0-2、30-31、59分内，将随机延迟一定秒数
    bash jd.sh xxx now  # 无论是否设置了随机延迟，均立即运行
_注：具体所有活动脚本列表可通过命令`bash jd.sh`查看，`xxx`为脚本名。_
#### 5. 使用diy脚本：
    #启用该功能
    sed -i 's/EnableExtraShell=""/EnableExtraShell="true"/g' config/config.sh
    #导入脚本
    wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/diy.sh -O config/diy.sh
_注：此脚本定期更新，如果您想添加更多内容，可根据此脚本中的注释自行添加，如果您修改了默认安装目录，请下载脚本到本地后修改相关变量才能使用。_
#### 6. 获取互助码：
    #导入脚本
    wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/format_share_jd_code.js -O scripts/format_share_jd_code.js
    #使用脚本
    bash jd.sh format_share_jd_code now
_注：这里引用了另一个大佬写的互助码脚本，比 lxk 的好用。引用项目链接：[qq34347476/quantumult-x](https://gitee.com/qq34347476/quantumult-x/tree/master)_
#### 7. 导出互助码：
    bash export_sharecodes.sh
#### 8. 启用挂机功能：
    bash jd.sh hangup
#### 9. 手动启用控制面板功能：
    pm2 start panel/server.js
_注：此命令适用于后期使用，在某些环境下当系统重启导致控制面板无法访问提示拒绝连接时可用此命令恢复使用。_
#### 10. 重置控制面板的用户名和密码：
    bash jd.sh resetpwd
#### 11. 导入并使用第三方活动脚本：
    1. 将脚本放置在该项目 scripts 子目录下
    2. 然后通过命令 bash jd.sh xxx now 运行
    3. 如果您想将第三方脚本加入到 run-all.sh 一键脚本中可将脚本名改为"jd_"开头即可
_注：导入的第三方活动脚本不会随项目本身活动脚本的更新而删除。_
#### 12. 更新配置文件：
    #备份配置文件
    mv config/config.sh config/config.sh.bak
    #替换新的配置文件
    wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/config.sh.sample -O sample/config.sh.sample
    cp sample/config.sh.sample config/config.sh
#### 13. 更新一键更新脚本：
    wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/manual-update.sh -O manual-update.sh
    bash manual-update.sh
#### 14. 修复与升级：
    bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/update.sh)
_注：适用于后期维护，当遇到问题或优化代码需要修复时会在项目置顶通知，另外如果您修改了默认安装目录，请自行下载源码并更改相关变量手动更新。_
#### 15. 如何卸载此项目：
    #删除项目文件（默认安装目录）
    rm -rf /opt/jd
    #卸载软件包
    apt/yum remove -y git perl moreutils nodejs npm

***

## 五、项目需知
#### 1. 该项目文件以及一键脚本的默认安装目录为`/opt/jd`
#### 2. 为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误
#### 3. `run-all.sh`为一键执行所有活动脚本，`manual-update.sh`为一键更新脚本
#### 4. 手动执行`run-all.sh`脚本后无需守在电脑旁，会自动在最后运行挂机活动脚本
#### 5. 执行活动脚本期间如果卡住，可按回车键尝试或通过命令`Ctrl + Z/C`跳过继续执行剩余活动脚本
#### 6. 由于京东活动一直变化可能会出现无法参加活动、报错等正常现象，可手动更新活动脚本
#### 7. 如果需要更新活动脚本，请执行`bash manual-update.sh`命令一键更新即可，它会同步更新`run-all.sh`脚本
#### 8. 除手动运行活动脚本外该项目还会通过定时的方式全天候自动运行活动脚本，具体运行记录可通过日志查看
#### 9. 该项目已默认配置好`Crontab`定时任务，定时配置文件`crontab.list`会通过活动脚本的更新而同步更新
#### 10. 之前填入的`Cookie部分内容`具有一定的时效性，若提示失效请根据教程重新获取并手动更新
#### 11. 我不是活动脚本的开发者，但后续使用遇到任何问题都可访问本项目寻求帮助，制作不易，理解万岁

***

## 六、声明
#### 1. 本项目代码全部开源，代码各处均有注释其含义，所有脚本没有附加本人的互助码，无任何私利。
#### 2. 我不是该《JD薅羊毛》项目的开发者，所有活动类问题与我无关，本项目所使用的活动脚本均由[ lxk0301 ](https://gitee.com/lxk0301)提供。
#### 3. `run-all.sh`为本人编写的一键执行所有活动脚本，`manual-update.sh`为本人编写的一键更新脚本，如果您不想用请自行删除。

***

## 七、帮助与支持
#### 如果您有意见与建议或者遇到问题需要我的协助，欢迎到[ Issues ](https://github.com/SuperManito/JD-FreeFuck/issues)提交反馈
#### 为了提高效率快速解决您的问题，请严格按照模板提交，我会在第一时间进行回复，感谢您的理解与配合


***

## 明天会更好
<img src="https://gitee.com/SuperManito/JD-FreeFuck/raw/main/icon/thank.jpg" width="300" height="300" alt="微信赞赏码"/><br/>
### 如果您愿意支持此项目，可对我打赏，感激不尽！
### 开发不易、维护艰辛，感谢您的理解与支持！

***

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
