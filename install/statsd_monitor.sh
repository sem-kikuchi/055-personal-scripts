#!/bin/bash

filepath=${1}
metricsname=${2}

CURRENT=$(cd $(dirname $0);pwd)

tail -F ${filepath} -n0 | xargs -I@ ${CURRENT}/statsd_monitor.py @ ${metricsname}

exit 0
