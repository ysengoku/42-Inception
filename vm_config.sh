#!/bin/bash

# Update and upgrade packages
sudo apt-get update
sudo apt-get upgrade -y

# Install necessary packages
sudo apt install make
sudo apt install git

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Set up the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker Engine
sudo apt-get install docker-ce -y
sudo apt-get update

# Install Docker Compose
sudo apt-get install docker-compose -y
sudo apt-get update

# Clean up
sudo rm -rf /var/lib/apt/lists/*