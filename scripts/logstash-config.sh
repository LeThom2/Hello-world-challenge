#! /bin/bash

# /etc/logstash/pipelines.yml
echo "- pipeline.id: pipeline1
  config.string: input { beats { port => 5044 } } output { pipeline { send_to => ['pipeline2'] } }
- pipeline.id: pipeline2
  config.string: input { pipeline { address => pipeline2 } } output { pipeline { send_to => ['pipeline3'] } }
- pipeline.id: pipeline3
  config.string: input { pipeline { address => pipeline3 } } output { elasticsearch { hosts => ['172.31.13.2:9200'] data_stream => 'true' } }
  " >> /etc/logstash/pipelines.yml

cd /usr/share/logstash
sudo bin/logstash --path.settings '/etc/logstash'

# sudo tail -f /var/log/logstash/logstash-plain.log