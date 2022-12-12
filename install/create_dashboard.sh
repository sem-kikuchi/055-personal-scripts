#!/bin/bash

host=${1}
region=${2}

CURRENT=$(cd $(dirname $0);pwd)

pushd $CURRENT

json=$(python3 create_dashboard.py dashboard-base.j2 ${host} ${region})

name=${host//\./-}

aws cloudwatch put-dashboard --dashboard-name db-${name} --dashboard-body "$json"  --profile pg055

popd