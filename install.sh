#!/bin/bash
# cap nhap he dieu hanh len moi nhat
apt-get -y update || yum -y update
apt-get -y upgrade || yum -y upgrade

# cai dat thanh phan can thiet
apt install -y git nano || yum install git nano

# cai dat docker

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# cai docker-composer ban moi nhat 
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
DESTINATION=/usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod 755 $DESTINATION

git clone https://github.com/vncloudsco/confluence-jira.git
cd confluence-jira
docker-compose -f docker-compose-build.yaml build
docker-compose -f docker-compose-build.yaml up -d