# docker_gitlab
This role serves to spin up and manage Gitlab Docker containers.

## How To Use
1. Add your Gitlab configurations to Ansible inventory, use `playbooks/roles/docker_gitlab/defaults/main.yml` as a reference.
2. Add your host to the `[docker_gitlab]` host group in Ansible inventory
3. Execute Ansible.
