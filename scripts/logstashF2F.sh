#! /bin/bash
# File2File script: installs logstash which reads one file and writes that to another

#update VM and install Java for Logstash
yum update -y
yum install java -y

#Redhat package manager to import repo
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Incliude config into logstash.repo
logstash="[logstash-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
"
echo "$logstash" > /etc/yum.repos.d/logstash.repo

# Install Logstash
yum install logstash -y

# Include message into inputFile.log
message="Hello World!"
echo "$message" > /etc/logstash/inputFile.log

# Create outputFile for logstash to output the message
touch /etc/logstash/outputFile.log

# Implement the pipeline
pipeline="input {
    file {
        path => '"/etc/logstash/inputFile.log"'
        start_position => '"beginning"'
    }
}
filter { }
output {
    file {
        path => '"/etc/logstash/outputFile.log"'
    }
}"
echo "$pipeline" > /etc/logstash/conf.d/main.conf

cd /usr/share/logstash
bin/logstash --path.settings '/etc/logstash'