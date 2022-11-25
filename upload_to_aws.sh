#!/bin/bash

ver=${1}

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

cp ./install/* ../linux_build/LinuxServer

popd

pushd $CURRENT/../linux_build/LinuxServer

chmod +x *.sh
chmod +x PRJ055/Binaries/Linux/PRJ055Server
mkdir -p PRJ055/Saved/Logs/
touch PRJ055/Saved/Logs/dummy.txt
aws gamelift upload-build --name gg_game_server_build --build-version ${ver} --build-root ./ --operating-system AMAZON_LINUX_2 --profile pg055

popd

echo "done"