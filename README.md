__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__

***

> __您使用的哪个版本就用哪个版本的教程，不要混用！__

***

# 更新与修复
- __2021/2/26 17:55 `更新`__\
ㅤ更新了 `manual-update` 一键更新脚本，格式化了此脚本，现在可以在目录外执行两个一键脚本，更新命令位于对应版本教程《使用与更新》之第四类的第1条。
>使用举例：
>
>     source /opt/jd/run-all.sh
>     bash /opt/jd/manual-update.sh

- __2021/2/26 14:40 `修复`__\
ㅤ修复了 `Liunx` 版定时重复的问题，更新命令位于《使用与更新》之第四类<更新教程>的第4条。`Docker` 版还在加班排错中，请持续关注此项目......

- __2021/2/25 10：00 `修复`__\
ㅤ修复了一键生成互助码脚本的错误，使用此脚本的朋友请更新此脚本，更新命令位于对应版本教程《使用与更新》之第四类<更新教程>的第2条。

- __2021/2/24 17:50 `修复`__\
ㅤ目前收到反馈部分朋友执行`run-all.sh`脚本后遇到报错并卡住，原因是由于diy脚本中的`fanslove`活动脚本错误，原作者还修复中，请大家执行下面的命令解决此问题：
>`Linux` 版本用户：
>
>     rm -rf /opt/jd/scripts/*love.js
>     wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/sample/diy.sh -O /opt/jd/config/diy.sh\
>`Docker` 版本用户
>
>     docker exec -it jd rm -rf scripts/*love.js
>     docker exec -it jd wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/docker/diy-docker.sh -O config/diy.sh


- __2021/2/24 02:00 `更新`__
ㅤ增加了本人深度定制的`diy`脚本，可通过下面的步骤部署到您的项目中：

>     1. 请先更新配置文件，命令位于对应版本教程《使用与更新》之第四类<更新教程>的第3条
>     2. 通过对应版本教程《使用与更新》之第三类<高阶使用教程>的第5条命令启用该功能
>     3. 执行一键更新命令完成部署


# 使用教程

- __`Linux`  版本使用教程 ㅤ[ 点击此处前往 ](https://github.com/SuperManito/JD-FreeFuck/wiki/Linux-Use-And-Update-Tutorial)__
- __`Docker` 版本使用教程 ㅤ[ 点击此处前往 ](https://github.com/SuperManito/JD-FreeFuck/wiki/Docker-Use-And-Update-Tutorial)__

***

__如果您觉得这个项目不错的话可以在右上角给颗⭐吗？方便分享给更多的朋友吗？__
