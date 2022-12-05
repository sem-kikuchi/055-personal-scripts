#!/bin/bash

fleetid=${1}

if [ $# == 2 ]; then
    location=${2}
else
    location=ap-northeast-1
fi


CURRENT=$(cd $(dirname $0);pwd)

pushd $CURRENT

json=`aws gamelift describe-instances --fleet-id ${fleetid} --output json --location ${location} --region ap-northeast-1 --profile pg055 | jq .Instances[0]`

echo ${json}

# exit

instanceid=`echo ${json} | jq -r .InstanceId`
ip=`echo ${json} | jq -r .IpAddress`


json2=`aws gamelift get-instance-access --fleet-id ${fleetid} --instance-id ${instanceid} --region ap-northeast-1 --profile pg055 | jq .InstanceAccess.Credentials`
echo ${json2}

username=`echo ${json2} | jq -r .UserName`
secret=`echo ${json2} | jq -r .Secret`

echo ${username}
echo ${secret}

mkdir pems
temp1=${secret/-----BEGIN RSA PRIVATE KEY-----/}
# echo temp1=${temp1}
temp2=${temp1/-----END RSA PRIVATE KEY-----/}
# echo temp2=${temp2}

echo "-----BEGIN RSA PRIVATE KEY-----" > ./pems/${instanceid}.pem
echo ${temp2} | tr ' ' '\n' >> ./pems/${instanceid}.pem
echo "-----END RSA PRIVATE KEY-----" >> ./pems/${instanceid}.pem

chmod 755 ~/.ssh/${instanceid}.pem
rm -f ~/.ssh/${instanceid}.pem
cp ./pems/${instanceid}.pem ~/.ssh/
chmod 400 ~/.ssh/${instanceid}.pem

echo "ssh -i ~/.ssh/${instanceid}.pem ${username}@${ip}"

popd

echo "access:"

echo "ssh -i ~/.ssh/${instanceid}.pem ${username}@${ip}"