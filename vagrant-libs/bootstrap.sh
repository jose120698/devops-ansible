#!/usr/bin/env bash

echo '### Install Ansible if not already existing ###'
yum -y install ansible

echo '### Update Python pip to the latest ###'
pip install -U pip

echo '### Install python virtualenv ###'
pip install virtualenv

echo '### Install Vim ###'
yum -y install vim

# echo '### Generate initial keys for Ansible and deploy locally ###'
# cd /vagrant; ansible-playbook playbooks/generate_keys.yml

# echo '### Run Ansible ###'
# cd /vagrant && ansible-playbook site.yml -e "env=vagrant"
