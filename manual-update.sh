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
