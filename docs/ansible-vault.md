# Ansible Boilerplate Collection and Ansible vault

This Boilerplate Collection is meant to cope well with Ansible vault.

The following files are treated specially for ansible-vault(1) usage:

- `.ansible-vault-secret`: You can use this as a "local vault password file".
  It should _not_ be added to the Git repository and is listed in the
  `.gitignore` template file by default.

- `group_vars/all/ansible_vault.yml`: Use this file to store encrypted Ansible
  variables which are handled by ansible-vault(1). It is automatically added to
  some commands invoked by the Ansible Boilerplate scripts, wrappers, and
  Makefile's.
