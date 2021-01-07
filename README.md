《京东薅羊毛》一键部署脚本
=====
## 用途：通过参与京东商城的各种活动白嫖京豆，目前每个账号日均100~200京豆

***

## 适用系统：CentOS 8简体中文，不适用7及更低版本
### 本人测试环境为最新CentOS 8.3，系统装完后联网即可，如果是最小化安装，请通过SSL方式进入到终端

***


## 原作者官方GitHub项目网址：
### https://github.com/lxk0301/jd_scripts  #此项目核心JavaScript京东活动脚本原作者
### https://github.com/EvineDeng/jd-base   #此项目Linux环境原作者
    
***

# 一键部署教程，请认真阅读下面的内容
## 一、环境部署
_注：请在终端执行下面的命令_
### 1.安装Wget软件包。

    yum -y install wget
### 2.为Github添加解析记录，如有科学上网方式可跳过此步骤。

    echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
### 3.下载脚本并赋予可执行权限，然后执行安装脚本。

    wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/jd-freefuck.sh && chmod +x install.sh && bash install.sh

***

## 二、接下来我们需要您京东账户的“身份证”，它由`Cookie部分内容`组成，请认真阅读下面的教程自行获取
### 1. 电脑Chrome系浏览器打开京东移动端官网[https://m.jd.com/](https://m.jd.com/)
_注：建议使用无痕窗口，因为当有使用需求需要切换账号时，在正常模式下一旦手动注销当前账号cookie就会失效，若只用1个账号可随意，该脚本最多可以同时跑6个账号。_
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/1.png)
### 2.	在Chrome浏览器中按F12进入开发者模式面板，然后点下图中的图标。
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/2.png)
### 3.	此时是未登录状态，请使用手机短信验证码方式登录，如已登录请忽略此步骤。
_注：建议使用手机短信验证码登录，此方式cookie有效时长大概为31天，相较于其它登录方式时效最长。_
### 4.	登录后，选择开发者模式面板中的`Network`，有很多链接点击箭头`3`这里清空下。
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/3.png)
### 5.	然后回到左边的京东页面点击底部导航栏—我的，出来的链接就变少了。
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/4.png)
### 6. 在开发者模式面板中点击链接`log.gif`，右边滚动条向下滑找到`cookie:`，复制完整内容到本地，下面需要用到。
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/5.png)
### 7.	在`Console`中输入以下三行内容。
    var CV = '';
    var CookieValue = CV.match(/pt_pin=.+?;/) + CV.match(/pt_key=.+?;/);
    copy(CookieValue);
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/6.png) 
### 8.	将从`Network`中复制出来的Cookie填入下面第一行的’单引号’内，如图，然后回车执行。
![](https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/course/7.png)
### 9.	成功回车执行后，我们想要的命令就会在你的系统剪贴板上，然后右键粘贴或`Ctrl + V`至本地，下面需要用到。
_注：内容格式为”pt_pin=xxxxx;pt_key=xxxxxxx;”，有如下俩种情况，不排除其它可能性，京东账号注册方式不同呈现的内容也不同，每个账号都不一样，内容是否正确需通过脚本进行验证，以下内容仅供参考。_

    pt_pin=jd_6a596373acc;pt_key=AAakjshdsaZHQOd_SiYLYi8shkjsahkdjsahdskjahdsakho;
    pt_pin=%E7%AB%A2%E9%AB%A1%E5%13%78;pt_key=Aadq7wmHADCwQ831254235VA5J7mh3_b-czTdFNIyXtRN1WasfewqqawZItEp1dQhjgfnrmrc;

***

## 三、配置脚本
### ★ 请将上面步骤获得的`Cookie部分内容`填入下面命令中的“双引号”内，复制完整命令到终端并回车执行
    sed -i '27c Cookie1=""' /home/myid/jd/config/config.sh
_参考命令：sed -i '27c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' /home/myid/jd/config/config.sh_
#### 1.如果需要同时运行多个账号（最多6个），请按顺序填入下面命令中的“双引号”内，用几个就执行几条对应的命令。（选择步骤）

    sed -i '28c Cookie2=""' /home/myid/jd/config/config.sh
    sed -i '29c Cookie3=""' /home/myid/jd/config/config.sh
    sed -i '30c Cookie4=""' /home/myid/jd/config/config.sh
    sed -i '31c Cookie5=""' /home/myid/jd/config/config.sh
    sed -i '32c Cookie6=""' /home/myid/jd/config/config.sh
#### 2.如果需要使用微信消息推送功能，请访问[Server酱官网](http://sc.ftqq.com/3.version/)，登陆后将获得的`SCKEY`填入下面命令的”双引号“内，复制完整命令到终端并回车执行。（选择步骤）

    sed -i '70c export PUSH_KEY=""' /home/myid/jd/config/config.sh

##### _到此部署就结束了，是不是很快OvO_

***

# 如何运行脚本开始白嫖京豆？
    cd /home/myid/jd
    bash run-all.sh
    
***

# 如何更新活动脚本？
    cd /home/myid/jd
    bash manual-update.sh
_注：建议每次执行脚本前更新或者几天内更新一次，京东活动变化无常。_
    
***

## 脚本定义
`run-all.sh`为本人编写的一键执行所有活动脚本，`manual-update.sh`为本人编写的一键更新脚本
    
***

## 项目需知
### 1.该项目运行主目录为/home/myid/jd
### 2.为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误
### 3.执行脚本期间可能会卡住或运行挂机脚本，可通过命令 Ctrl + C 跳过继续执行剩余活动脚本
### 4.run-all.sh为执行所有活动脚本，仍可通过原作者 bash jd.sh 命令查看教程并执行特定活动脚本
### 5.由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本
### 6.如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可
### 7.之前填入的Cookie部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新
    
***

    
***

## 遇到问题可以联系本人解决，可将问题发送至本人Gmail：liu2273689770@gmail.com
