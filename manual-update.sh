#!/bin/bash
rm -rf /home/myid/jd/manual-update.sh
touch /home/myid/jd/manual-update.sh
chmod +x /home/myid/jd/manual-update.sh
cat > /home/myid/jd/manual-update.sh << EOF
#!/bin/bash
bash git_pull.sh
rm -rf run-all.sh
touch run-all.sh
chmod +x run-all.sh
bash jd.sh | grep _ >> run-all.sh
sed -i '1d' run-all.sh
sed -i 's/^/bash jd.sh &/g' run-all.sh
sed -i 's/$/& now/g' run-all.sh
sed -i '1i\#!/bin/bash' run-all.sh
EOF
echo -e "\033[32m --------------------- 更新成功 --------------------- \033[0m"
1
