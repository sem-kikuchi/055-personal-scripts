#!/bin/bash

# Download and install the agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm

# Copy the cloudwatch agent configuration file to the right directory
sudo cp amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Start the agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# install jq
sudo yum install -y jq

# Python (statsd) install
sudo amazon-linux-extras install python3.8 -y
sudo pip3.8 install statsd psutil jinja2

# custom metrics collect service register
sudo chmod +x statsd_monitor.py 
sudo chmod +x statsd_monitor.sh 

sudo cp statsd_monitor@.service /etc/systemd/system/

sudo systemctl enable statsd_monitor@"metrics"
sudo systemctl start statsd_monitor@"metrics"
# sudo systemctl status statsd_monitor@"metrics"


# create dashboard
fleetid=$(cat /local/gamemetadata/gamelift-metadata.json | jq -r .fleetId)
hostname=$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/.$//g')

echo fleetid=${fleetid}
echo hostname=${hostname}
echo region=${region}

## TODO: create dashboard
