# Part one of the Hello world challenge

## Brief: Coding part
* Create python app that sends logs into a separate file, and able to read and output an environment variable.
* Use Terraform to move a file from on location to another (your python app)
* Insert environment variable using ansible.

## Brief: Manual part
* Read logs from file using filebeat.
* Write logs into an Elasticsearch index.
* Create saved search in Kibana.
* Create dashboard in Kibana containing saved search.

## Requirements: 
* Python(3), Terraform, Elasticsearch, Logstash, Kibana, Filebeat, Ubuntu, and Ansible installed.
* Access to AWS account
* Elasticsearch, Kibana, and Filebeat are running with appropriate configuration.

### Commands:
* 'pip install python-dotenv'
* 'python(3) app.py' runs the app

### Terraform:
* terraform init -> terraform plan -> terraform apply.
* Make sure TF.exe is in environment variables on OS

### Ansible ->
* (Windows) Launch Ubuntu, 'ls' to see available playbooks, if none: create, to run: 'Ansible-playbook <playbook_name>'