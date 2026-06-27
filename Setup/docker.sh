
#!/bin/bash

set -e

echo "========================================="
echo "Updating Ubuntu"
echo "========================================="

sudo apt update
sudo apt upgrade -y

echo "========================================="
echo "Installing Docker"
echo "========================================="

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt update

sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin


echo "========================================="
echo "Docker Versions"
echo "========================================="


docker --version
docker compose version


echo "======== Docker User Group ======"

sudo usermod -aG docker $USER


sudo systemctl enable docker
sudo systemctl start docker




