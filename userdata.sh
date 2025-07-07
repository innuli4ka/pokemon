    #!/bin/bash
    cd /home/ubuntu
    git clone https://github.com/innuli4ka/pokemon.git
    chown -R ubuntu:ubuntu /home/ubuntu/pokemon
    echo 'if [ -n "$SSH_CONNECTION" ]; then cd ~/pokemon && python3 ui.py & fi' >> /home/ubuntu/.bashrc

