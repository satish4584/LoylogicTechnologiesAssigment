#!/bin/sh
sudo yum -y update
sudo yum -y install java-1.8.0
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >>~/.bashrc
sudo echo "export PATH=$JAVA_HOME/bin:$PATH" >>~/.bashrc
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo yum install python python-devel python-pip -y
sudo yum install -y boto