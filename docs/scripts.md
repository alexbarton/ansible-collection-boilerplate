# Ansible Boilerplate Collection Scripts

The Ansible Boilerplate Collection contains some scripts which are stored in the
`bin/` directory, in the project itself as well as in projects using the
Boilerplate Collection.

## "ansible-boilerplate" Script

Management script for the Ansible Boilerplate Collection itself and Ansible
helper functions.

Run `./bin/ansible-boilerplate --help` to see all available subcommands.

Used to initialize new projects as well as upgrading (activating) dependent
projects using this collection.

## "a" Wrapper Script for "ansible" Command

Wrapper for the `ansible` command.

## "ap" and "aps" Wrapper Scripts for "ansible-playbook" Command

The `ap` script is a wrapper for the `ansible-playbook` command. The `aps`
script uses the `ap` command and runs it with the "site play".
