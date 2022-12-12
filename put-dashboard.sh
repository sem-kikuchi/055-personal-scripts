#!/bin/bash

json=$(cat dashboard.json)

# echo $json


aws cloudwatch put-dashboard --dashboard-name metrics-fleet-6874a178-a414-47f4-9231-d37c03a52a83 --dashboard-body "$json"  --profile pg055