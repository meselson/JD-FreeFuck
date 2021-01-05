# 《京东薅羊毛》一键部署脚本
## 通过参与京东商城的各种活动白嫖京豆
## 如何获得项目需要的COOKIE部分内容请访问 Wiki ，链接如下
## https://github.com/SuperManito/JD-FreeFuck/wiki/Cookie-Get
## 适用系统：CentOS 8简体中文，不适用7及更低版本
## 本人测试环境为最新CentOS 8.3，系统装完后联网即可，无需其它任何操作
## 此脚本核心内容来自于lxk0301大神托管至GitHub的项目，定期更新核心JavaScript脚本内容
原作者官方GitHub项目网址：\
https://github.com/lxk0301/jd_scripts  #此项目核心JavaScript脚本原作者\
https://github.com/EvineDeng/jd-base   #此项目环境原作者

注意：该项目主目录为/home/myid/jd\
注意：为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误\
注意：执行脚本期间可能会卡住，可通过命令 Ctrl + C 跳过继续执行剩余活动脚本\
注意：run-all.sh脚本内容含义为执行所有活动脚本，可使用cat或bash jd.sh命令查看内容和教程\
注意：由于京东活动一直变化所以会出现无法参加活动等正常现象，可手动更新JavaScript活动脚本\
注意：如果需要更新核心JavaScript活动脚本，请执行 bash manual-update.sh 命令进行一键更新即可\
注意：之前填入的Cookie部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过脚本对应处的命令手动更新\
配置文件位于/home/myid/jd/config/config，命令为sed -i '27c Cookie1=""' /home/myid/jd/config/config

## 有问题可以联系本人解决，可将问题发送至liu2273689770@gmail.com
