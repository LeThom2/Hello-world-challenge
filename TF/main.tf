provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "EC2-TF" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.TF_security_group.name]
  key_name = "TF_key"
  user_data = file("logstash.sh")

  tags = {
    Name = "EC2-TF"
  }
}

resource "aws_security_group" "TF_security_group" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = "vpc-0de3e5f349e7906c0"

  #inbound rules
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF_security_group"
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

# resource "local_file" "Hello_world_challenge" {
#         content     = file("C:\\Users\\P432884\\OneDrive - Nationwide Building Society\\Desktop\\Hello-world-challenge\\app.py")
#         filename    = "C:\\Users\\P432884\\OneDrive - Nationwide Building Society\\Desktop\\Copy_folder\\copy_app.py"
# }