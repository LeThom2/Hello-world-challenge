#! /bin/bash
#update VM and install Java for Logstash
sudo yum update -y
sudo yum install java -y

#Redhat package manager to import repo -> create file with config .repo
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

logstash="[logstash-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
"

sudo echo "$logstash" > /etc/yum.repos.d/logstash.repo

sudo yum install logstash -y

sudo systemctl start logstash

