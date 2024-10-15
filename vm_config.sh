#!/bin/bash

# Update and upgrade packages
sudo apt-get update
sudo apt-get upgrade -y

# Install necessary packages
sudo apt install make vim openssh-server

# Add Docker's official GPG key
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Set up the stable repository
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker Engine
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce -y
sudo apt-get update
sudo systemctl enable docker
sudo systemctl start docker

# Clean up
sudo rm -rf /var/lib/apt/lists/*

if [ ! -d "/home/$USER/data" ]; then \
	mkdir /home/$USER/data; \
	echo "data directory created successfully"; \
fi

# Set redirection to the VM's IP address
sudo cp /etc/hosts /etc/hosts.backup
sudo chmod 777 /etc/hosts
sudo echo "127.0.0.1 yusengok.42.fr" >> /etc/hosts
sudo chmod 644 /etc/hosts

# Add User to docker group
sudo usermod -aG docker $USER
sudo reboot
