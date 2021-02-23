#!/usr/bin/env bash
## Author:SuperManito
## Modified:2021-2-23

## 项目安装目录
BASE="/opt/jd"

#添加hosts;如无法正常下载Github Raw文件，请注释掉
Host_IP=('151.101.88.133' '151.101.228.133')
Host_Name=('raw.githubusercontent.com' 'raw.githubusercontent.com')
for (( i=0; i<=${#Host_IP[@]}; i++ )) do
echo "${Host_IP[$i]} ${Host_Name[$i]}" >> /etc/hosts
done

##############################作者昵称（必填）##############################
# 使用空格隔开
author_list="i-chenzhe whyour"

##############################作者脚本地址URL（必填）##############################
# 例如：https://raw.githubusercontent.com/whyour/hundun/master/quanx/jx_nc.js
# 1.从作者库中随意挑选一个脚本地址，每个作者的地址添加一个即可，无须重复添加
# 2.将地址最后的 “脚本名称+后缀” 剪切到下一个变量里（my_scripts_list_xxx）
scripts_base_url_1=https://raw.githubusercontent.com/i-chenzhe/qx/main/
scripts_base_url_2=https://raw.githubusercontent.com/whyour/hundun/master/quanx/


##############################作者脚本名称（必填）##############################
# 将相应作者的脚本填写到以下变量中
my_scripts_list_1="jd_asus_iqiyi.js jd_entertainment.js jd_fanslove.js jd_getFanslove.js"
my_scripts_list_2="jd_collectBlueCoin.js ddxw.js"

## 活动脚本名称1：华硕-爱奇艺、百变大咖秀、粉丝互动、粉丝互动活动获取
## 活动脚本名称2：京东超市领蓝币、东东小窝

##############################随机函数##########################################
rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(cat /proc/sys/kernel/random/uuid | cksum | awk -F ' ' '{print $1}')
    echo $(($num%$max+$min))
}
cd $BASE
index=1
for author in $author_list
do
  echo -e "开始下载 $author 的脚本"
  # 下载my_scripts_list中的每个js文件，重命名增加前缀"作者昵称_"，增加后缀".new"
  eval scripts_list=\$my_scripts_list_${index}
  echo $scripts_list
  eval url_list=\$scripts_base_url_${index}
  echo $url_list
  for js in $scripts_list
  do
    eval url=$url_list$js
    echo $url
    eval name=$js
    echo $name
    wget -q --no-check-certificate $url -O $name.new

    # 如果上一步下载没问题，才去掉后缀".new"，如果上一步下载有问题，就保留之前正常下载的版本
    # 随机添加个cron到crontab.list
    if [ $? -eq 0 ]; then
      mv -f $name.new $name
      echo -e "更新 $name 完成...\n"
	  croname=`echo "$name"|awk -F\. '{print $1}'`
	  script_date=`cat  $name|grep "http"|awk '{if($1~/^[0-59]/) print $1,$2,$3,$4,$5}'|sort |uniq|head -n 1`
	  if [ -z "${script_date}" ];then
	    cron_min=$(rand 1 59)
	    cron_hour=$(rand 7 9)
	    [ $(grep -c "$croname" $BASE/config/crontab.list) -eq 0 ] && sed -i "/hangup/a${cron_min} ${cron_hour} * * * bash jd $croname"  $BASE/config/crontab.list
	  else
	    [ $(grep -c "$croname" $BASE/config/crontab.list) -eq 0 ] && sed -i "/hangup/a${script_date} bash jd $croname"  $BASE/config/crontab.list
	  fi
    else
      [ -f $name.new ] && rm -f $name.new
      echo -e "更新 $name 失败，使用上一次正常的版本...\n"
    fi
  done
  index=$[$index+1]
done
