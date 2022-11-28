#!/bin/bash

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

# rm -rf ../win64_build/*
# scp -r kikuchi@192.168.45.27:D:\\prj055-2\\trunk\\Development\\Games\\PRJ055\\Saved\\StagedBuilds\\Windows ../win64_build

popd

pushd $CURRENT/../win64_build
pwd

zip -r client_win64.zip ./Windows

popd

echo "done"