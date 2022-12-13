#!/bin/bash

host=${1}
region=${2}
fleetname=${3}
startport=${4}
endport=${5}

CURRENT=$(cd $(dirname $0);pwd)

pushd $CURRENT

json=$(python3 create_dashboard.py dashboard-base.j2 ${host} ${region} ${startport} ${endport})

name=${host//\./-}

# echo $json
aws cloudwatch put-dashboard --dashboard-name ${fleetname}_${name} --dashboard-body "$json"  --profile pg055

popd