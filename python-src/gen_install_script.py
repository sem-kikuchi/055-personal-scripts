#!/usr/bin/env 

import json
import sys

args = sys.argv
startport = args[1]
endport = args[2]

def main(startport, endport):

    print("")
    
    for i in range(0, int(endport) - int(startport) + 1):
        if i == 0:
            suffix = ""
        else:
            suffix = "_" + str(i)

        print("### port " + str(i + int(startport)) + " service")
        print("sudo systemctl enable statsd_monitor@\"metrics" + suffix + "\"")
        print("sudo systemctl start statsd_monitor@\"metrics" + suffix + "\"")
        print("# sudo systemctl status statsd_monitor@\"metrics" + suffix + "\"")
        print("")

main(startport = startport, endport = endport)
