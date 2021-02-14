#!/bin/sh
sudo yum -y update
sudo yum -y install java-1.8.0
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >>~/.bashrc
sudo echo "export PATH=$JAVA_HOME/bin:$PATH" >>~/.bashrc
sudo yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo chkconfig --add jenkins
sudo wget wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y epel-release-latest-7.noarch.rpm
sudo yum install python python-devel python-pip openssl ansible -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker