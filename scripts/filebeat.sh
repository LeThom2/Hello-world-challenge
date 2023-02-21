#! /bin/bash
# Pipeline2Pipeline script: installs logstash which reads one file and
# writes that to another, using multiple pipelines

#update VM and install Java for Logstash
yum update -y
yum install java -y

############### FILEBEAT ###############
# Filebeat package
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.6.2-x86_64.rpm
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Filebeat.yml config
filebeat="filebeat.inputs:
- type: filestream
  id: my-filestream-id
  enabled: true
  paths:
    - /etc/logstash/inputFile.log"
echo "$filebeat" > /etc/filebeat/filebeat.yml

cd /etc/filebeat/modules.d


############### LOGSTASH ###############
# Logstash package
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Logstash.repo config
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

# Pipeline.yml config
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

# service filebeat start