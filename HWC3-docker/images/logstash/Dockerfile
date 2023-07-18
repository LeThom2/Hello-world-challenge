FROM docker.elastic.co/logstash/logstash:7.12.0

COPY config/pipelines.conf /usr/share/logstash/pipeline

CMD ["logstash", "-f", "/usr/share/logstash/pipeline/pipelines.conf"]