#!/bin/bash

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

pushd $CURRENT

name=${1}
buildid=${2}
metricsgroup=gg_gamelift_logs
role=arn:aws:iam::953675754374:role/prj055-gamelift-role

echo name=${name}
echo buildid=${buildid}

location=Location=ap-northeast-1
instancetype=c4.large
# inbound=FromPort=22,ToPort=22,IpRange=153.156.0.146/32,Protocol=TCP

inbound='[
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "153.156.0.146/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "153.125.145.192/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "125.206.239.45/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "160.86.235.223/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "150.249.204.118/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "153.156.42.198/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "35.76.19.121/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 7000,
    "ToPort": 8000,
    "IpRange": "106.72.44.193/32",
    "Protocol": "UDP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "153.156.0.146/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "153.125.145.192/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "125.206.239.45/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "160.86.235.223/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "150.249.204.118/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "153.156.42.198/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "35.76.19.121/32",
    "Protocol": "TCP"
  },
  {
    "FromPort": 22,
    "ToPort": 22,
    "IpRange": "106.72.44.193/32",
    "Protocol": "TCP"
  }
]'


config='{
  "ServerProcesses": [
    {
      "LaunchPath": "/local/game/PRJ055/Binaries/Linux/PRJ055Server",
      "Parameters": "PRJ055 PORT=7777 -gamelift",
      "ConcurrentExecutions": 1
    },
    {
      "LaunchPath": "/local/game/PRJ055/Binaries/Linux/PRJ055Server",
      "Parameters": "PRJ055 PORT=7778 -gamelift",
      "ConcurrentExecutions": 1
    }
  ]
}'

echo ${config}

aws gamelift create-fleet --name ${name} \
--metric-groups ${name} \
--description "create by aws cli" \
--build-id ${buildid} \
--instance-role-arn ${role} \
--runtime-configuration "${config}" \
--metric-groups ${metricsgroup} \
--locations ${location} \
--ec2-instance-type ${instancetype} \
--fleet-type SPOT \
--ec2-inbound-permissions "${inbound}" \
--debug \
--profile pg055

popd

echo "done"
