#!/bin/bash

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

name=${1}
buildid=${2}

if [ $# == 2 ]; then
    startport=7777
    endport=7778
else
    startport=${3}
    endport=${4}
fi

docker-compose up -d --build

metricsgroup=gg_gamelift_logs
role=arn:aws:iam::953675754374:role/prj055-gamelift-role
# role=arn:aws:iam::953675754374:role/service-role/prj055-gamelift-service-role

echo name=${name}
echo buildid=${buildid}

cp location-list.txt ./python-work/
location=$(docker exec -it python3 python gen_location.py /work/location-list.txt)

instancetype=c4.large

cp inbound-list.txt ./python-work/
inbound=$(docker exec -it python3 python gen_inbound.py /work/inbound-list.txt ${startport} ${endport})
config=$(docker exec -it python3 python gen_config.py ${startport} ${endport})

aws gamelift create-fleet --name ${name} \
--metric-groups ${name} \
--description "create by aws cli" \
--build-id ${buildid} \
--instance-role-arn ${role} \
--runtime-configuration "${config}" \
--metric-groups ${metricsgroup} \
--locations "${location}" \
--ec2-instance-type ${instancetype} \
--fleet-type SPOT \
--ec2-inbound-permissions "${inbound}" \
--profile pg055

popd

echo "done"
