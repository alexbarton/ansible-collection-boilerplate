# Ansible Boilerplate Collection Scripts

The Ansible Boilerplate Collection contains some scripts which are installed
(copied) or linked (from the collection directory) into the `bin/` directory of
the dependent project.

## Main "abc" Script

The `abc` script is the main management script for the Ansible Boilerplate
Collection ("ABC", therefore the name).

It provides management capabilities for projects using Ansible, including:

- Initializing and managing projects
- Activating and upgrading existing projects
- Working with the local Ansible setup (listing playbooks, roles, and tasks)
- Generating boilerplate code for new roles and other components

Run `./bin/abc --help` to see all available subcommands and their descriptions.

Usage: `./bin/abc [--debug] <subcommand> [<arguments> [...]]`

### Subcommands

- `init`: Initialize a new project in the current directory (see `README.md`).
- `install` (aliases: `activate`, `i`): Install all dependencies of the
  project: the Python "virtual environment" (if used), and the Ansible
  collections and roles listed in `requirements.yml`. The script links the
  wrapper scripts into `./bin/` and updates the `./bin/abc` script itself, too.
- `update [--force]` (aliases: `upgrade`, `up`): Update all dependencies to
  their latest versions, update the `./bin/abc` script and the links of the
  wrapper scripts, and update the template files which exist in the project
  (see below). `--force` is passed on to `ansible-galaxy collection install`.
- `docs <topic>`: Show the documentation of an Ansible module or plugin using
  `ansible-doc`, for example `./bin/abc docs ansible.builtin.copy`.
- `generate [--force|-f] makefile`: Create the top-level `Makefile` of the
  project, which includes the Makefile of the collection.
- `generate [--force|-f] readme <role>`: Create a `README.md` file for a role,
  including a list of the variables found in its `defaults/` directory.
- `list groups [<pattern>]`, `list hosts [<pattern>]`: List the groups or the
  hosts of the inventory, optionally limited by a host pattern. This requires
  the `jq` command.
- `list plays`: List all available playbooks (see `ap --list` below).
- `list tags`: List all tags used in the playbooks.
- `new role <name>`: Create a new role in the `roles/` directory (or the
  current directory, if there is none). The environment variables `NAME` and
  `EMAIL` set the author information, `LOGNAME` is used as a fallback.
- `reset`: Remove all installed dependencies: the Python "virtual
  environment", the installed collections and roles, and the links of the
  wrapper scripts. Run `./bin/abc install` to install them again.
- `help`: Show the usage information, including all available plugins.

Pass `--help` to individual subcommands to see their help.

When updating the template files of the collection (`.ansible-lint`,
`.editorconfig`, `.gitignore`, `.vscode/settings.json`, `.yamllint.yml` and
`ansible.cfg`), only files which already exist in the project are taken into
account. When a file differs from the new version, the new version is installed
next to it with a `.new` suffix, and you have to merge the changes yourself.
`make cleanup` removes all these files afterwards.

### Environment Variables

- `ABC_BASE_D`: Directory of the installed Ansible Boilerplate Collection
  (default: `ansible_galaxy/ansible_collections/alexbarton/boilerplate`).
- `ABC_PYTHON_MIN`: Minimum Python version for new Python "virtual
  environments" (default: `3.12`).
- `ANSIBLE_GALAXY`, `PYTHON`, `UV`: The `ansible-galaxy`, `python3` and `uv`
  commands to use (default: the ones found in the `$PATH`).
- `BOILERPLATE_COLLECTION_SRC`: Location of the Ansible Boilerplate Collection
  for `init` (see `README.md`).
- `DEBUG`: Show the environment of the script before running a subcommand, like
  the `--debug` option does.

### Plugins

All subcommands but `init`, `install`, `update` and `help` are implemented as
_plugins_: executable files named `abc-<subcommand>`. You can add your own
subcommands to your project by creating such scripts in its `./libexec/`
directory. A line like `# description=Short description` in the script is
shown in the help text.

Plugins are searched in the following directories, and the first plugin found
is used. So plugins in the project can override plugins of the collection:

1. `./libexec/` (the project directory)
2. `/usr/local/libexec/ansible-boilerplate/`
3. `/usr/local/lib/ansible-boilerplate/`
4. `${ABC_BASE_D}/libexec/` (the Ansible Boilerplate Collection)
5. `/usr/libexec/ansible-boilerplate/`

The `abc` script is copied into the `./bin/` folder when a new project is
initialized (all other scripts are symlinked), because it is used to bootstrap
the project and the Ansible environment -- including the rest of the Ansible
Boilerplate Collection itself.

## "a" Wrapper Script for the "ansible" Command

The `a` script is a wrapper for the `ansible` command.

It ensures that the current working directory is the project root directory and
that a Python "virtual environment" is activated (if available).

Usage: `./bin/a <ansible_arguments> [...]`

This will call: `ansible <ansible_arguments> [...]`

## "ap" Wrapper Script for the "ansible-playbook" Command

The `ap` script is a wrapper for the `ansible-playbook` command.

Usage: `./bin/ap <playbook> [<ansible-playbook_arguments> [...]]`

It will change the current working directory to the project directory and enable
a Python "virtual environment" (if available). The script then calls the
`ansible-playbook` command like this:

```shell
ansible-playbook ./path/to/<playbook>.yml [<ansible-playbook_arguments> [...]]
```

The `<playbook>` is looked for in "well known" locations with the `.yml`
extension:

- `./` (the project root directory)
- `./playbooks/`
- `./playbooks/ad-hoc/`
- `./playbooks/deploy/`
- `./playbooks/site/`
- Playbooks in installed Ansible Collections (`playbooks/` folder)

The file extension `.yml` itself must be left out in this "auto mode", for
example like this: `./bin/ap get_facts`.

If no playbook was found that way, `<playbook>` is used verbatim and must
contain the full file name, including (relative) *path* and *file extension*!
In this case, the `ansible-playbook` command is called like this:

```shell
ansible-playbook <playbook> [<ansible-playbook_arguments> [...]]
```

When `--list` is passed to `ap`, it lists all playbooks it can find in the
locations mentioned above with their short names without extension. The
`./bin/abc list plays` command is a "nicer" wrapper for `ap --list`.

### "aps" Wrapper Script for the "site" Playbook

The `aps` script is a wrapper script for the `ap` command (see above) and calls
it with the "site" Playbook ("site play", `site.yml`).

Usage: `./bin/aps [<ansible-playbook_arguments> [...]]`

This effectively calls `./bin/ap site [<ansible-playbook_arguments> [...]]`
