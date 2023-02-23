#! /bin/bash
# Server with Elastic, Kibana and Filebeat

#update VM and install Java for Logstash
yum update -y
yum install java -y

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

cluster.initial_master_nodes: ['"MC02C9DYALVDL"']

http.host: 0.0.0.0"
echo "$elasticyaml" > /etc/elasticsearch/elasticsearch.yml
#cluster.initial_master_nodes: ['"MC02C9DYALVDL"']

# Automatic start of Elasticsearch
systemctl start elasticsearch
# cd /usr/share/elasticsearch
# /bin/systemctl daemon-reload
# /bin/systemctl enable elasticsearch.service


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

kibanayaml="server.port: 5601
server.host: 'localhost'

elasticsearch.hosts: ['http://localhost:9200']

elasticsearch.username: 'kibana_system'
elasticsearch.password: '""'
"
echo "$kibanayaml" > /etc/kibana/kibana.yml

# Automatically launch Kibana
systemctl start kibana
# cd /usr/share/kibana
# /bin/systemctl daemon-reload
# /bin/systemctl enable kibana.service


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
filebeat="filebeat.inputs:
- type: filestream
  id: my-filestream-id
  enabled: true
  paths:
    - /etc/logstash/inputFile.log

filebeat.config.modules:
  path: ${path.config}/modules.d/*.yml
  reload.enabled: false

setup.template.settings:
  index.number_of_shards: 1

setup.kibana:

output.logstash:
  hosts: ['"localhost:5044"']
  
processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~"
echo "$filebeat" > /etc/filebeat/filebeat.yml

systemctl start filebeat