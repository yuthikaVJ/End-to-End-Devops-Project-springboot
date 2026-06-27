#!/bin/bash

set -e

echo "========================================="
echo "Updating Ubuntu"
echo "========================================="

sudo apt update
sudo apt upgrade -y

echo "========================================="
echo "Installing Java 21"
echo "========================================="

sudo apt install -y openjdk-21-jdk

java -version

echo "========================================="
echo "Installing Maven"
echo "========================================="

sudo apt install -y maven

mvn -version


echo "========================================="
echo "Installing Java 21"
echo "========================================="

sudo apt install -y openjdk-21-jdk
java -version

echo "========================================="
echo "Installing Maven"
echo "========================================="

sudo apt install -y maven
mvn -version

echo "========================================="
echo "Installing Docker (if not installed)"
echo "========================================="

if ! command -v docker >/dev/null 2>&1; then
    curl -fsSL https://get.docker.com | sudo sh
    sudo systemctl enable docker
    sudo systemctl start docker
fi

docker --version

echo "========================================="
echo "Installing Jenkins (FIXED GPG SETUP)"
echo "========================================="

# Remove old configs
sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /usr/share/keyrings/jenkins.gpg

# Create keyrings folder
sudo mkdir -p /etc/apt/keyrings

# Add correct Jenkins GPG key (FIX)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/jenkins.gpg

# Add Jenkins repo (correct format)
echo "deb [signed-by=/etc/apt/keyrings/jenkins.gpg] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install -y jenkins

echo "========================================="
echo "Starting Jenkins"
echo "========================================="

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "========================================="
echo "Adding Jenkins to Docker Group"
echo "========================================="

sudo usermod -aG docker jenkins || true

sudo systemctl restart docker || true
sudo systemctl restart jenkins

echo "========================================="
echo "Versions"
echo "========================================="

java -version
echo "----------------"

mvn -version || echo "Maven not found"
echo "----------------"

docker --version
echo "----------------"

docker compose version || echo "Docker Compose not found"
echo "----------------"

git --version

echo "========================================="
echo "Jenkins Status"
echo "========================================="

sudo systemctl status jenkins --no-pager

echo "========================================="
echo "Initial Jenkins Password"
echo "========================================="

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "========================================="
echo "Installation Completed"
echo "========================================="
echo ""
echo "Jenkins URL:"
echo "http://${SERVER_IP}:8080"