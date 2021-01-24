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
EOF
bash manual-update.sh
echo -e "\033[32m ---------------------- 更新成功 ---------------------- \033[0m"
