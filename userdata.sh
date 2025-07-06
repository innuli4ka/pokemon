#!/bin/bash
# Update packages
apt update -y

# Install Git, Python, and pip
apt install -y git python3 python3-pip

# Clone your repo as ubuntu user
sudo -u ubuntu git clone https://github.com/innuli4ka/pokemon.git /home/ubuntu/app

# Install boto3
pip3 install boto3

# Append auto-run line to ubuntu's .bash_profile *as ubuntu user*
sudo -u ubuntu bash -c 'echo "python3 /home/ubuntu/app/ui.py" >> /home/ubuntu/.bash_profile'
