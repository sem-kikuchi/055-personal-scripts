#!/usr/bin/env 

import json
import sys

args = sys.argv
filepath = args[1]

def main(filepath):

    locations=[]

    with open(filepath) as f:
        for line in f:
            if (not line.startswith('#') and len(line.strip()) != 0):
                dict = {}
                dict['Location'] = line.strip()
                locations.append(dict)

    enc = json.dumps(locations, indent=2)
    print(enc)


main(filepath = filepath)
