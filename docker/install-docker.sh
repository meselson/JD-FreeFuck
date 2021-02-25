#!/bin/bash
## Author:SuperManito
## Modified:2021-2-25

function EnvStructures() {
  echo -e '\033[37m+---------------------------------------------------+ \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|   =============================================   | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|      欢迎使用《京东薅羊毛》一键部署 For Linux     | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m|   =============================================   | \033[0m'
  echo -e '\033[37m|                                                   | \033[0m'
  echo -e '\033[37m+---------------------------------------------------+ \033[0m'
  sleep 3s
  ## 通过添加SSH私钥与公钥解决访问lxk/jd_scripts私有库的权限问题
  rm -rf ~/.ssh/id_rsa
  wget -P ~/.ssh https://gitee.com/SuperManito/JD-FreeFuck/raw/main/source/id_rsa
  chmod 600 ~/.ssh/id_rsa
  ssh-keygen -y -f ~/.ssh/id_rsa >~/.ssh/id_rsa.pub
  ## 删除活动脚本目录
  rm -rf scripts
  ## 更换新的文件
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/source/jd.sh -O jd.sh
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/source/git_pull.sh -O git_pull.sh
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/sample/config.sh.sample -O sample/config.sh.sample
  ## 创建配置文件
  rm -rf config.sh
  cp -f sample/config.sh.sample config/config.sh
  cp -f sample/computer.list.sample config/crontab.list
  ## 拉取项目文件
  bash git_pull.sh
  ## 更正定时任务
  sed -i "s#/home/myid/jd/jd.sh#jd#g" config/crontab.list
  sed -i "s#/home/myid/jd/##g" config/crontab.list
  ## 下载最新的一键更新脚本
  wget https://gitee.com/SuperManito/JD-FreeFuck/raw/main/docker/manual-update-docker.sh -O manual-update.sh >/dev/null 2>&1
  bash manual-update.sh
}
EnvStructures
