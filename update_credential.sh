#!/bin/bash

prof=pg055

pb=$(pbpaste)

ary=(`echo $pb`) 

for i in `seq 1 ${#ary[@]}`
do
    case "${ary[$i-1]}" in
    [*)
        proforg=${ary[$i-1]/[/}
        proforg=${proforg/]/}
        ;;
    aws_access_key_id*)
        aws_access_key_id=${ary[$i-1]/aws_access_key_id=/}
        ;;
    aws_secret_access_key*)
        aws_secret_access_key=${ary[$i-1]/aws_secret_access_key=/}
        ;;
    aws_session_token*)
        aws_session_token=${ary[$i-1]/aws_session_token=/}
        ;;
    esac

done

echo ${proforg}
echo ${aws_access_key_id}
echo ${aws_secret_access_key}
echo ${aws_session_token}

aws --profile $prof configure set aws_access_key_id $aws_access_key_id
aws --profile $prof configure set aws_secret_access_key $aws_secret_access_key
aws --profile $prof configure set aws_session_token $aws_session_token

aws --profile $proforg configure set aws_access_key_id $aws_access_key_id
aws --profile $proforg configure set aws_secret_access_key $aws_secret_access_key
aws --profile $proforg configure set aws_session_token $aws_session_token


echo done.