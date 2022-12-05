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

metricsgroup=gg_gamelift_logs
role=arn:aws:iam::953675754374:role/prj055-gamelift-role

echo name=${name}
echo buildid=${buildid}

location=$(python gen_location.py ./location-list.txt)
instancetype=c4.large

inbound=$(python gen_inbound.py ./inbound-list.txt ${startport} ${endport})
config=$(python gen_config.py ${startport} ${endport})

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
--debug \
--profile pg055

popd

echo "done"
