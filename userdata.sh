#!/bin/bash
#updating all
apt update -y
#installing git and pythםn3
apt install -y git python3
#cloning git repository to dur "app"
git clone https://github.com/innuli4ka/pokemon.git /home/ubuntu/app
#change directory to the new app folder in order to run the ui code
cd /home/ubuntu/app
#in order for the ui.py will work when user loggs in, adding it to the .bash_profile
echo "python3 /home/ubuntu/app/ui.py" >> /home/ubuntu/.bash_profile