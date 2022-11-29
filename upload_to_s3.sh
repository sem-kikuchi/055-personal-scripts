#!/bin/bash

ver=${1}

if [ $# == 1 ]; then
    startport=7777
    endport=7778
else
    startport=${2}
    endport=${3}
fi


filename='./install/amazon-cloudwatch-agent.json'

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

config=$(python gen_cloudwatch_agent.py ${filename} ${startport} ${endport})
scripts=$(python gen_install_script.py ${startport} ${endport})

cp ./install/* ../linux_build/LinuxServer

popd

pushd $CURRENT/../linux_build/LinuxServer

echo -e "${config}" > amazon-cloudwatch-agent.json
echo -e "${scripts}" >> install.sh

chmod +x *.sh
chmod +x PRJ055/Binaries/Linux/PRJ055Server
mkdir -p PRJ055/Saved/Logs/
touch PRJ055/Saved/Logs/dummy.txt

date=$(date +"%Y%m%d-%H%M%S")

fn=server-${date}-${ver}.zip
bucket=gg-gamelift-server-build
role=arn:aws:iam::953675754374:role/prj055-gamelift-role

rm -rf temp
mkdir temp

# s3 upload
echo s3 upload to s3://${bucket}/${fn}

zip -r -7 ./temp/${fn} ./
aws s3 cp ./temp/${fn} s3://${bucket}/ --profile pg055

echo upload done.
echo s3://${bucket}/${fn}

popd

echo "done"