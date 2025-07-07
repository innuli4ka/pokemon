#!/bin/bash
# Update packages
yum update -y

# Install Git, Python, pip
yum install -y git python3

# Make sure pip3 is present
python3 -m ensurepip

# Upgrade pip
pip3 install --upgrade pip

# Clone your repo as ec2-user
sudo -u ec2-user git clone https://github.com/innuli4ka/pokemon.git /home/ec2-user/app

# Install boto3 globally
pip3 install boto3

# Append auto-run line to ec2-user's .bashrc
sudo -u ec2-user bash -c 'echo "python3 /home/ec2-user/app/ui.py &" >> /home/ec2-user/.bashrc'
