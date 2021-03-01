__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__

***

# 关于 Docker 版本的《使用与更新》教程
## 一、基础使用教程
#### 1. 手动运行一键脚本开始您的薅羊毛行为：
    #进入容器
    docker exec -it jd /bin/bash
    #执行一键脚本
    source run-all.sh
    #退出容器
    exit
> _注意：请进入容器内执行此脚本，只有进入容器内才可以使用 `Ctrl + Z`跳过命令，_\
> _ㅤㅤㅤ此脚本内容为 `执行所有活动脚本` ，您还可对照此脚本中的内容定制此脚本，_\
> _ㅤㅤㅤ除手动运行活动脚本外该项目还会通过定时的方式自动执行活动脚本，注意看日志。_
#### 2. 更新活动脚本与一键脚本：
    docker exec -it jd bash manual-update.sh
> _注意：为了正确配置定时任务，请使用此脚本更新活动脚本。_\
> _ㅤㅤㅤ执行 `run-all.sh`一键执行所有活动脚本前请先执行此更新脚本。_
#### 3. 执行特定活动脚本：
    docker exec -it jd bash jd.sh xxx      # 如果设置了随机延迟并且当时时间不在0-2、30-31、59分内，将随机延迟一定秒数
    docker exec -it jd bash jd.sh xxx now  # 无论是否设置了随机延迟，均立即运行
> _注意：具体查看活动脚本列表可通过命令 `docker exec -it jd bash jd.sh` 查看， `xxx` 为脚本名。_
#### 4. 查看帮助文档：
    docker exec -it jd cat readme.md
#### 5. 进入与退出容器：
    docker exec -it jd /bin/bash
> _注意：`exit`退出容器。_

***

ㅤ
## 二、高阶使用教程
#### 1. 获取互助码：
    #导入脚本
    docker exec -it jd wget -P scripts https://ghproxy.com/https://raw.githubusercontent.com/qq34347476/js_script/master/scripts/format_share_jd_code.js
    #使用脚本
    docker exec -it jd bash jd.sh format_share_jd_code.js now
> _引用声明：这里引用了另一个大佬写的互助码脚本，比 lxk 的好用。引用项目链接：[qq34347476/quantumult-x](https://gitee.com/qq34347476/quantumult-x/tree/master)_
#### 2. 导出互助码：
    docker exec -it jd bash export_sharecodes.sh
#### 3. 启用挂机功能：
    docker exec -it jd bash jd.sh hangup
> _注意：此功能为执行挂机活动脚本，可能此功能会遇到报错，使用人数较少。_
#### 4. 导入并使用第三方活动脚本：
    1. 将脚本放置在该项目容器内 scripts 子目录下，也可放在外部的挂载目录（默认为/opt/jd/scripts）
    2. 然后通过命令 docker exec -it jd bash jd.sh xxx now 运行
    3. 如果您想将第三方脚本加入到 run-all.sh 一键脚本中可将脚本名改为"jd_"开头即可
> _注意：导入的第三方活动脚本不会随项目本身活动脚本的更新而删除。_
#### 5. 使用自定义 `diy` 脚本：
- 使用需知

      1. 此脚本的用途为加入非 lxk0301大佬 的第三方脚本
      2. 您可以开启自动同步功能跟着本人项目里的 diy 脚本走
      3. 您也可以使用本项目中的模板文件自定义构建您的专属脚本
      4. 您可以将您的 diy 脚本上传到您的仓库并使用同步功能
      5. 如果您想使用了您自定义的脚本请关闭自动同步功能
- 启用该功能

      docker exec -it jd sed -i 's/EnableExtraShell=""/EnableExtraShell="true"/g' config/config.sh
- 启用自动同步功能（选择）

      docker exec -it jd sed -i 's/#DiyUpdate/DiyUpdate/g' manual-update.sh
> _注意：1. 此功能由本人开发加入到了 `manual-update` 一键更新脚本中，_\
> _ㅤㅤㅤ2. 启用该功能后便可直接下载或同步更新本项目中的 diy 脚本，_\
> _ㅤㅤㅤ3. 开启此功能后连续执行两次更新命令就可以下载脚本正常使用了，_\
> _ㅤㅤㅤ4. 如果您想更换同步diy脚本的地址链接修改一键更新脚本中的变量即可。_

***

ㅤ
## 三、控制面板教程
#### 1. 手动启用控制面板功能：
    docker exec -it jd pm2 start panel/server.js
> _注意：在某些环境下当系统重启导致控制面板无法访问提示拒绝连接时可用此命令恢复使用。_
#### 2. 手动关闭控制面板功能：
    docker exec -it jd pm2 stop panel/server.js
#### 3. 重置控制面板的用户名和密码：
    docker exec -it jd bash jd.sh resetpwd
#### 4. 更改控制面板访问端口：
    1. 编辑 panel/server.js 文件中的最后，将5678改成您想改成的端口
    2. 重启控制面板完成更改

***

ㅤ
## 四、更新教程
#### 1. 更新一键更新脚本：
    docker exec -it jd wget https://ghproxy.com/https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/manual-update.sh -O manual-update.sh
#### 2. 更新获取互助码脚本：
    docker exec -it jd wget https://ghproxy.com/https://raw.githubusercontent.com/qq34347476/js_script/master/scripts/format_share_jd_code.js -O scripts/format_share_jd_code.js
#### 3. 更新配置文件：
- 备份配置文件

      docker exec -it jd mv config/config.sh config/config.sh.bak
- 替换新的配置文件

      docker exec -it jd wget https://ghproxy.com/https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/source/sample/config.sh.sample -O sample/config.sh.sample
      cp -f sample/config.sh.sample config/config.sh
#### 4. 修复与升级：
- 进入容器

      docker exec -it jd /bin/bash
- 执行更新脚本

      bash <(curl -sSL https://ghproxy.com/https://raw.githubusercontent.com/SuperManito/JD-FreeFuck/main/docker/update-docker.sh)
- 退出容器

      exit
> _注意：适用于后期维护，当遇到问题或优化代码需要修复时会在项目置顶通知，_\
> _ㅤㅤㅤ另外如果您修改了默认安装目录，请自行下载源码并更改相关变量手动更新。_

***

ㅤ
## 五、使用需知
#### 1.  `run-all.sh` 为一键执行所有活动脚本， `manual-update.sh` 为一键更新脚本
#### 2. 手动执行 `run-all.sh` 脚本后无需守在电脑旁，会自动在最后运行挂机活动脚本
#### 3. 执行 `run-all.sh` 脚本期间如果卡住，可按回车键尝试或通过命令 `Ctrl + Z` 跳过继续执行剩余活动脚本
#### 4. 由于京东活动一直变化可能会出现无法参加活动、报错等正常现象，可手动更新活动脚本
#### 5. 如果需要更新活动脚本，请执行 `docker exec -it jd bash manual-update.sh` 命令一键更新即可，它会同步更新 `run-all.sh` 脚本
#### 6. 除手动运行活动脚本外该项目还会通过定时的方式全天候自动运行活动脚本，具体运行记录可通过日志查看
#### 7. 该项目已默认配置好 `Crontab` 定时任务，定时配置文件 `crontab.list` 会通过活动脚本的更新而同步更新
#### 8. 之前填入的 `Cookie部分内容` 具有一定的时效性，若提示失效请根据教程重新获取并手动更新
#### 9. 我不是活动脚本的开发者，但后续使用遇到任何问题都可访问本项目寻求帮助，制作不易，理解万岁

***

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
