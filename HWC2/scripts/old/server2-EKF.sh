#! /bin/bash
# Server with Elastic, Kibana and Filebeat

#update VM and install Java for Logstash
yum update -y

# Grab public IP address
PUBLIC_IP="$(curl http://checkip.amazonaws.com)"

############### ELASTICSEARCH ###############

# Elsatic GPG key
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# /etc/yum.repos.d/elasticsearch.repo
elastic="[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md"
echo "$elastic" > /etc/yum.repos.d/elasticsearch.repo

# Install Elastic
yum install --enablerepo=elasticsearch elasticsearch -y

# /etc/elasticsearch/elasticsearch.yml
elasticyaml="action.auto_create_index: .monitoring*,.watches,.triggered_watches,.watcher-history*,.ml*
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch

network.host: 0.0.0.0
http.port: 9200

xpack.security.enabled: false
xpack.security.enrollment.enabled: false

xpack.security.http.ssl:
  enabled: false
  keystore.path: certs/http.p12

xpack.security.transport.ssl:
  enabled: false
  verification_mode: certificate
  keystore.path: certs/transport.p12
  truststore.path: certs/transport.p12

cluster.initial_master_nodes: ['ip-172-31-13-2.ec2.internal']

http.host: 0.0.0.0"
echo "$elasticyaml" > /etc/elasticsearch/elasticsearch.yml

# Launch Elasticsearch
systemctl start elasticsearch


############### KIBANA ###############

# Kibana GPG key
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# /etc/yum.repos.d/kibana.repo
kibana="[kibana-8.x]
name=Kibana repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md"
echo "$kibana" > /etc/yum.repos.d/kibana.repo

# Install Kibana
yum install kibana -y

echo "server.port: 5601
server.host: "0.0.0.0"

elasticsearch.hosts: 'http://${PUBLIC_IP}:9200'
" >> /etc/kibana/kibana.yml

# Launch Kibana
systemctl start kibana


# Include message into inputFile.log
message="Hello World!"
echo "$message" > /var/log/inputfile.log

############### FILEBEAT ###############

# Filebeat GPG key
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

# /etc/yum.repos.d/filebeat.repo
filebeat="[elastic-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md"
echo "$filebeat" > /etc/yum.repos.d/filebeat.repo

# Install Filebeat
yum install filebeat -y


# /etc/filebeat/filebeat.yml
filebeatyaml="filebeat.inputs:
- type: filestream
  id: my-filestream-id
  enabled: true
  paths:
    - /var/log/inputfile.log

filebeat.config.modules:
  path: /etc/filebeat/modules.d/*.yml
  reload.enabled: false

setup.template.settings:
  index.number_of_shards: 1

setup.kibana:

output.logstash:
  hosts: ['172.31.13.1:5044']
  
processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~
  #ignore me"
echo "$filebeatyaml" > /etc/filebeat/filebeat.yml

systemctl start filebeat