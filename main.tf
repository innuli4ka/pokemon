# Variables

variable "region" {
  description = "AWS region to deploy to"
  default     = "us-west-2"
}

provider "aws" {
  region = var.region
}

variable "key_name" {
  default = "vockey"
}


# If your VPC is the default, you can skip setting it explicitly.
# Otherwise, set your VPC ID here:
# variable "vpc_id" {
#   default = "vpc-xxxxxxxxxxxxxxx"
# }

# Security Group — open SSH
resource "aws_security_group" "pokemon_sg" {
  name_prefix = "pokemon-sg-"
  description = "Allow SSH"
  # vpc_id = var.vpc_id  # Uncomment if you set VPC explicitly

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all — lock down in real use
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "pokemon_instance" {
  ami           = "ami-039f97a3f98ab3761"
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.pokemon_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "pokemon-instance"
  }
}

# Output the public IP
output "instance_public_ip" {
  value = aws_instance.pokemon_instance.public_ip
}

