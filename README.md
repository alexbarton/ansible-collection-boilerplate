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

*Note:* This is *version 2* of the Ansible Boilerplate Collection. Please see
below for upgrade information!

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

### Alternate approach using system-wide installed `ansible-galaxy` command

When Ansible, including `ansible-galaxy`, and a appropriate Python version is
already installed on the local system, for example using the package manager of
the operating system distribution, the Ansible Boilerplate Collection can be
installed like this:

```bash
ansible-galaxy collection install -p ansible_galaxy ${BOILERPLATE_COLLECTION_SRC:-alexbarton.boilerplate}
./ansible_galaxy/ansible_collections/alexbarton/boilerplate/bin/abc init
```

*Note:* This approach does not initialize a Python project, does not use a
Python "virtual environment" and depends on all Ansible and Python dependencies
already being installed system-wide! It is *not* the recommended way and should
only be used when using a proper Python "virtual environment" is not an option!

### Which installation method and tools are used when

1. When an activated Python "virtual environment" is found, it is used.
2. When a `.venv` folder is found, a "virtual environment" will be initialized
   (when not already initialized) and used.
3. When the `ansible-galaxy` command is found in the `$PATH`, *no* virtual
   environment will be used but an existing Ansible installation is assumed on
   the system and will be used.
4. If none of the above rules matched, a "virtual environment" will be
   initialized (when not initialized already) and used.

When a Python "virtual environment" is used, the [Astral `uv`
tool](https://docs.astral.sh/uv/) will be used when available. The Python
"venv" module with traditional `pip` is used if it was not found.

## Initializing ("Installing") an Existing Project

When checking out an existing project, all of its Python (if any) and Ansible
dependencies need to be installed, too, including this Ansible Boilerplate
Collection itself. This can be handled with the `abc` stub helper script (which
should be included in the project) like this:

```bash
./bin/abc install
```

### Initializing ("Installing") an Existing Project Using `make`

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

The make target is called "update":

```bash
make update
```

## Upgrading from Ansible Boilerplate Collection version 1

The most prominent change is the renaming of the helper tool from the old
`bin/ansible-boilerplate` to the new `bin/abc` name.

Most probably your local setup was not pinned to version 1 and automatically
updated to version 2, and now you see an error message like this:

```bash
Copying "boilerplate" script into bin/ directory ...
cp: ansible_galaxy/ansible_collections/alexbarton/boilerplate/bin/ansible-boilerplate:
  No such file or directory
```

... or this:

```bash
ansible_galaxy/ansible_collections/alexbarton/boilerplate/Makefile.boilerplate:
  No such file or directory
make: *** No rule to make target
  `ansible_galaxy/ansible_collections/alexbarton/boilerplate/Makefile.boilerplate'.
  Stop.
```

... or this:

```bash
/bin/sh: /my/project_basedir/bin/abc: No such file or directory
```

*Don't worry!*

Either use your version control system to revert to the last known good commit
and pin the dependency on the Ansible Boilerplate Collection in the
`requirements.yml` file to version 1 (note the ",v1" at the end of the URL):

```yml
collections:
  - git@github.com:alexbarton/ansible-collection-boilerplate.git,v1
```

Or (even better?) *upgrade* your project to the current version 2 of the
Ansible Boilerplate Collection by running the new `abc` command directly from
its source in the `ansible_galaxy/` folder once to (re-) install the project:

```bash
./ansible_galaxy/ansible_collections/alexbarton/boilerplate/bin/abc install
```

Next, check all the new versions of template files and compare them with the
existing variants in your project, and incorporate relevant changes into the
configuration files used in your project:

```bash
find . -name '*.new'
```

You can show the differences of all of them with this command, for example:

```bash
for new_file in $(find . -name '*.new'); do \
    diff -u ${new_file%%.new} ${new_file} | LESS= less; \
done
```

### Makefile's

If you use the Makefile system, make sure to update how the `Makefile` of the
Ansible Boilerplate Collection is included.

You can check the required configuration with the following command:

```bash
bin/abc generate makefile
```
