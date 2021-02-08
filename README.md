__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__

***

## 通知与更新

- __2021/2/8 更新__

修复了`crontab.list`定时配置文件目录不正确的问题，修复了`run-all.sh`一键执行所有活动脚本关于重复添加`疯狂的JOY`挂机活动的错误，删除了不该在一键执行所有活动脚本中运行的活动，请所有朋友更新，更新命令位于下方第四步中的第3条。
- __2021/2/5 通知（重要）__

由于Linux环境原作者退隐江湖，旧版本已无法更新且Docker镜像已下架无法拉取，已部署的朋友请重新部署，新部署脚本会自动备份之前的配置文件。\
\
新版本为系统直装，基于原作者公布的源码开发而来，可同步最新活动脚本。开发不易，维护艰辛，感谢支持！

***

# 《JD薅羊毛》一键部署 For Linux
## 用途：通过自动化脚本参与JD商城的各种活动从而白嫖J豆
## 支持的 GNU/Linux (简体中文) 发行版：
- __`Ubuntu`：支持 16.04 ~ 20.10 版本，建议优先使用Ubuntu系统__
- __`Debian`：支持 9.0 ~ 10.7 版本__
- __`Fedora`：支持 28 ~ 33 版本__
- __`CentOS`：支持 7.0 ~ 8.3 版本，如果是最小化安装，请通过SSH方式进入到终端__

  _附：[ Windows10 安装 WSL Ubuntu 教程](https://github.com/SuperManito/JD-FreeFuck/wiki/Windows10-Install-WSL-Ubuntu)_

  _附：[基于 Docker 的安装方法（ 软路由、NAS ）](https://github.com/SuperManito/JD-FreeFuck/wiki/Docker-Install-(-Soft-Router-&-NAS-))_

__温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文，如果遇到问题请及时向我反馈，谢谢！__\
\
__此项目`码云Gitee`同步更新，如果您所在的环境经常性无法访问Github，建议收藏国内项目发布页[ 点击此处访问 ](https://gitee.com/SuperManito/JD-FreeFuck)__

***

# 下面进入正题，部署教程共三步，请认真阅读下面的内容
    
***

## 一、命令部署
- __部署前需知：__
1. 检查系统版本是否符合支持范围、是否切换至`root`用户、是否联网等基本条件
2. 本项目默认安装目录为`/opt/jd`，如果你不想安装到该目录请自行下载源码并更改相关变量手动部署
3. 受网络环境因素影响，如果部署失败请再次尝试，否则请严格按模板提交至[ Issues ](https://github.com/SuperManito/JD-FreeFuck/issues)寻求帮助
4. 下方`常规环境`与`VPS环境`对应两种部署方案，根据你的使用环境选择其一即可，不要重复部署
- __常规环境：__
 
__Github__

    bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install.sh)
__Gitee__

    bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/install.sh)
- __VPS环境：__
 
__Github__

    bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-vps.sh)
__Gitee__

    bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/install-vps.sh)
   _注：如果部署后无法访问控制面板，请检查您所使用平台的防火墙功能，检查是否已为您的VPS开放端口、允许网页流量等重要设置。_ 
- 附1. 如果提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：

      apt install -y curl 或 yum install -y curl
- 附2. 如果没有科学上网方式使用Github命令部署项目时提示`无法解决Hosts`，可通过添加解析记录以解决连通性问题，添加命令如下：

      echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
      echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
- 附3. 如果您已部署此项目想单独使用我原创的一键脚本请执行此命令：

      bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/autoscript.sh)
    
***

## 二、接下来我们需要您JD账户的“身份证”，它由`Cookie部分内容`组成，下面是获取途径：
__1. 通过`控制面板`功能进入浏览器网页手机扫码获取，此方式获取的Cookie部分内容有效期为3个月。（优先推荐）__\
__2. 通过浏览器开发工具获取，在[ Wiki-GetCookies ](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)有详细的图文教程，此方式获取的Cookie部分内容有效期为1个月。__

***

## 三、手动配置信息
_注：以下全部内容也可在控制面板功能中的浏览器网页完成配置，可取代在终端输入命令_
### 将获得的`Cookie部分内容`填入下面命令中的“双引号”内，复制完整命令到终端并执行。（必填）
    sed -i '28c Cookie1=""' /opt/jd/config/config.sh
  _参考命令：sed -i '27c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' /home/myid/jd/config/config.sh_
- 附1. 该项目可同时运行多个账号，请按顺序填入下面命令中的“双引号”内，用几个就执行几条对应的命令，复制完整命令到终端并执行：

      sed -i "29c Cookie2=$COOKIE2" /opt/jd/config/config.sh
      sed -i "30c Cookie3=$COOKIE3" /opt/jd/config/config.sh
      sed -i "31c Cookie4=$COOKIE4" /opt/jd/config/config.sh
      sed -i "32c Cookie5=$COOKIE5" /opt/jd/config/config.sh
      sed -i "33c Cookie6=$COOKIE6" /opt/jd/config/config.sh
   _注：账号无上限，超出6个账号后需要自己在配置文件创建变量，自行查看配置文件中的注释。_
- 附2. 如果需要使用[ Server酱 ](http://sc.ftqq.com/)微信推送功能请将`SCKEY`填入下面的双引号内，复制完整命令到终端并执行：

      sed -i '95c export PUSH_KEY=""' /opt/jd/config/config.sh

***

## 四、使用与更新
- __如何运行一键脚本开始白嫖京豆？__

      bash run-all.sh
    _注：此脚本内容为执行所有活动脚本，如果想要单独执行或延迟执行特定活动脚本，请通过命令`bash jd.sh`查看教程。_
- __如何更新活动脚本与一键脚本？__

      bash manual-update.sh
    _注：建议每次运行活动脚本前执行一次，JD活动经常变化，原作者更新也很频繁。_
- __如何升级与更新？__

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/update.sh)
    _注：适用于后期维护更新，当遇到问题或优化代码需要更新时会在项目置顶通知，另外如果您修改了默认安装目录，请自行下载源码并更改相关变量手动更新。_

***

## 五、声明
1. 本人代码全部开源，代码各处均有注释其含义，所有脚本没有附加本人的互助码，无任何私利。
2. 本人项目为二次使用，我不是该《JD薅羊毛》项目的开发者，所有活动类问题与我无关。
3. `run-all.sh`为本人编写的一键执行所有活动脚本，`manual-update.sh`为本人编写的一键更新脚本，如果你不想用请自行删除。\
\
__原作者项目链接：__\
__[ lxk0301/jd_scripts ](https://gitee.com/lxk0301/jd_scripts/tree/master/) 　## 活动脚本开发者__
    
***

## 六、项目需知
1. 该项目文件以及一键脚本的默认所在目录为`/opt/jd`
2. 为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误
3. 手动执行`run-all`脚本后无需守在电脑旁，会自动在最后运行挂机活动脚本
4. 执行`run-all`脚本期间如果卡住，可按回车键尝试或通过命令`Ctrl + Z/C`跳过继续执行剩余活动脚本
5. 由于京东活动一直变化可能会出现无法参加活动、报错等正常现象，可手动更新活动脚本
6. 如果需要更新活动脚本，请执行`bash manual-update.sh`命令进行一键更新即可
7. 之前填入的`Cookie部分内容`具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新
8. 我不是活动脚本的开发者，但后续使用遇到任何问题都可访问本项目寻求帮助，制作不易，理解万岁

***

## 赞赏码
<img src="https://m.qpic.cn/psc?/V50n9XtX0l0n6J3udmyK2gRcEx18FnXh/45NBuzDIW489QBoVep5mcbTMgCjpKAAK.sAHneYsD2JkZhvOqMXe6eJqnrUjeaIWidOGbhjLKMcjmIUXh.T5iMtKA6HmNU30Pu2EijiozuE!/b&bo=OAQ4BAAAAAADJwI!&rf=viewer_4" width="300" height="300" alt="微信赞赏码"/><br/>
### 如果您愿意支持此项目，可对我进行打赏，开发不易，维护艰辛，感激不尽！
### 如果您有意见与建议欢迎到 [Issues](https://github.com/SuperManito/JD-FreeFuck/issues) 反馈，如果需要帮助请严格按照模板提交。

***

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
