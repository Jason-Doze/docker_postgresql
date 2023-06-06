#!/bin/bash

# This script installs packages and components to set up Docker on Raspberry Pi server.

sudo apt update

# Install Docker packages to use repo over HTTPS
dpkg -s ca-certificates curl gnupg > /dev/null 2>&1 || sudo apt install -y ca-certificates curl gnupg

# Check if Docker GPG key is present
if [ -f /etc/apt/keyrings/docker.gpg ]
then
  echo -e "\n\033[1;32m==== Docker GPG key present ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Adding Docker GPG key ====\033[0m\n"
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Install Docker repo
if [ -f /etc/apt/sources.list.d/docker.list ]
then
  echo -e "\n\033[1;32m==== Docker repository present ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Install Docker repository ====\033[0m\n"
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
fi

# Install Docker Engine, containerd, and Docker Compose
if ( which docker > /dev/null )
then
  echo -e "\n\033[1;32m==== Docker installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Docker ====\033[0m\n"
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi


