# Ansible Boilerplate Collection - alexbarton.boilerplate

This Ansible collection provides template files, including plays, roles,
scripts and makefiles, on top of which new Ansible projects can be built.

It is designed to make it easier to start a new Ansible project and to keep it
up to date.

Various template files are provided during the initial setup, but you don't
have to use them if you don't want to and/or can adjust them to your individual
preferences: For example, a "Makefile system" is provided, but you can use this
collection without it (and even remove the `Makefile` template from your
project).

More information can be found online here:

- [GitHub](https://github.com/alexbarton/ansible-collection-boilerplate)
- [Ansible Galaxy](https://galaxy.ansible.com/ui/repo/published/alexbarton/boilerplate/)

## Features and Goals

- Provide a solid and extensible base for your own Ansible project, in which
  you can develop and deploy your own playbooks and roles, as well as include
  other collections and roles from the Ansible Galaxy and other sources.

- Make it easy to create and maintain a Python "virtual environment" providing
  Ansible itself and all the required tools. Support both the Python "venv"
  module with traditional `pip`, as well as the more modern and faster [Astral
  `uv` tool](https://docs.astral.sh/uv/).

- Provide Makefile's and handy `make` targets for working with your project.
  But this is purely optional, you can use this collection without `make`
  perfectly fine using the included `abc` script directly.

## Installation

### Prerequisites

This Boilerplate Collection can _either_ be installed with the `ansible-galaxy`
command (which in turn requires Ansible to be available already) _or_ via the
`abc` script (which is included in this collection and can be downloaded
separately, see below).

The preferred way is to use the `abc` tool and have Ansible and its tools
installed into a project-local Python "virtual environment" using the [Astral
`uv` tool](https://docs.astral.sh/uv/).

#### Location of the Ansible Boilerplate Collection codebase

By default, the commands here in this `README.md` file as well as the scripts
of the Ansible Boilerplate Collection assume that the code of this collection
can be found on the _Ansible Galaxy_ repository with the name
"alexbarton.boilerplate".

If you want to override this, you can set the `BOILERPLATE_COLLECTION_SRC`
environment variable to:

- a file name (including path) to a local archive file (e.g.
  `/tmp/ansible/alexbarton-boilerplate-0.0.1.tar.gz`)
- a path name to a local Git repository (e.g.
  `/usr/local/src/ansible-collection-boilerplate.git`)
- a URL to a remote Git repository (e.g.
  `git+https://my.git.server/ansible-collection-boilerplate.git`)
- the name of a collection stored on the Ansible Galaxy (e.g.
  `alexbarton.boilerplate`)

Example:

```bash
export BOILERPLATE_COLLECTION_SRC=/tmp/ansible/alexbarton-boilerplate-2.0.0.tar.gz
```

## Initializing a New Project

The following command will download the latest version of the `abc` stub helper
script, run it to install the current Ansible Boilerplate Collection from the
Ansible Galaxy repository with its default name of "alexbarton.boilerplate" (or
from the location given in the `BOILERPLATE_COLLECTION_SRC` environment
variable, see above) and initialize a new Ansible Boilerplate Collection based
project with it:

```bash
curl -s https://raw.githubusercontent.com/alexbarton/ansible-collection-boilerplate/refs/heads/main/bin/abc | bash -s -- init
```

This initializes an Ansible-based project with some template files, links some
scripts into the local `./bin/` directory (which is created as needed) and
copies the `abc` command into the `./bin/` directory, too, to make it available
even when the "alexbarton.boilerplate" Ansible Collection is not yet installed
on the local machine: for example, after freshly checking out the project or
running `make distclean`; you should not check in external dependencies into
your code repository!

It is a good idea to commit this initial state of your new project to your code
repository (an appropriate `.gitignore` template file was created as well). For
Git, something like this:

```bash
git init
git add .
git status --no-column
git commit -m "Initial commit"
```

## Initialising ("Installing") an Existing Project

When checking out an existing project, all of its Python (if any) and Ansible
dependencies need to be installed, too, including this Ansible Boilerplate
Collection itself. This can be handled with the `abc` stub helper script (which
should be included in the project) like this:

```bash
./bin/abc install
```

### Initialising ("Installing") an Existing Project Using `make`

When having a Python virtual environment and using the Makefile system provided
by this project, you can just use the `make` command itself -- in this case,
you do not even need to specify a "make target":

```bash
make
```

## Updating an Existing Project

In an existing project the `abc` command is available in the `./bin/`
directory. You can use it to install (and update) the Ansible Galaxy
dependencies of your project to their latest versions "from scratch" (e.g.
after freshly checking out your project) and while working on it like this:

```bash
./bin/abc update
```

### Updating a Project Using `make`

Rhe make target is called "update":

```bash
make update
```
