provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "EC2-TF" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.TF_security_group.name]
  key_name = "TF_key"
  user_data = file("filebeat.sh")

  tags = {
    Name = "EC2-TF"
  }
}


resource "aws_security_group" "TF_security_group" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = "vpc-02d198584f7bcf660"

  #inbound rules
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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

# resource "local_file" "HWC_Copy" {
#         content     = file ("/Users/Thom.Benjamins/Desktop/HWC/app.py")
#         filename    = "/Users/Thom.Benjamins/Desktop/HWC-Copy/app_copy.py"
# }