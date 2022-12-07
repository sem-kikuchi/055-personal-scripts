#!/usr/bin/env 

from jinja2 import Template, Environment, FileSystemLoader
import json
import sys

args = sys.argv
filename = args[1]
host = args[2]
region = args[3]

def main(filename, host, region):

    env = Environment(loader = FileSystemLoader('./', encoding = 'utf8'))
    tmpl = env.get_template(filename)

    rendered_s = tmpl.render(host = host, region = region)
    print(rendered_s)

main(filename = filename, host = host, region = region)
