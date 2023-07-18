provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "logstash_server" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.TF_security_group.name]
  key_name        = "TF_key"
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