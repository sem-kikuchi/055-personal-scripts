#!/usr/bin/env 

from jinja2 import Environment, FileSystemLoader
import json
import sys

args = sys.argv
filename = args[1]
host = args[2]
region = args[3]
startport = int(args[4])
endport = int(args[5])


def main(filename, host, region):

    env = Environment(loader = FileSystemLoader('./', encoding = 'utf8'))
    tmpl = env.get_template(filename)

    rendered_s = tmpl.render(host = host, region = region)

    dbwidgets = json.loads(rendered_s)

    widgets = dbwidgets['widgets']
    for item in widgets:
        b = item['properties']['metrics'][0]
        cl = []
        for i in range(startport, endport + 1):
            e = json.dumps(b)
            e = e.replace('<<< port >>>', str(i))
            ec = json.loads(e)
            cl.append(ec)
        item['properties']['metrics'] = cl

    dbwidgets['widgets'] = widgets
    newjson = json.dumps(dbwidgets,indent=2)

    print(newjson)

main(filename = filename, host = host, region = region)
