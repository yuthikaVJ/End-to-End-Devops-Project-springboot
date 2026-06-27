#!/bin/bash

set -e

echo "========================================="
echo "Updating Ubuntu"
echo "========================================="

sudo apt update
sudo apt upgrade -y

echo "========================================="
echo "Installing Java & Maven"
echo "========================================="

sudo apt install openjdk-21-jdk -y

sudo apt install maven -y

sudo java -version
sudo mvn -version

echo "========================================="
echo "Installing Jenkins"
echo "========================================="

sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null


sudo apt update


sudo apt install jenkins -y

sudo systemctl start jenkins.service

sudo systemctl status jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "========================================="
echo "Installation Completed"
echo "========================================="
echo ""
echo "Jenkins URL:"
echo "http://${SERVER_IP}:8080"