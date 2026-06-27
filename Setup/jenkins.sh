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
echo "Installing Jenkins"
echo "========================================="

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

sudo apt install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "========================================="
echo "Adding Jenkins to Docker Group"
echo "========================================="

sudo usermod -aG docker jenkins

sudo systemctl restart docker
sudo systemctl restart jenkins


echo "========================================="
echo "Versions"
echo "========================================="

java -version

echo "----------------"

mvn -version

echo "----------------"

docker --version

echo "----------------"

docker compose version

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

echo ""
echo "========================================="
echo "Installation Completed"
echo "========================================="
echo ""
echo "Jenkins URL:"
echo "http://YOUR_SERVER_IP:8080"
echo ""