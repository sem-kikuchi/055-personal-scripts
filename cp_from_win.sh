#!/bin/bash

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

rm -rf ../linux_build/*
scp -r kikuchi@192.168.45.27:D:\\prj055\\trunk\\Development\\Games\\PRJ055\\Saved\\StagedBuilds\\LinuxServer ../linux_build

popd

echo "done"