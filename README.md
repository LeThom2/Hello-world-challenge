# Hello-world-challenge
My Hello world challenge as part of the new starter onboarding in the Horizon team
These are merely notes for myself

## Requirements
Install: Python(3), Terraform, Elasticsearch, Logstash, Kibana, Filebeat, Ansible
Access to AWS account

### Launch
Elasticsearch -> Kibana -> Filebeat -> Logstash

### Manual
'pip install python-dotenv' to make use of .env file

Run 'python(3) app.py' -> Prints string and creates logs to track, with added verbosity.

#### Terraform ->
terraform init -> terraform plan -> terraform apply.
Make sure TF.exe is in environment variables on OS

#### Ansible ->
(Windows) Launch Ubuntu, ls to see available playbooks, if none: create, to run: 'Ansible-playbook <playbook_name>'