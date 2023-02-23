#! /bin/bash
# Install and run kibana on separate server

#update VM and install Java for Logstash
yum update -y
yum install java -y

############### LOGSTASH ###############
# Logstash package
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# /etc/yum.repos.d/logstash.repo
logstash="[logstash-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md"
echo "$logstash" > /etc/yum.repos.d/logstash.repo

# Install Logstash
yum install logstash -y

# /etc/logstash/pipelines.yml
pipelineyaml="- pipeline.id: pipeline1
  config.string: input { beats { port => 5044 } start_position => 'beginning' } output { pipeline { send_to => ["pipeline2"] } }
- pipeline.id: pipeline2
  config.string: input { pipeline { address => pipeline2 } } output { pipeline { send_to => ["pipeline3"] } }
- pipeline.id: pipeline3
  config.string: input { pipeline { address => pipeline3 } } output { file { path => '/etc/logstash/outputFile.log' } }"
echo "$pipelineyaml" > /etc/logstash/pipelines.yml

# Include message into inputFile.log
message="Hello World!"
echo "$message" > /etc/logstash/inputFile.log

# Create outputFile for logstash to output the message
touch /etc/logstash/outputFile.log

cd /usr/share/logstash
bin/logstash --path.settings '/etc/logstash'