#!/bin/bash

name=pg055-gl
rolearn=$(cat /local/gamemetadata/gamelift-metadata.json | jq -r .instanceRoleArn)
region=ap-northeast-1
output=json

echo rolearn=$rolearn

json=$(aws sts assume-role --role-arn ${rolearn} --role-session-name ${name})

accesskeyid=$(echo ${json} | jq -r .Credentials.AccessKeyId)
secretaccesskey=$(echo ${json} | jq -r .Credentials.SecretAccessKey)
sessiontoken=$(echo ${json} | jq -r .Credentials.SessionToken)


echo accesskeyid=$accesskeyid

aws --profile $name configure set aws_access_key_id ${accesskeyid}
aws --profile $name configure set aws_secret_access_key ${secretaccesskey}
aws --profile $name configure set aws_session_token ${sessiontoken}
aws --profile $name configure set region ${region}
aws --profile $name configure set output ${output}

echo create credential profile ${name} done.

exit 0
