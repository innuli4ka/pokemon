terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token = var.aws_session_token  # << This is needed for session tokens!
}

variable "region" {
  default = "us-west-2"
}

variable "aws_session_token" {
  description = "Session token for temporary credentials"
}

variable "ami" {
  description = "AMI ID for Ubuntu"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Your EC2 key pair name"
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
}


# Security Group
resource "aws_security_group" "pokemon_sg" {
  name_prefix = "pokemon-sg-"
  description = "Allow SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "pokemon_game" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.pokemon_sg.id]

  # Uses templatefile to inject keys
user_data = templatefile("${path.module}/userdata.sh", {
  aws_access_key     = var.aws_access_key
  aws_secret_key     = var.aws_secret_key
  aws_session_token  = var.aws_session_token
  aws_region         = var.region
})

  tags = {
    Name = "pokemon-final"
  }
}

# Output
output "instance_public_ip" {
  value = aws_instance.pokemon_game.public_ip
}
