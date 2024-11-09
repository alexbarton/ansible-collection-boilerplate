# Ansible Boilerplate Collection - alexbarton.boilerplate

This Ansible collection provides template files, including plays, roles,
scripts and makefiles, on which new Ansible projects can be built.

It is designed to make it easier to start a new Ansible project and to keep it
up to date.

Various template files are provided during the initial setup, but you don't
have to use them if you don't want to and/or can adjust them to your
preferences: For example, a "Makefile system" is provided, but you can use this
collection without it (and even remove the `Makefile` template from your
project).

## Installation

### Prerequisites

To install this Ansible collection, you need the `ansible-galaxy` command. If
it is not provided by your operating system installation by default, best is
to create a new Python "virtual environment" inside of your project directory
and install Ansible into it, like this:

```bash
mkdir -p ~/src/my-ansible-project
cd ~/src/my-ansible-project
python3 -m venv .venv
./.venv/bin/pip install -U pip setuptools
./.venv/bin/pip install ansible
```

#### Location of the Ansible Boilerplate Collection codebase

By default, the commands here in this `README.md` file as well as the scripts
of the Ansible Boilerplate Collection assume that the code of this collection
can be found on the *Ansible Galaxy* repository with the name
"alexbarton.boilerplate".

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

(Make sure you created the Python virtual environment first! If not, you need
to adjust the path to your `ansible-galaxy` command accordingly!)

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
out the project or running `make distclean`; you should not check in external
dependencies into your code repository!

It is a good idea to commit this initial state of your new project to your
code repository (an appropriate `.gitignore` template file was created as
well). For Git, something like this:

```bash
git init
git add .
git status --no-column
git commit -m "Initial commit"
```

## Updating and Upgrading an Existing Project

In an existing and already initialized project the `ansible-boilerplate`
command is available in the `./bin/` directory. You can use it to
"re-initialize" the project "from scratch" (e.g. after checking it out) and to
update ("activate") it like this:

```bash
./bin/ansible-boilerplate update
```

Or, when you use a Python virtual environment and stick to using the Makefile
system provided by this project, you can just use the `make` command itself:

```bash
make all   # Or any other make target.
```

## Upgrade vs. Update

Updating an existing project, either with `./bin/ansible-boilerplate update` or
by calling any `make` target means to fulfill all Python dependencies in
`requirements.txt` and all Ansible Galaxy dependencies in `requirements.yml` by
trying to install the latest/newest compatible versions. Ansible Boilerplate
scripts are updated (overwritten) with their current versions; configuration is
left unchanged.

The `./bin/ansible-boilerplate upgrade` or `make upgrade` command do the same
and *additionally* install new, missing and updated Ansible Boilerplate
configuration files. Existing configuration files are not overwritten, new
versions are installed with the ".new" file extension.
