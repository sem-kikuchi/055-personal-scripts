#!/bin/bash

ver=${1}

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

cp ./install/* ../linux_build/LinuxServer

popd

pushd $CURRENT/../linux_build/LinuxServer

aws gamelift upload-build --name gg_game_server_build --build-version ${ver} --build-root ./ --operating-system AMAZON_LINUX_2 --profile pg055

popd

echo "done"