#!/usr/bin/env 

import json
import sys

args = sys.argv
filepath = args[1]
startport = args[2]
endport = args[3]

def main(filepath):

    inbounds=[]

    with open(filepath) as f:
        for line in f:
            if (not line.startswith('#') and len(line.strip()) != 0):
                dict = {}
                dict['FromPort'] = int(startport)
                dict['ToPort'] = int(endport)
                dict['IpRange'] = line.strip()
                dict['Protocol'] = "UDP"
                inbounds.append(dict)

                dict = {}
                dict['FromPort'] = 22
                dict['ToPort'] = 22
                dict['IpRange'] = line.strip()
                dict['Protocol'] = "TCP"
                inbounds.append(dict)


    enc = json.dumps(inbounds, indent=2)
    print(enc)


main(filepath = filepath)
