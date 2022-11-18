#!/bin/bash

# Download and install the agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm

# Copy the cloudwatch agent configuration file to the right directory
sudo cp amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Start the agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s


# Python (statsd) Install
sudo amazon-linux-extras install python3.8 -y
sudo pip3.8 install statsd watchdog pandas

# custom metrics collect in background
sudo chmod +x statsd_monitor.py 

pyhon3.8 statsd_monitor.py metrics &
pyhon3.8 statsd_monitor.py metrics_1 &

