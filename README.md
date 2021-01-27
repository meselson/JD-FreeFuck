__如果您觉得这个项目不错的话可以在右上角给颗小星星吗？方便分享给更多的朋友吗？ (∩_∩)__

***

## 通知：
__2021/1/27__\
__项目失效，原因未知，作者失联，原项目Github网站均已无法访问，现已无法部署，已部署的用户不受影响。__\
\
__2021/1/24__\
__由于原作者更改了帮助文档，从而导致本人的`run-all.sh`一键执行脚本失效，24日前已部署的朋友请执行更新脚本，命令在下方第四步`使用与更新`中的第3条。__\
\
__2021/1/16__\
__由于原作者lxk0301大佬的Github库被封，收到[ 通知 ](https://github.com/EvineDeng/jd-base/issues/234)，请16号前已部署的朋友删除`/jd`目录后重新一键部署。__

***

# 《京东薅羊毛》一键部署脚本 For Linux
## 用途：通过JavaScript与Shell自动化脚本参与京东商城的各种活动从而白嫖京豆
## 支持的 Linux (简体中文) 发行版：
- __`Ubuntu`：支持 16.04 ~ 20.10 版本，建议优先使用Ubuntu系统__  　　附：[Win10应用商店安装Ubuntu教程](https://github.com/SuperManito/JD-FreeFuck/wiki/Windows10-Install-Ubuntu)
- __`Debian`：支持 8.0 ~ 10.7 版本__
- __`Kali`：支持 2018 ~ 2020.4 版本__
- __`Fedora`：支持 28 ~ 33 版本__
- __`CentOS`：支持 7.0 ~ 8.3 版本，如果是最小化安装，请通过SSH方式进入到终端__

  _温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文，旧版系统如果遇到问题请及时向我反馈，谢谢！_
    
***

# 下面进入正题，部署教程共三步，请认真阅读下面的内容
    
***

## 一、环境部署
- __命令一键部署：__

    __基于Debian系列 `Ubuntu | Debian | Kali`__

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-debians.sh)
    __基于RedHat系列 `CentOS | Fedora`__

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-redhats.sh)
    _注：请根据你的操作系统，选择上面对应的命令复制到终端并执行_
- 附1. 如果提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：

      apt install -y curl 或 yum install -y curl
- 附2. 如果没有科学上网方式会提示无法解决`Hosts`，可通过添加解析记录以解决连通性问题，添加命令如下：

      echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
      echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
- 附3. 一键部署后遇到报错怎么办？

      1）检查系统版本、联网状态等基本条件
      2）多次执行manual-update.sh更新脚本尝试
      3）删除/home/myid整个目录后换源重新一键部署
    _注：如果仍然报错导致部署失败无法运行项目，说明是原作者环境库的问题，请换个时间重试。_
    
***

## 二、接下来我们需要您京东账户的“身份证”，它由`Cookie部分内容`组成，下面是获取途径：
__1. 在[ Wiki ](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)有详细的图文教程，请点击链接自行获取，此方式获取的Cookie只有1个月有效期。__\
__2. 通过通过下方`控制面板`功能部署后进入浏览器网页手机扫码获取，此方式获取的Cookie有效期为3个月。__

***

## 三、配置信息
### 将获得的`Cookie部分内容`填入下面命令中的“双引号”内，复制完整命令到终端并执行。（必填）
    sed -i '27c Cookie1=""' /home/myid/jd/config/config.sh
  _参考命令：sed -i '27c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' /home/myid/jd/config/config.sh_
- 附1. 该项目可同时运行多个账号（最多6个），请按顺序填入下面命令中的“双引号”内，用几个就执行几条对应的命令，复制完整命令到终端并执行：

      sed -i '28c Cookie2=""' /home/myid/jd/config/config.sh
      sed -i '29c Cookie3=""' /home/myid/jd/config/config.sh
      sed -i '30c Cookie4=""' /home/myid/jd/config/config.sh
      sed -i '31c Cookie5=""' /home/myid/jd/config/config.sh
      sed -i '32c Cookie6=""' /home/myid/jd/config/config.sh
- 附2. 如果需要使用[ Server酱 ](http://sc.ftqq.com/)微信推送功能请将`SCKEY`填入下面的双引号内，复制完整命令到终端并执行：

      sed -i '70c export PUSH_KEY=""' /home/myid/jd/config/config.sh
- 附3. 如果需要使用[ 控制面板 ](https://github.com/EvineDeng/jd-base/wiki/Panel)功能，安装命令如下：

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install-panel.sh)
    _注：此功能可用于在浏览器编辑配置文件、配置定时运行脚本、自定义脚本等功能，脚本安装后已默认启动。_

***

## 四、使用与更新
__友情提示：获取更多功能请访问[ /EvineDeng/jd-base/wiki/Linux](https://github.com/EvineDeng/jd-base/wiki/Linux)__
- 1.如何运行脚本开始白嫖京豆？

      bash run-all.sh
- 2.如何更新活动脚本？

      bash manual-update.sh
    _注：建议每次运行活动脚本前执行一次，京东活动经常变化，原作者更新也很频繁。_
- 3.如何更新一键脚本？

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/update.sh)
    _注：适用于后期维护更新，当先前一键脚本失效需要更新时会在项目置顶通知。_
    
***

## 五、声明
1. 本人项目为二次使用，我不是该《京东薅羊毛》项目的开发者，所有活动类问题与我无关。
2. `run-all.sh`为本人编写的一键执行所有活动脚本，`manual-update.sh`为本人编写的一键更新脚本，自己查看一下这两个文件内容就全明白了，如果你不想用我写的一键脚本请自行删除，其余所有文件均为原作者创作。

- __此项目原作者GitHub网址链接：__
- [lxk0301/jd_scripts](https://github.com/lxk0301/jd_scripts)  #此项目核心JavaScript京东活动脚本作者
- [EvineDeng/jd-base](https://github.com/LXK9301/jd_scripts)   #此项目Linux环境Shell套壳作者，在其项目[ Issues ](https://github.com/EvineDeng/jd-base/issues/185)有分帖   
    
***

## 六、项目需知
1. 该项目运行主目录为/home/myid/jd
2. 为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误
3. run-all.sh为执行所有活动脚本，仍可通过原作者 bash jd.sh 命令查看教程并执行特定活动脚本
4. 执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + Z/C 跳过继续执行剩余活动脚本
5. 由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本
6. 如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可
7. 之前填入的Cookie部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新
8. 因为本人每天也在使用，遇到错误会在第一时间解决，遇到任何与部署相关的问题都可访问本项目寻求帮助

***

## 如果您有意见与建议欢迎到 [Issuse](https://github.com/SuperManito/JD-FreeFuck/issues) 反馈
## 如果老板成功薅到羊毛，赏1元可否(∩_∩)
<img src="https://a1.qpic.cn/psc?/V50n9XtX0l0n6J3udmyK2gRcEx1lPmFH/ruAMsa53pVQWN7FLK88i5m6GsPj*rJQrKSo6N9UFZGC1BHFpPrrRaDcpZz.ySsybH7kPVI1SDrOmO1SVGbzEgP*3kd0m0SctQXeeBRZE3iA!/b&ek=1&kp=1&pt=0&bo=6QTpBOkE6QQDEDU!&tl=1&vuin=1808077397&tm=1611579600&sce=60-1-1&rf=viewer_311" width="330" height="330" alt="微信赞赏码"/><br/>
