#!/usr/bin/env /usr/bin/python3.8

import statsd
import time
import sys
from enum import IntEnum
from statsd import StatsClient

args = sys.argv
metrics_str = args[1]
filename = args[2]

class Metrics(IntEnum):
    TIMESTAMP = 0
    AVE_FPS = 1
    AVE_MS = 2
    CONNECTION_NUM = 3
    AVE_PING = 4
    MAX_PING = 5
    IN_RATE = 6
    OUT_RATE = 7
    ACTOR_COUNT = 8
    ACTIVE_NW_OBJ = 9
    SUSPEND_NW_OBJ = 10
    SERVER_REPLICATE_ACTOR = 11
    REPLICATE_ACTOR_TIME = 12
    REPLICATE_GATHER_PRIORITIE_TIME = 13
    NUM_REPLICATE_ACTOR_CALL = 14
    NUM_REPLICATE_ACTOR_CALL_PER_CON_AVG = 15

def main():
    spl_str = metrics_str.split()
    statsd = StatsClient('localhost', 8125, prefix='custom.' + filename)
    statsd.gauge('ave_fps', float(spl_str[Metrics.AVE_FPS]))
    statsd.gauge('ave_ms',  float(spl_str[Metrics.AVE_MS]))
    statsd.gauge('connection_num',  int(spl_str[Metrics.CONNECTION_NUM]))
    statsd.gauge('ave_ping',  float(spl_str[Metrics.AVE_PING]))
    statsd.gauge('max_ping',  float(spl_str[Metrics.MAX_PING]))
    statsd.gauge('in_rate',  float(spl_str[Metrics.IN_RATE]))
    statsd.gauge('out_rate',  float(spl_str[Metrics.OUT_RATE]))
    statsd.gauge('actor_count',  int(spl_str[Metrics.ACTOR_COUNT]))
    statsd.gauge('active_nw_obj',  int(spl_str[Metrics.ACTIVE_NW_OBJ]))
    statsd.gauge('suspend_nw_obj',  int(spl_str[Metrics.SUSPEND_NW_OBJ]))
    statsd.gauge('server_replicate_actor',  float(spl_str[Metrics.SERVER_REPLICATE_ACTOR]))
    statsd.gauge('replicate_actor_time',  float(spl_str[Metrics.REPLICATE_ACTOR_TIME]))
    statsd.gauge('replicate_gather_prioritie_time',  float(spl_str[Metrics.REPLICATE_GATHER_PRIORITIE_TIME]))
    statsd.gauge('num_replicate_actor_call',  int(spl_str[Metrics.NUM_REPLICATE_ACTOR_CALL]))
    statsd.gauge('num_replicate_actor_call_per_con_avg',  float(spl_str[Metrics.NUM_REPLICATE_ACTOR_CALL_PER_CON_AVG]))

main()

