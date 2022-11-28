#!/usr/bin/env 

import json
import sys

args = sys.argv
filename = args[1]
startport = args[2]
endport = args[3]

def main(filename, startport, endport):

    # base json load
    json_str = open(filename, 'r')
    agent = json.load(json_str)

    # procstat modify
    procstat = []
    for i in range(int(startport), int(endport) + 1):
        dict = {}
        dict['pattern'] = "PORT=" + str(i)
        dict['measurement'] = ["cpu_usage", "cpu_time", "read_bytes", "write_bytes", "memory_rss", "memory_data"]
        procstat.append(dict)

    agent['metrics']['metrics_collected']['procstat'] = procstat

    # log setting modify
    collect_list = []
    dict = {}
    dict['file_path'] = "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
    dict['log_group_name'] = "/aws/gamelift/AmazonCloudWatchAgentLogs"
    dict['log_stream_name'] = "AmazonCloudWatchAgentLogs-{instance_id}"
    dict['timezone'] = "UTC"
    collect_list.append(dict)

    for i in range(0, int(endport) - int(startport) + 1):
        dict = {}
        if i == 0:
            suffix = ""
        else:
            suffix = "_" + str(i + 1)
        dict['file_path'] = "/local/game/PRJ055/Saved/Logs/PRJ055" + suffix + ".log"
        dict['log_group_name'] = "/aws/gamelift/GameServerLogs"
        dict['log_stream_name'] = "GameServerLogs-{ip_address}-PRJ055" + suffix + ".log"
        dict['timezone'] = "Local"
        collect_list.append(dict)

    agent['logs']['logs_collected']['files']['collect_list'] = collect_list

    # json generate
    enc = json.dumps(agent, indent=2)
    print(enc)

main(filename = filename, startport = startport, endport = endport)
