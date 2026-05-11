# Ansible Boilerplate Collection Scripts

The Ansible Boilerplate Collection contains some scripts which are installed
(copied) or linked (from the collection directory) into the `bin/` directory of
the dependant project.

## Main "abc" Script

The `abc` script is the main management script for the Ansible Boilerplate
Collection ("ABC", therefore the name).

It provides management capabilities for projects using Ansible, including:

- Initializing and managing projects
- Activating and upgrading existing projects
- Working with the local Ansible setup (listing playbooks, roles, and tasks)
- Generating boilerplate code for new roles and other components

Run `./bin/abc --help` to see all available subcommands and their descriptions.

The `abc` script is copied into the `./bin/` folder when a new project is
initialized (all other scripts are symlinked), because it is used to bootstrap
the project and the Ansible environment -- including the rest of the Ansible
Boilerplate Collection itself.

## "a" Wrapper Script for the "ansible" Command

The `a` script is a wrapper for the `ansible` command.

It ensures that the current working directory is the project directory and
that a Python "virtual environment" is activated (if available).

Usage: `./bin/a <ansible_arguments> [...]`

This will call: `ansible <ansible_arguments> [...]`

## "ap" Wrapper Scripts for the "ansible-playbook" Command

The `ap` script is a wrapper for the `ansible-playbook` command.

Usage: `./bin/ap <playbook> [<ansible-playbook_arguments> [...]]`

It will change the current working directly to the project directly and enable
a Python "virtual environment" (if available). The script then calls the
`ansible-playbook` command like this:

```shell
# - Working directory is changed to the project directory.
# - Python virtual environment is # activated.
# - <playbook> and (optional) <ansible-playbook_arguments> have been passed
#   to the "ap" command.
ansible-playbook ./path/to/<playbook>.yml [<ansible-playbook_arguments> [...]]
```

The `<playbook>` is looked for in "well known" locations:

- `./playbooks/`
- `./playbooks/deploy/`
- `./playbooks/site/`
- Playbooks in installed Ansible Collections (`playbook/` folder)

In these cases, the file extension `.yml` must be left out, for example like
this: `./bim/ap get_facts`.

If no playbook was found that way, `<playbook>` is used verbatim and must
contain the full file name, including (relative) path and file extension!

When `--list` is passwd to `ap`, it lists all playbooks it can find in the
locations mentioned above and their "sort" names without extensions. This
results the same output you can get with `./bin/abc list plays

### "aps" Wrapper Script for the "site" Playbook

The `aps` script in turn is a wrapper script for the `ap` command (see above)
and calls it with the "site" Playbook ("site play").

Usage: `./bin/aps [<ansible-playbook_arguments> [...]]`

This effectively calls `./bin/ap site [<ansible-playbook_arguments> [...]]`
