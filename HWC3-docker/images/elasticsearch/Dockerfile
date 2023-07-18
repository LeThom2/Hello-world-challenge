FROM docker.elastic.co/elasticsearch/elasticsearch:7.12.0

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

EXPOSE 9200
EXPOSE 9300

CMD ["elasticsearch"]