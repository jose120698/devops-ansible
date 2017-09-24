#!/usr/bin/env bash

echo '### Install Ansible if not already existing ###'
yum -y install ansible

echo '### Install python virtualenv ###'
pip install virtualenv

echo '### Install python docker-py ###'
pip install docker-py

# echo '### Generate initial keys for Ansible and deploy locally ###'
# cd /vagrant; ansible-playbook playbooks/generate_keys.yml

# echo '### Run Ansible ###'
# cd /vagrant && ansible-playbook site.yml -e "env=vagrant"
