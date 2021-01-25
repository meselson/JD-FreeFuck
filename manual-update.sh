#!/bin/bash
#Author:SuperManito
#Update Date:2021-1-24
rm -rf /home/myid/jd/manual-update.sh
touch /home/myid/jd/manual-update.sh
cat > /home/myid/jd/manual-update.sh << EOF
#!/bin/bash
bash git_pull.sh
rm -rf run-all.sh
touch run-all.sh
bash jd.sh | grep -o 'jd_[a-z].*' > run-all.sh
bash jd.sh | grep -o 'jx_[a-z].*' >> run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/$/& now/g' run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
EOF
bash /home/myid/jd/manual-update.sh
echo -e "\033[32m ------------------------- 更 新  成 功 ------------------------- \033[0m"
echo -e "\033[32m +==============================================================+ \033[0m"
echo -e "\033[32m | 特别提示：后续使用遇到问题请访问本人Github项目页寻求帮助     | \033[0m"
echo -e "\033[32m |           我不是该项目的开发者，所有活动问题与我无关         | \033[0m"
echo -e "\033[32m |           但我会维护我的两个原创一键脚本，请持续关注此项目   | \033[0m"
echo -e "\033[32m | 项目网址：https://github.com/SuperManito/JD-FreeFuck         | \033[0m"
echo -e "\033[32m +==============================================================+ \033[0m"
