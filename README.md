# Ansible
This repository serves as our configuration management repository. In order to keep things in order and maintain consistency, there are some conventions which should be followed.

## Conventions
1. __Keep this repository client-agnostic.__ Do not include any environment or client-specific information in this repository. Store all of your environment and client-specific information in the appropriate inventory repository. This allows us to utilize this code-repository across multiple clients, projects and initiatives.
2. __Write your Ansible roles and playbooks to be idempotent.__ This means that when you run your Ansible multiple times in succession it will not perform any unnecessary actions repeatedly (0 changes).
3. __Always test your Ansible in Vagrant__ or a disposable environment before issuing a merge request, or merging your branch into master. This ensures that we are not "developing in production" and gives us stability and reliability across our production systems.
4. __Use feature branching when pushing.__ When you push to the Ansible source repository, push your changes to a feature branch, i.e. `gitlab` and then issue a merge request when you are ready to have your code merged. This allows at least 2 sets of eyes on everything that gets added to the Ansible code base.
5. __Always tag your role tasks with the name of the role.__ This allows fine-grained targeting of systems with specific roles and playbooks.
6. __Never target production systems__ from your local machine, Vagrant or any non-assigned Ansible control nodes or from the command line of a control node. This helps us to ensure that all actions taken against production systems are logged/audited properly; as we orchestrate the execution of Ansible from tools which retain the logs and activities of Ansible.
7. __Give each task a name__ so that the Ansible execution output is easier to read by humans.
8. __Never use `ignore_errors`__ unless you absolutely have to.
9. __Add padding to your variables.__ For example, `{{hard_to_read}}` and `{{ easier_to_read }}`.
10. __Use Pascal Case for boolean.__ Instead of `true` use `True`.

# Ansible Config Tree
 - `inventory-vagrant/`                -- Directory of static inventory files and variable files for `Vagrant`
 - `inventory-vagrant/group_vars/`     -- Group variables
 - `inventory-vagrant/inventory/`      -- Directory of static inventory files for `Vagrant`
 - `library`                           -- Custom `Ansible modules`
 - `playbooks/`                        -- Recipes for configuration and appropriate related actions
 - `playbooks/roles/`                  -- Roles and modules under them for which we act upon within Ansible
 - `vagrant-libs`                      -- Required files for `Vagrant` provisioning
 - `.gitignore`                        -- Git ignore file.
 - `ansible.cfg`                       -- Ansible program configuration variables.
                                       -- This file should not be modified under most circumstances.
 - `localhost`                         -- Inventory file for running local plays.
 - `README.md`                         -- This file.
 - `site.yml`                          -- Global cookbook for all recipes to be played automatically.
 - `Vagrantfile`                       -- Specification file for Vagrant.

# How-To

## Example (dev)
1. Execute `ansible-playbook site.yml -e "env=dev"` from the Ansible control node to run Ansible against `dev` environment

## Global Variables
 - `env`  -- Host environment to target
 - Check Ansible documentation for additional global variables

## Create New Roles and Playbooks
1. Create a new playbook in `playbooks` prefixed with `HostType-`, for example a Gitlab playbook would be named `HostType-gitlab.yml`
2. Structure your playbook content like the following example:
```
---
- name: Ansible HostType gitlab Play
  hosts: "{{ env }}:&gitlab"
  become: True
  roles:
    - gitlab
```
3. Include your new playbook at the end of `playbooks/main.yml`
   * `- include: HostType-gitlab.yml`
4. Duplicate the `playbooks/roles/role-skel` directory and follow the instructions in `playbooks/roles/role-skel/README.md` to create your role

# Vagrant

## Run Ansible inside Vagrant
1. Install Virtualbox (https://www.virtualbox.org/wiki/Downloads) and Vagrant (https://www.vagrantup.com/)
2. Inside the root of the repository, on your command line, type: `vagrant up` to bring up the Vagrant machine
3. After the Vagrant machine comes up, type: `vagrant ssh` to ssh into the Vagrant machine
4. Run the following command inside the Vagrant machine: `cd /vagrant; ansible-playbook site.yml -e "env=vagrant"` to execute Ansible. You can execute this command each time you want to test your changes. You may also run Ansible in "check mode" by adding the `--check` parameter to the end, like so: `cd /vagrant; ansible-playbook site.yml -e "env=vagrant" --check`
5. You can modify the `Vagrantfile` inside the repository to add any additional ports you need forwarded, after doing so you must re-provision your machine. Please see the Vagrant docs for further information

__Uncomment `vagrant` in the inventory file (inventory-vagrant/inventory/vagrant) under any product you'd like to install__

# Hepful Tips
- Add `-vvvv` to your Ansible execution to get extremely verbose output

# Notes
 - You can store your custom roles in `/etc/ansible/roles` and they will be automatically picked up
