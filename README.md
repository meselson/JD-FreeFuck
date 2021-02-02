__如果您觉得这个项目不错的话可以在右上角给颗小星星吗？方便分享给更多的朋友吗？ (∩_∩)__

***

__更新：__\
__2021/2/3__\
__更新了一键脚本，将` run-all.sh `一键执行所有活动脚本中的` crazy_joy_coin `挂机活动移动到了末尾，这样就不用每次中途执行` Ctrl + C `命令跳过了，请大家执行更新命令，在下方第四部分第5条。__\
\
__通知：__\
__2021/1/31__\
__由于某D安全团队介入，原作者Github项目资源被封或已下架，导致Linux直装失效，根据大佬给出的方案，经过本人的研究，现已推出基于GNU/Linux的[ Dokcer ](https://hub.docker.com/r/evinedeng/jd)版本，请大家重新部署！__

- __旧版本系统直装与现版本在Docker容器上运行无任何关联，之前系统直装的朋友删除home下myid整个目录即可。__

***

# 《JD薅羊毛》一键部署 For Linux
## 用途：通过 JavaScript 与 Shell 自动化脚本参与JD商城的各种活动从而白嫖J豆
## 支持的 GNU/Linux (简体中文) 发行版：
- __`Ubuntu`：支持 16.04 ~ 20.10 版本，建议优先使用Ubuntu系统__
- __`Debian`：支持 9.0 ~ 10.7 版本__
- __`Fedora`：支持 32 ~ 33 版本__
- __`CentOS`：支持 8.0 ~ 8.3 版本，如果是最小化安装，请通过SSH方式进入到终端__

  _温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文，暂不支持WSL，如果您使用的系统不在本项目的支持范围内，请根据[  Wiki教程 ](https://github.com/SuperManito/JD-FreeFuck/wiki/%E9%92%88%E5%AF%B9%E9%A1%B9%E7%9B%AE%E6%9C%AA%E9%80%82%E9%85%8D-GNU-Linux%E5%8F%91%E8%A1%8C%E7%89%88-%E7%9A%84%E9%83%A8%E7%BD%B2%E6%96%B9%E6%B3%95)自行部署，如果遇到问题请及时向我反馈，谢谢！_\
\
__此项目`码云Gitee`同步更新，如果您所在的环境经常性无法访问Github，建议收藏Gitee项目发布页[ 点击此处访问 ](https://gitee.com/SuperManito/JD-FreeFuck)__
***

# 下面进入正题，部署教程共三步，请认真阅读下面的内容
    
***

## 一、命令一键部署
__Github：__

    bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/install.sh)
__Gitee：__

    bash <(curl -sL https://gitee.com/SuperManito/JD-FreeFuck/raw/main/install.sh)
- 附1. 如果提示`Command 'curl' not found`则说明当前未安装`curl`软件包，安装命令如下：

      apt install -y curl 或 yum install -y curl
- 附2. 如果没有科学上网方式使用Github命令部署项目时提示`无法解决Hosts`，可通过添加解析记录以解决连通性问题，添加命令如下：

      echo "199.232.96.133 raw.githubusercontent.com" >> /etc/hosts
      echo "151.101.88.133 raw.githubusercontent.com" >> /etc/hosts
- 附3. 如果执行一键命令后无效或部署后遇到报错怎么办？

      1）检查系统版本、联网状态等基本条件
      2）检查容器是否启动正常、镜像仓库是否可用
      3）多次执行manual-update.sh更新脚本尝试
- 附4. 如果你已经安装了`Docker`不想用我的一键脚本？

      docker run -dit \
      -v /opt/jd/config:/jd/config `# 设置配置文件的主机挂载目录为/opt` \
      -v /opt/jd/log:/jd/log `# 设置日志的主机挂载目录为/opt` \
      -p 5678:5678 `# 设置端口映射，格式为 "内部端口号:外部端口号" ，外部端口号可自定义` \
      -e ENABLE_HANGUP=true `# 启用挂机功能` \
      -e ENABLE_WEB_PANEL=true `# 启用控制面板功能` \
      --name jd `# 设置容器名为jd` \
      --network bridge `# 设置网络为桥接，直连主机` \
      --hostname jd `# 设置主机名为jd` \
      --restart always `# 设置容器开机自启` \
      evinedeng/jd:gitee
    _注：如果镜像拉取失败提示`TLS handshake timeout`，那么请将镜像仓库换成国内阿里云，另外不是所有的国内仓库都有大佬的镜像并且不一定是最新版，使用阿里云肯定没有问题。_
    
***

## 二、接下来我们需要您JD账户的“身份证”，它由`Cookie部分内容`组成，下面是获取途径：
__1. 在[ Wiki ](https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies)有详细的图文教程，请点击链接自行获取，此方式获取的Cookie部分内容有效期为1个月。__\
__2. 通过`控制面板`功能进入浏览器网页手机扫码获取，此方式获取的Cookie部分内容有效期为3个月。（优先推荐）__

***

## 三、手动配置信息
### 将获得的`Cookie部分内容`填入下面命令中的“双引号”内，复制完整命令到终端并执行。（必填）
    sed -i '27c Cookie1=""' /opt/jd/config/config.sh
  _参考命令：sed -i '27c Cookie1="pt_pin=xxxxx;pt_key=xxxxxxx;"' /home/myid/jd/config/config.sh_
- 附1. 该项目可同时运行多个账号，请按顺序填入下面命令中的“双引号”内，用几个就执行几条对应的命令，复制完整命令到终端并执行：

      sed -i "28c Cookie2=$COOKIE2" /opt/jd/config/config.sh
      sed -i "29c Cookie3=$COOKIE3" /opt/jd/config/config.sh
      sed -i "30c Cookie4=$COOKIE4" /opt/jd/config/config.sh
      sed -i "31c Cookie5=$COOKIE5" /opt/jd/config/config.sh
      sed -i "32c Cookie6=$COOKIE6" /opt/jd/config/config.sh
   _注：账号无上限，超出6个账号后需要自己在配置文件创建变量，自行查看配置文件中的注释。_
- 附2. 如果需要使用[ Server酱 ](http://sc.ftqq.com/)微信推送功能请将`SCKEY`填入下面的双引号内，复制完整命令到终端并执行：

      sed -i '70c export PUSH_KEY=""' /opt/jd/config/config.sh
- 以上全部内容也可在控制面板功能中的浏览器网页完成配置，可取代Linux命令

***

## 四、使用与更新
- 1.如何运行一键脚本开始白嫖京豆？

      bash run-all.sh
    _注：此脚本内容为执行所有活动脚本，期间会执行挂机活动脚本（crazy_joy_coin），可通过命令`Ctrl+C`跳过。_
- 2.如何更新一键脚本与活动脚本？

      bush manual-update.sh
    _注：建议每次运行活动脚本前执行一次，JD活动经常变化，原作者更新也很频繁。_
- 3.更新活动脚本失败或遇到报错怎么办？

      docker exec -it jd /bin/bash  # 进入容器
      bash git_pull.sh              # 更新活动脚本 
      exit                          # 退出容器         
    _注：因为上面更新命令是在容器容器外部执行，可能会遇到报错，原因未知，进入容器执行命令就能解决。_
- 4.如何查看帮助文档并获取更多功能？

      docker exec -it jd cat readme.md
- 5.如何升级与更新？

      bash <(curl -sL https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/update.sh)
    _注：适用于后期维护更新，当遇到问题需要更新时会在项目置顶通知。_
    
***

## 五、声明
1. 本人项目为二次使用，我不是该《JD薅羊毛》项目的开发者，所有活动类问题与我无关。
2. `run-all.sh`为本人编写的一键执行所有活动脚本，`manual-update.sh`为本人编写的一键更新脚本，自己查看一下这两个文件内容就全明白了，如果你不想用我写的一键脚本请自行删除，其余所有文件均为原作者创作。\
\
__原作者项目链接：__\
__[ lxk0301/jd_scripts ](https://gitee.com/lxk0301/jd_scripts/tree/master/) 　## JavaScripts活动脚本开发者__\
__[ EvineDeng ](https://github.com/evinedeng) 　　　　## Linux环境Shell套壳作者__\
__[ evinedeng/jd ](https://hub.docker.com/r/evinedeng/jd) 　　　## 本项目所使用的Docker镜像__
    
***

## 六、项目需知
1. 该项目配置文件以及一键脚本所在目录为`/opt/jd`
2. 此项目涉及 `Docker 容器技术`，如果你对 `Docker基础命令` 一无所知，那么请不要随意改动容器
3. 执行 `run-all` 脚本期间可能会卡住或运行挂机脚本，可通过命令 `Ctrl + C` 跳过继续执行剩余活动脚本
4. 由于JD活动一直变化所以会出现无法参加活动、报错等正常现象，可手动更新活动脚本
5. 如果需要更新活动脚本，请执行 `bash manual-update.sh` 命令进行一键更新即可
6. 之前填入的 `Cookie部分内容` 具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新
7. 因为本人每天也在使用，遇到错误会在第一时间解决，遇到任何与部署相关的问题都可访问本项目寻求帮助

***

## 如果您有意见与建议欢迎到 [Issuse](https://github.com/SuperManito/JD-FreeFuck/issues) 反馈
## 如果老板成功薅到羊毛，赏5毛可否(∩_∩)
<img src="https://m.qpic.cn/psc?/V50n9XtX0l0n6J3udmyK2gRcEx18FnXh/45NBuzDIW489QBoVep5mcbTMgCjpKAAK.sAHneYsD2JkZhvOqMXe6eJqnrUjeaIWidOGbhjLKMcjmIUXh.T5iMtKA6HmNU30Pu2EijiozuE!/b&bo=OAQ4BAAAAAADJwI!&rf=viewer_4" width="300" height="300" alt="微信赞赏码"/><br/>
