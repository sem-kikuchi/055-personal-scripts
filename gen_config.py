#!/usr/bin/env 

import json
import sys

args = sys.argv
startport = args[1]
endport = args[2]

def main(startport, endport):

    config = {}

    configs = []
    for i in range(int(startport), int(endport) + 1):
        dict = {}

        dict['LaunchPath'] = "/local/game/PRJ055/Binaries/Linux/PRJ055Server"
        dict['Parameters'] = "PRJ055 -gamelift PORT=" + str(i)
        dict['ConcurrentExecutions'] = 1
        configs.append(dict)


    config['ServerProcesses'] = configs
    enc = json.dumps(config, indent=2)
    print(enc)

main(startport = startport, endport = endport)
