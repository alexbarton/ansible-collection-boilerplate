# Ansible Boilerplate Collection - alexbarton.boilerplate

This Ansible collection provides boilerplate files, plays, roles, scripts etc.
on which new projects that will use Ansible can be based on.

## Installation

### Prerequisites

To install this Ansible collection, you need the `ansible-galaxy` command. If
it is not provided by your operating system installation by default, best is
to create a new Python "virtual environment" inside of your project directory
and install Ansible into it, like this:

```bash
cd ~/src/my-ansible-project
python3 -m venv .venv
./.venv/bin/pip install -U pip setuptools
./.venv/bin/pip install ansible
```

#### Location of the Ansible Boilerplate Collection codebase

By default, the commands here in the README file as well as the scripts of the
Ansible Boilerplate Collection assume that the code of this collection can be
found on the Ansible Galaxy repository with the name "alexbarton.boilerplate".

If you want to override this, you can set the `BOILERPLATE_COLLECTION_SRC`
environment variable to:

* a file name (including path) to a local archive file (e. g.
  `/tmp/ansible/alexbarton-boilerplate-0.0.1.tar.gz`)
* a path name to a local Git repository (e. g.
  `/usr/local/src/ansible-collection-boilerplate.git`)
* a URL to a remote Git repository (e. g.
  `git+https://my.git.server/ansible-collection-boilerplate.git`)
* the name of a collection stored on the Ansible Galaxy (e. g.
  `alexbarton.boilerplate`)

Example:

```bash
export BOILERPLATE_COLLECTION_SRC=/tmp/ansible/alexbarton-boilerplate-0.0.1.tar.gz
```

### Installing the Ansible Boilerplate Collection

The following command will install the Ansible Boilerplate Collection from the
location given in the `BOILERPLATE_COLLECTION_SRC` environment variable (see
above) or from the Ansible Galaxy repository with its default name of
"alexbarton.boilerplate", when the environment variable is not set:

```bash
./.venv/bin/ansible-galaxy collection install -p ansible_galaxy \
  "${BOILERPLATE_COLLECTION_SRC:-alexbarton.boilerplate}"
```

## Initializing a New Project

Once the Ansible Boilerplate Collection is available in the local
`ansible_galaxy/ansible_collections` sub-directory, you can use the
`ansible-boilerplate` command to initialize a new project:

```bash
./ansible_galaxy/ansible_collections/alexbarton/boilerplate/bin/ansible-boilerplate init
```

This initializes an Ansible-based project with some template files, links some
scripts into the local `./bin/` directory (which is created as needed) and
copies the `ansible-boilerplate` command into the `./bin/` directory, too, to
make it available even when the "alexbarton.boilerplate" Ansible Collection is
not yet installed on the local machine (for example, after freshly checking
out the project or running `make distclean`).

It is a good idea to commit this initial state of your new project to your
code repository. For Git, something like this:

```bash
git init
git add .
git status --no-column
git commit -m "Initial commit"
```

## Initializing/Upgrading an Existing Project

In an existing and already initialized project the `ansible-boilerplate`
command is available in the `./bin/` directory. You can use it to initialize
the project "from scratch" and to upgrade it like this:

```bash
./bin/ansible-boilerplate upgrade
```

Or, when you use a Python virtual environment and stick to using the Makefile
system provided by this project, you can just use the `make` command itself:

```bash
make upgrade
```
