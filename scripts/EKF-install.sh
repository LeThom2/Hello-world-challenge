#! /bin/bash

yum update -y

##### ELASTIC #####
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

echo "[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md" >> /etc/yum.repos.d/elasticsearch.repo

yum install --enablerepo=elasticsearch elasticsearch -y
rm /etc/yum.repos.d/elasticsearch.repo


##### KIBANA #####

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

echo "[kibana-8.x]
name=Kibana repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" >> /etc/yum.repos.d/kibana.repo

yum install kibana -y
rm /etc/yum.repos.d/kibana.repo


##### FILEBEAT #####

rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

echo "[elastic-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" >> /etc/yum.repos.d/filebeat.repo

yum install filebeat -y
rm /etc/yum.repos.d/filebeat.repo