# docker_sonarqube
This role serves to spin up and manage SonarQube Docker containers. This includes the postgres db.

## How To Use
1. Add your SonarQube configurations to Ansible inventory, use `playbooks/roles/docker_sonarqube/defaults/main.yml` as a reference.
2. Add your host to the `[docker_sonarqube]` host group in Ansible inventory
3. Execute Ansible.
