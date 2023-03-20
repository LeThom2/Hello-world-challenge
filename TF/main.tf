# terraform {
#   required_providers {
#     elasticsearch = {
#       source = "disaster37/elasticsearch"
#       version = "8.4.0"
#       }
#     aws = {
#       source = "hashicorp/aws"
#       version = "4.53.0"
#       }
#   }
# }

provider "aws" {
  region = "us-east-1"
}

# provider "elasticsearch" {
#     urls     = "http://44.213.113.90:9200"
# }

resource "aws_instance" "logstash_server" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.TF_security_group.name]
  key_name        = "TF_key"
  user_data       = data.template_cloudinit_config.user_scripts_logstash.rendered
  private_ip      = "172.31.13.1"

  tags = {
    Name = "logstash_server"
  }
}

resource "aws_instance" "EKF_server" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.TF_security_group.name]
  key_name        = "TF_key"
  user_data       = data.template_cloudinit_config.user_scripts_EKF.rendered
  private_ip      = "172.31.13.2"

  tags = {
    Name = "EKF_server"
  }
}

resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}


# resource elasticsearch_index_lifecycle_policy "my_ilm" {
#   name = "terraform-ilm"
#   policy = <<EOF
# {
#   "policy": {
#     "phases": {
#       "hot": {},
#       "delete": {
#         "min_age": "1d",
#         "actions": {
#           "delete": {}
#         }
#       }
#     }
#   }
# }
# EOF
# }

# Copy a file with Terraform as part of Hello World Challange part 1
# resource "local_file" "HWC_Copy" {
#         content     = file ("/Users/Thom.Benjamins/Desktop/HWC/app.py")
#         filename    = "/Users/Thom.Benjamins/Desktop/HWC-Copy/app_copy.py"
# }