#! /bin/bash

yum update -y
yum install java -y

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

echo "[logstash-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" >> /etc/yum.repos.d/logstash.repo

yum install logstash -y

rm /etc/yum.repos.d/logstash.repo