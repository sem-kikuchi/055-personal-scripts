#!/usr/bin/env 

# import statsd
import time
import sys
from enum import IntEnum
# from statsd import StatsClient

args = sys.argv
metrics_str = args[1]
filename = args[2]

class Metrics(IntEnum):
    TIMESTAMP = 0
    PROCESS_ID = 1
    AVE_FPS = 2
    AVE_MS = 3
    CONNECTION_NUM = 4
    AVE_PING = 5
    MAX_PING = 6
    IN_RATE = 7
    OUT_RATE = 8
    ACTOR_COUNT = 9
    ACTIVE_NW_OBJ = 10
    SUSPEND_NW_OBJ = 11
    SERVER_REPLICATE_ACTOR = 12
    REPLICATE_ACTOR_TIME = 13
    REPLICATE_GATHER_PRIORITIE_TIME = 14
    NUM_REPLICATE_ACTOR_CALL = 15
    NUM_REPLICATE_ACTOR_CALL_PER_CON_AVG = 16

def gauge(key, val):
    print(key + " = " + str(val))

def main():
    spl_str = metrics_str.split()
    procid = spl_str[Metrics.PROCESS_ID];
    print("procid=" + procid)
    
    gauge('ave_fps', float(spl_str[Metrics.AVE_FPS]))
    gauge('ave_ms',  float(spl_str[Metrics.AVE_MS]))
    gauge('connection_num',  int(spl_str[Metrics.CONNECTION_NUM]))
    gauge('ave_ping',  float(spl_str[Metrics.AVE_PING]))
    gauge('max_ping',  float(spl_str[Metrics.MAX_PING]))
    gauge('in_rate',  float(spl_str[Metrics.IN_RATE]))
    gauge('out_rate',  float(spl_str[Metrics.OUT_RATE]))
    gauge('actor_count',  int(spl_str[Metrics.ACTOR_COUNT]))
    gauge('active_nw_obj',  int(spl_str[Metrics.ACTIVE_NW_OBJ]))
    gauge('suspend_nw_obj',  int(spl_str[Metrics.SUSPEND_NW_OBJ]))
    gauge('server_replicate_actor',  float(spl_str[Metrics.SERVER_REPLICATE_ACTOR]))
    gauge('replicate_actor_time',  float(spl_str[Metrics.REPLICATE_ACTOR_TIME]))
    gauge('replicate_gather_prioritie_time',  float(spl_str[Metrics.REPLICATE_GATHER_PRIORITIE_TIME]))
    gauge('num_replicate_actor_call',  int(spl_str[Metrics.NUM_REPLICATE_ACTOR_CALL]))
    gauge('num_replicate_actor_call_per_con_avg',  float(spl_str[Metrics.NUM_REPLICATE_ACTOR_CALL_PER_CON_AVG]))

    print("test")

main()

