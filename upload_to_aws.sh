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
aws gamelift upload-build --name gg_game_server_build --build-version ${ver} --build-root ./ --operating-system AMAZON_LINUX_2 --profile pg055

popd

echo "done"