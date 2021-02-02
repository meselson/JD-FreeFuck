#!/bin/bash
#Author:SuperManito
#Update Date:2021-2-3

rm -rf /opt/jd/manual-update.sh
touch /opt/jd/manual-update.sh
cat > /opt/jd/manual-update.sh << EOF
#!/bin/bash
docker exec -it jd bash git_pull.sh
rm -rf /opt/jd/run-all.sh
touch /opt/jd/run-all.sh
docker exec -it jd bash jd.sh | grep -o 'jd_[a-z].*' > /opt/jd/run-all.sh
docker exec -it jd bash jd.sh | grep -o 'jx_[a-z].*' >> /opt/jd/run-all.sh
sed -i 's/^/docker exec -it jd bash jd.sh &/g' /opt/jd/run-all.sh
sed -i 's/.js/ now/g' /opt/jd/run-all.sh
sed -i '1i\#!/bin/bash' /opt/jd/run-all.sh
cat /opt/jd/run-all.sh | grep jd_crazy_joy_coin -wq
if [ $? -eq 0 ];then
    sed -i "s/docker exec -it jd bash jd.sh jd_crazy_joy_coin now//g" /opt/jd/run-all.sh
    sed -i '/^\s*$/d' /opt/jd/run-all.sh
    echo "docker exec -it jd bash jd.sh jd_crazy_joy_coin now" >>/opt/jd/run-all.sh
fi
dos2unix /opt/jd/run-all.sh
EOF
bash /opt/jd/manual-update.sh
echo -e "\033[32m ------------------------- 更 新  成 功 ------------------------- \033[0m"
echo -e "\033[32m +==============================================================+ \033[0m"
echo -e "\033[32m | 特别提示：后续使用遇到问题请访问本人Github项目页寻求帮助     | \033[0m"
echo -e "\033[32m |           我不是该项目的开发者，所有活动问题与我无关         | \033[0m"
echo -e "\033[32m |           但我会维护我的两个原创一键脚本，请持续关注此项目   | \033[0m"
echo -e "\033[32m | 项目网址：https://github.com/SuperManito/JD-FreeFuck         | \033[0m"
echo -e "\033[32m +==============================================================+ \033[0m"
