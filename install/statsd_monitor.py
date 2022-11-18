#!/usr/bin/env python3.8

import statsd
import time
import pandas as pd
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
from enum import IntEnum
from statsd import StatsClient
import sys

args = sys.argv
arg_filename = args[1]

DIRECTORY = '/local/game/PRJ055/Saved/Logs/'
FILE = arg_filename + ".txt"
PATH = DIRECTORY + FILE

len_df = -1

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

class TextFileEventHandler(PatternMatchingEventHandler):
    def __init__(self, patterns=['*.txt'], ignore_patterns=None, ignore_directories=True, case_sensitive=False):
        super().__init__(patterns, ignore_patterns, ignore_directories, case_sensitive)

    def on_modified(self, event):
        if event.src_path[-len(FILE):] != FILE:
            return

        bef_len_df = len_df
        df = save_len_df()

        mod_str = df[bef_len_df:].to_string(index=False, header=None).split()

        # print_df(filename=event.src_path, df=df, start=bef_len_df)

        statsd = StatsClient('localhost', 8125, prefix='custom.' + arg_filename)
        statsd.gauge('ave_fps', float(mod_str[Metrics.AVE_FPS]))
        statsd.gauge('ave_ms',  float(mod_str[Metrics.AVE_MS]))
        statsd.gauge('connection_num',  int(mod_str[Metrics.CONNECTION_NUM]))
        statsd.gauge('ave_ping',  float(mod_str[Metrics.AVE_PING]))
        statsd.gauge('max_ping',  float(mod_str[Metrics.MAX_PING]))
        statsd.gauge('in_rate',  float(mod_str[Metrics.IN_RATE]))
        statsd.gauge('out_rate',  float(mod_str[Metrics.OUT_RATE]))
        statsd.gauge('actor_count',  int(mod_str[Metrics.ACTOR_COUNT]))
        statsd.gauge('active_nw_obj',  int(mod_str[Metrics.ACTIVE_NW_OBJ]))
        statsd.gauge('suspend_nw_obj',  int(mod_str[Metrics.SUSPEND_NW_OBJ]))
        statsd.gauge('server_replicate_actor',  float(mod_str[Metrics.SERVER_REPLICATE_ACTOR]))
        statsd.gauge('replicate_actor_time',  float(mod_str[Metrics.REPLICATE_ACTOR_TIME]))
        statsd.gauge('replicate_gather_prioritie_time',  float(mod_str[Metrics.REPLICATE_GATHER_PRIORITIE_TIME]))
        statsd.gauge('num_replicate_actor_call',  int(mod_str[Metrics.NUM_REPLICATE_ACTOR_CALL]))
        statsd.gauge('num_replicate_actor_call_per_con_avg',  float(mod_str[Metrics.NUM_REPLICATE_ACTOR_CALL_PER_CON_AVG]))

def save_len_df():
    df = pd.read_csv(PATH, header=None)
    len_df = len(df)
    return df

def print_df(filename, df, start):
    print(filename + ":" + df[start:].to_string(index=False, header=None))

def main():
    observer = Observer()
    observer.schedule(TextFileEventHandler(), DIRECTORY, recursive = False)    
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.unschedule_all()
        observer.stop()

main()