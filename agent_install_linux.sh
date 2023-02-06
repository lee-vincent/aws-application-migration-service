#!/usr/bin/env bash
for i in $(cat computers.txt) 
    do ssh $USER@$i \
  "curl -o aws-discovery-agent.tar.gz https://s3-us-west-2.amazonaws.com/aws-discovery-agent.us-west-2/linux/latest/aws-discovery-agent.tar.gz \
  tar xvf aws-discovery-agent.tar.gz \
  sudo bash install -r 'us-east-1' -k $1 -s $2"
done