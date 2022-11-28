#!/bin/bash

# Download and install the agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm

# Copy the cloudwatch agent configuration file to the right directory
sudo cp amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Start the agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s


# Python (statsd) install
sudo amazon-linux-extras install python3.8 -y
sudo pip3.8 install statsd

# custom metrics collect service register
sudo chmod +x statsd_monitor.py 
sudo chmod +x statsd_monitor.sh 

sudo cp statsd_monitor@.service /etc/systemd/system/

