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

# ----------------------------------------
# Security Group — open SSH
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

# ----------------------------------------
# IAM Role for EC2

resource "aws_iam_role" "pokemon_ec2_role" {
  name = "pokemon-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach AmazonDynamoDBFullAccess to the role
resource "aws_iam_role_policy_attachment" "pokemon_attach_dynamodb" {
  role       = aws_iam_role.pokemon_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

# Instance profile to bind the role to EC2
resource "aws_iam_instance_profile" "pokemon_ec2_profile" {
  name = "pokemon-ec2-profile"
  role = aws_iam_role.pokemon_ec2_role.name
}

# ----------------------------------------
# EC2 Instance
resource "aws_instance" "pokemon_instance" {
  ami                    = "ami-039f97a3f98ab3761"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.pokemon_sg.id]

  # Attach the IAM instance profile
  iam_instance_profile = aws_iam_instance_profile.pokemon_ec2_profile.name

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "pokemon-instance"
  }
}

# ----------------------------------------
# Output the public IP
output "instance_public_ip" {
  value = aws_instance.pokemon_instance.public_ip
}
