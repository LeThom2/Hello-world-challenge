#! /bin/bash

############### ELASTICSEARCH ###############

# Elsatic GPG key
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Config Elastic
elastic="[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md"
echo "$elastic" > /etc/yum.repos.d

# Install Elastic
yum install --enablerepo=elasticsearch elasticsearch 


############### KIBANA ###############

# Install Darwin package of Kibana
curl -O https://artifacts.elastic.co/downloads/kibana/kibana-8.6.2-darwin-x86_64.tar.gz
curl https://artifacts.elastic.co/downloads/kibana/kibana-8.6.2-darwin-x86_64.tar.gz.sha512 | shasum -a 512 -c - 
tar -xzf kibana-8.6.2-darwin-x86_64.tar.gz
cd kibana-8.6.2/
