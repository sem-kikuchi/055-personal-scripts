#!/bin/bash

ver=${1}
s3arn=${2}

list=(${s3arn//\// })

bucket=$(echo ${s3arn%/*} | sed -e 's/s3:\/\///')
fn=$(echo ${s3arn##*/})
role=arn:aws:iam::953675754374:role/prj055-gamelift-role

echo $bucket
echo $fn
echo $role

# exit

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

echo gamelift create-build

json=$(aws gamelift create-build \
    --name gg_game_server_build \
    --build-version ${ver} \
    --storage-location Bucket=${bucket},Key=${fn},RoleArn=${role} \
    --operating-system AMAZON_LINUX_2 \
    --profile pg055)

echo ${json}
buildid=$(echo ${json} | jq -r .Build.BuildId)

echo ----- create build done. -----
echo buildid = ${buildid}

popd

echo "done"