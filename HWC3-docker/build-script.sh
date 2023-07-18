#!/bin/bash

# List of image directories
images=("elasticsearch" "filebeat" "kibana" "logstash")

# Iterate over each image directory
for dir in "${images[@]}"; do
  # Change into the image directory
  cd "$dir"
  
  # Build the Docker image
  docker build -t "$dir" .

  # Start the Ansible playbook in the background
  ansible-playbook playbook.yml &

  # Return to the parent directory
  cd ..
done

# Wait for all background processes to finish
wait