#! /bin/bash

# Pipeline2Pipeline script: installs logstash which reads one file and
# writes that to another, using multiple pipelines

# Update VM and install Java for Logstash
yum update -y
yum install java -y

# Redhat package manager to import repo
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Include config into logstash.repo
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

# Include message into inputFile.log
message="Hello World!"
echo "$message" > /etc/logstash/inputFile.log

# Create outputFile for logstash to output the message
touch /etc/logstash/outputFile.log

# Configure pipeline.yml file
pipelineyaml="- pipeline.id: pipeline1
  config.string: input { file { path => '/etc/logstash/inputFile.log' start_position => 'beginning' } } output { pipeline { send_to => ['pipeline2'] } }
- pipeline.id: pipeline2
  config.string: input { pipeline { address => pipeline2 } } output { file { path => '/etc/logstash/outputFile.log' } }"
echo "$pipelineyaml" > /etc/logstash/pipelines.yml

cd /usr/share/logstash
bin/logstash --path.settings '/etc/logstash'