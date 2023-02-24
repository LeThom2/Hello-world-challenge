#! /bin/bash
# Install Logstash and configure pipelines

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
  config.string: input { beats { port => 5044 } } output { pipeline { send_to => ['pipeline2'] } }
- pipeline.id: pipeline2
  config.string: input { pipeline { address => pipeline2 } } output { pipeline { send_to => ['pipeline3'] } }
- pipeline.id: pipeline3
  config.string: input { pipeline { address => pipeline3 } } output { elasticsearch { hosts => ['172.31.13.2:9200'] data_stream => "true" } }"
echo "$pipelineyaml" > /etc/logstash/pipelines.yml

# Create outputFile for logstash to output the message
touch /var/log/outputfile.log

cd /usr/share/logstash
sudo bin/logstash --path.settings '/etc/logstash'

# sudo tail -f /var/log/logstash/logstash-plain.log