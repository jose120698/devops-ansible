#!/usr/bin/env bash

echo '### Install Ansible if not already existing ###'
yum -y install ansible

echo '### Update Python pip to the latest ###'
pip install -U pip

echo '### Install python virtualenv ###'
pip install virtualenv

echo '### Install Vim ###'
yum -y install vim

# echo '### Run Ansible ###'
# cd /vagrant && ansible-playbook site.yml -e "env=vagrant"
