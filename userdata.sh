#!/bin/bash

# Go to ubuntu's home
cd /home/ubuntu

# Clone your repo
git clone https://github.com/innuli4ka/pokemon.git
chown -R ubuntu:ubuntu /home/ubuntu/pokemon

# Write AWS credentials for boto3
mkdir -p /home/ubuntu/.aws

cat <<EOF > /home/ubuntu/.aws/credentials
[default]
aws_access_key_id = ${aws_access_key}
aws_secret_access_key = ${aws_secret_key}
region = ${aws_region}
EOF

chown -R ubuntu:ubuntu /home/ubuntu/.aws

# Add auto-run to .bashrc
echo 'if [ -n "$SSH_CONNECTION" ]; then cd ~/pokemon && python3 ui.py; fi' >> /home/ubuntu/.bashrc
