__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__

***

## 通知与更新
> `更新` 代表有新的内容增加\
> `修复` 代表有错误已经修复完成需要执行更新命令\
> `通知` 代表有新的内容或信息需要您了解\
> 具体内容和命令请前往 [Wiki](https://github.com/SuperManito/JD-FreeFuck/wiki/) 查看通知
- __2021/3/02 9:19 `通知`__
ㅤ在删除`Linux`项目更换为`Docker` 全新版本中，由于是不同的方式部署，需要先停掉之前`Linux`项目的端口占用。具体请查看《使用项目与注意》。如果你是采用的云服务器部署`Docker` 全新版本，请查看《部署项目》`Docker`版本《启动容器》的注意事项。

- __2021/3/01 23:30 `修复`__
ㅤ修复了一键生成互助码脚本的错误，并更换了下载链接。

- __2021/3/01 22:00 `更新`__\
ㅤ已发布 `Linux` 和 `Docker` 全新版本，已推送 `Docker` 版本新镜像，使用了最新的源码，加入了最新活动京喜财富岛相关变量，重新编排了配置文件，修正了格式化互助码脚本，旧版本不再维护，可根据《五、卸载项目》教程重新部署，后续发现问题请及时反馈，感谢您的支持。

- __2021/2/28 21:20 `更新`__
ㅤ已发布全新的 `Docker` 版本，全新构建了镜像，支持 armv7/arm64/amd64 架构的设备。

- __2021/2/28 21:00 `更新`__
ㅤ更新了 `manual-update` 一键更新脚本和 `diy` 自定义脚本。

- __2021/2/25 01:00 `通知`__
ㅤ更换了执行 `run-all.sh` 一键执行所有活动脚本的命令，注意今后使用新命令。

- __2021/2/21 `重要通知`__\
ㅤ由于活动脚本作者lxk0301的库触发Gitee监控机制被官方封禁，解封后库从公开状态变为私有状态，目前已修复完毕，请所有已部署的朋友根据《使用与更新》中`卸载此项目`的第一条命令删除整个项目文件夹后重新部署，遇到问题还请立即反馈。

***

# __《JD薅羊毛》一键部署 For Linux__
- __用途：通过自动化脚本参与JD商城的各种活动从而获取京豆用于购物抵扣__
- __适用平台：PC、VPS (虚拟专用服务器) 、NAS 、软路由__
- __适用环境：Linux & Docker Server__

__ㅤㅤ`Telegram` 通知频道：[ t.me/jd_freefuck ](https://t.me/jd_freefuck)__

__ㅤㅤ`码云Gitee` 同步更新：[ 点击此处访问 ](https://gitee.com/SuperManito/JD-FreeFuck)__

## 特别声明：

* 本仓库发布的项目中涉及的任何解锁和解密分析脚本，仅用于测试和学习研究，禁止用于商业用途，不能保证其合法性，准确性，完整性和有效性，请根据情况自行判断。

* 本项目内所有资源文件，禁止任何公众号、自媒体进行任何形式的转载、发布。

* `SuperManito` 对任何脚本问题概不负责，包括但不限于由任何脚本错误导致的任何损失或损害。

* 间接使用脚本的任何用户，包括但不限于建立VPS或在某些行为违反国家/地区法律或相关法规的情况下进行传播，`SuperManito` 对于由此引起的任何隐私泄漏或其他后果概不负责。

* 请勿将项目中的任何内容用于商业或非法目的，否则后果自负。

* 如果任何单位或个人认为该项目的脚本可能涉嫌侵犯其权利，则应及时通知并提供身份证明、所有权证明，我将在收到认证文件后删除相关脚本。

* 任何以任何方式查看此项目的人或直接或间接使用该项目的任何脚本的使用者都应仔细阅读此声明。

* `SuperManito` 保留随时更改或补充此免责声明的权利，一旦使用并复制了任何相关脚本或项目的规则，则视为您已接受此免责声明。

* 您必须在下载后的 `24小时` 内从计算机中完全删除以上内容。
> ***您使用或者复制了本仓库且本人制作的任何脚本，则视为 `已接受` 此声明，请仔细阅读*** 

***

## 项目声明：
* 本项目开源免费使用，如果您在其它任何地方发现以 `付费` 的形式 `传播与使用` 请积极抵制并向我反馈。

* 本项目代码各处均有注释其含义，所有脚本中没有附加、偷跑任何互助码，无任何第三方链接，无任何私利。

* 本项目基于 [ Evine ](https://gitee.com/evine) 前辈开发的源码而制作，包括 `Docker` 版所使用的镜像，后续的维护与更新均建立于此之上。

* 本项目所使用的活动脚本均由[ lxk0301 ](https://gitee.com/lxk0301)大佬提供，我不是活动脚本的开发者，所有与活动相关的问题均与我无关。

* 如果您对活动脚本提出疑问或建议想要反馈您的问题，请咨询活动脚本作者，我可能无法为您提供有价值的信息。

* 为了保持本项目的稳定运作，请不要滥用 `平台资源` ，不要 `传播与使用` 被第三者修改过的本项目中的脚本。

* 由衷感谢各位大佬对此项目作出的贡献，感谢各位用户朋友向我纠正出本项目中存在的错误内容以及所有反馈！

ㅤ

***

__请ㅤㅤ认ㅤㅤ真ㅤㅤ阅ㅤㅤ读ㅤㅤ教ㅤㅤ程ㅤ，ㅤ90%ㅤㅤ的ㅤㅤ问ㅤㅤ题ㅤㅤ都ㅤㅤ能ㅤㅤ找ㅤㅤ到ㅤㅤ答ㅤㅤ案__

***

## 一、前言
#### 1. 本项目根据安装平台区分为 `Linux` 与 `Docker` 两个版本，分别提供对应的脚本与教程
#### 2. `Linux` 为系统直装版本，适配常用 GNU/Linux 发行版，仅适用于在 `PC` | `VPS` 平台部署
#### 3. `Docker` 为容器版本，为通用版本，建议用于在 `NAS` | `软路由` 平台部署，占用资源较低
#### 4. 两版本的部署教程与使用教程均不相同，不要重复、错误使用，请认真阅读所有教程内容
ㅤ

***

## 二、项目部署

***

> 下面是 `Linux` 版本的部署教程，执行命令前请先看注释内容，请根据您使用的平台选择合适的版本，不要重复部署！

***

### `Linux` 版本
> 仅支持 `Debian` 与 `Redhat` 发行版和及其衍生发行版\
> 尽量使用最新的稳定版系统，并且安装语言使用 `简体中文`\
> 否则请使用 `Docker` 通用版本部署此项目\
> 附：[ Windows10 安装 WSL Ubuntu 教程](https://github.com/SuperManito/JD-FreeFuck/wiki/Windows10-Install-WSL-Ubuntu)
#### __部署前需知与准备工作：__
1. 执行部署脚本前请检查您的系统是否联网，并请切换至 `root用户` ，切换命令为 `sudo -i`
2. 如果您使用的是 CentOS 系统且最小化安装，请通过SSH的方式进入到终端
3. 本项目默认安装目录为 `/opt/jd` ，如果您不想安装到该目录请自行下载部署脚本并更改相关变量手动部署
4. 由于某些组件的安装受国外网络影响，如果部署失败或遇到报错请再次尝试，否则请严格按照模板提交至[ Issues ](https://github.com/SuperManito/JD-FreeFuck/issues)寻求帮助
5. 若使用 `VPS` 平台，部署前请进入您所使用平台的防火墙功能，检查是否已开放相关端口、允许`HTTP/HTTPS`流量通过等设置

#### __更换国内源：__
    bash <(curl -sSL https://ghproxy.com/https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/ReplaceMirror.sh)
> _注意：1. 此脚本为 `LinuxMirror` 一键更换国内源脚本，之前附加在旧版本部署脚本中现独立出来，_\
> _ㅤㅤㅤ2. 如果您使用的平台位于国外则不需要执行此命令，例如 `Google Cloud Platform` 用户，_\
> _ㅤㅤㅤ3. 此脚本并没有适配所有的 GNU/Linux 发行版，具体支持列表详见下方表格。_
- 可使用 `LinuxMirror` 一键更换国内源脚本的 GNU/Linux 发行版

| 系统 | 支持版本 |
| ------ | ------ |
| Ubuntu | 18.04 ~ 20.10 |
| Debian | 9.0 ~ 10.8 |
| Kali | 2019 ~ 2021.1 |
| Fedora | 28 ~ 33 |
| CentOS | 7.0 ~ 8.3 |
> 如果您的系统或版本未在此列表中则不能使用一键更换国内源脚本
#### __脚本部署：__
    bash <(curl -sSL https://ghproxy.com/https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install.sh)
> _再次提醒：请根据您使用的平台选择合适的版本，不要重复部署！_
#### __常见问题与帮助：__
1. 如果执行部署脚本命令后提示 `Command 'curl' not found` 则说明当前未安装 `curl` 软件包，安装命令如下：

       apt install -y curl 或 yum install -y curl
2. 如果执行脚本部署命令后没有反应直接结束并跳回终端交互说明您的网络环境存在问题，请检查您的网络连通性。
3. 如在拉取活动脚本时失败提示 `ssh: connect to host gitee.com port 22: Connection timed out` 是由于您使用平台的 `22` 端口不可用所导致，自行解决处理。
4. 如在拉取活动脚本时失败提示 `Repository more than 5 connections` 是由于 `Gitee` 限制了每秒同时拉取项目的IP不能超过 `5` 个所导致，此报错为正常现象，重新执行更新命令即可。
5. 如在拉取活动脚本时失败提示 `Permission denied` 是因为私钥没有生效造成的错误，详见[Issues #95](https://github.com/SuperManito/JD-FreeFuck/issues/95)。
6. 如果 `控制面板` 功能未安装成功是由于网络原因导致的，可执行下面的命令重新安装：

       cd /opt/jd/panel
       npm install || npm install --registry=https://registry.npm.taobao.org
       npm install -g pm2
       pm2 start server.js
7. 部署成功后无法访问`控制面板`是由于`5678 端口`外部不能访问所导致。
ㅤ

***

> 下面是 `Docker` 版本的部署教程，执行命令前请先看注释内容，请根据您使用的平台选择合适的版本，不要重复部署！

***

### `Docker` 版本

#### __部署前需知与准备工作：__
1. 下面的教程涉及 `容器技术` 专业知识，执行命令前请先看 `注释内容` ，若无法理解请先百度或向我咨询。
2. 使用 `NAS` | `软路由` 的朋友请在终端执行下面教程中的命令，不要使用图形界面。
3. `控制面板` 功能的初始用户名为 `useradmin`，初始密码为 `supermanito`。
3. 如果您平台的网络环境暴露在了公网（例如VPS用户），请根据《使用与更新》教程更改密码。
#### __安装 Docker Server 客户端：__

    sudo curl -sSL https://get.daocloud.io/docker | sh
> _注意：大部分设备默认自带ㅤ`Docker` 客户端，如果没有安装请先执行此官方命令一键安装。_
#### __下载镜像：__
    docker pull registry.cn-hangzhou.aliyuncs.com/supermanito/jd
> _注意：此镜像大约需要占用 `239MB` 的空闲存储空间，目前最新版本的镜像ID为 `a1b8632268d1` 。_
#### __启动容器：__
    docker run -dit \
    -v /opt/jd/scripts:/jd/scripts `# 设置活动脚本的主机挂载目录为/opt/jd/scripts` \
    -v /opt/jd/config:/jd/config `# 设置配置文件的主机挂载目录为/opt/jd/config` \
    -v /opt/jd/log:/jd/log `# 设置日志的主机挂载目录为/opt/jd/log` \
    -p 5678:5678 `# 设置端口映射，格式为 "主机端口:容器端口"，主机端口号可自定义` \
    -e ENABLE_HANGUP=true `# 启用挂机功能` \
    -e ENABLE_WEB_PANEL=true `# 启用控制面板功能` \
    --name jd `# 设置容器名为jd` \
    --network bridge `# 设置网络为桥接，直连主机` \
    --hostname jd `# 设置主机名为jd` \
    --restart always `# 设置容器开机自启` \
    registry.cn-hangzhou.aliyuncs.com/supermanito/jd
> _注意：1.如果是旁路由，容器网络类型需使用ㅤ`host` 模式，请将 `--network bridge` 参数改成 `--network host`，_\
> _ㅤㅤㅤ2.如果设备不存在 `opt` 目录，先通过命令 `mkdir -p /opt/jd` 目录。_\
> _ㅤㅤㅤ3.如果设才用的是云服务器部署，请将`--network bridge`删除掉，保证网络能通docker，并能访问面板。_
#### __初始化容器：__
    docker logs -f jd
> _注意：请先执行此命令查看初始化容器进度，当输出 `容器启动成功......` 字样即代表容器创建成功，此时通过命令 `Ctrl + C` 退出即可。_
#### __常见问题与帮助：__
1. 如在拉取活动脚本时失败提示 `ssh: connect to host gitee.com port 22: Connection timed out` 是由于您使用平台的 `22` 端口不可用所导致，自行解决处理。
2. 如在拉取活动脚本时失败提示 `Repository more than 5 connections` 是由于 `Gitee` 限制了每秒同时拉取项目的IP不能超过 `5` 个所导致，此报错为正常现象，重新执行更新命令即可。
3. 如在拉取活动脚本时失败提示 `Permission denied` 是因为私钥没有生效造成的错误，详见[Issues #95](https://github.com/SuperManito/JD-FreeFuck/issues/95)。ㅤ

***

## 三、配置项目

***

> 到此项目已部署完毕，接下来需要您账户的“身份证”，它由 `Cookie部分内容` 组成，将它写入至配置文件中才可以开始使用\
> 此部分教程的配置操作也可在 `控制面板` 功能中的 `WEB网页` 完成配置，可取代在终端输入命令，具体看下方教程的注释

***

### 关于如何获取账号信息的途径：
- 通过 `控制面板` 功能进入 `WEB网页` 手机扫码获取，此方式获取的“身份证”有效期为3个月 __（优先推荐）__
- 通过浏览器开发工具获取，在 Wiki [ GetCookies ](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)有详细的图文教程，此方式获取的“身份证”有效期为1个月

### 1. 配置账户

- 将获得的`Cookie部分内容`填入下面命令中的“双引号”内复制完整命令到终端并执行：

      sed -i '28c Cookie1=""' config/config.sh
      sed -i '29c Cookie2=""' config/config.sh
      sed -i '30c Cookie3=""' config/config.sh
      sed -i '31c Cookie4=""' config/config.sh
      sed -i '32c Cookie5=""' config/config.sh
      sed -i '33c Cookie6=""' config/config.sh
> _参考命令：sed -i '28c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' config/config.sh_

> _注意：1. 执行此命令前 `Linux` 版需要进入项目安装目录，`Docker` 版需要进入容器内。_\
> _ㅤㅤㅤ2. 此操作对应 `控制面板` 功能 `首页` 中的 28~33 行内容，具体教程查看注释内容。_\
> _ㅤㅤㅤ3. 用几个账号就执行几行命令，超出6个账号后需要自行在 `config.sh` 配置文件中创建变量。_
### 2. 配置消息推送功能
> _详见 `config.sh` 配置文件中的注释教程，很详细......_

***

## 四、使用项目
> 关于如何使用此项目，请前往至 [Wiki](https://github.com/SuperManito/JD-FreeFuck/wiki/) ，项目后续的更新、修复都在其页面发布！

- __`Linux`  版本使用教程 ㅤ[ 点击此处前往 ](https://github.com/SuperManito/JD-FreeFuck/wiki/Linux-Use-And-Update-Tutorial)__
- __`Docker` 版本使用教程 ㅤ[ 点击此处前往 ](https://github.com/SuperManito/JD-FreeFuck/wiki/Docker-Use-And-Update-Tutorial)__
> _注意：您使用的哪个版本就用哪个版本的教程，不要混用，重要的事情说三遍！_\
> _ㅤㅤㅤ您使用的哪个版本就用哪个版本的教程，不要混用，重要的事情说三遍！_\
> _ㅤㅤㅤ您使用的哪个版本就用哪个版本的教程，不要混用，重要的事情说三遍！_\
> _ㅤㅤㅤ如果你是从`Linux`更换为`Docker`版本时，请使用 lsof -i:5678，查看是否端口被占用，若被占用，请使用kill pid 解决掉这个端口_

***

## 五、卸载项目
### `Linux` 版本
- 删除项目文件

      rm -rf /opt/jd
- 卸载软件包

      apt/yum remove -y git perl moreutils nodejs npm
### `Docker` 版本
- 删除容器

      docker rm -f jd
- 删除容器挂载目录

      rm -rf /opt/jd
- 删除镜像

      docker rmi -f registry.cn-hangzhou.aliyuncs.com/supermanito/jd
> __若您 `已接受` 本项目声明，您必须在下载后的 `24小时` 内从计算机中完全删除相关内容。__

***

## 六、帮助与支持
- __如果您有意见与建议或者遇到问题需要我的协助，欢迎到[ Issues ](https://github.com/SuperManito/JD-FreeFuck/issues)提交反馈__
- __为了提高效率快速解决您的问题，请严格按照模板提交，感谢您的理解与配合__

***

## 赞赏码
<img src="https://gitee.com/SuperManito/JD-FreeFuck/raw/main/icon/thank.jpg" width="300" height="300" alt="微信赞赏码"/><br/>
### 如果您愿意支持此项目，可对我打赏，感激不尽！
### 开发不易、维护艰辛，感谢您的理解与支持！

***

## Stargazers over time
<img src="https://starchart.cc/SuperManito/JD-FreeFuck.svg" width="500" height="250" alt="Stargazers over time"/><br/>

***

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
