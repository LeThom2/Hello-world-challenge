# Part two of the Hello World Challenge

## Manual part:
* Create virtual machine via AWS portal.
* Install Logstash onto the created VM.
* Get Logstash to to read logs from one folder and write logs to another in a single pipeline.
* Change Logstash pipeline to split it and use pipeline to pipeline communication.

## Automation part:
* Create VM via Terraform.
* Install Logstash via script.
* Incorporate Logstash install script and pipeline into Terraform code.
* Modify solution so that Filebeat writes data to Logstash, Logstash should be configured to use 3 pipelines to write the logs to Elasticsearch.
* Amend configuration for Elasticsearch so that an ILM policy removes replicas in the index after 1 day.