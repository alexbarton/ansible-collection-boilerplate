# Ansible Boilerplate Collection Makefiles

Using `make` is optional: everything can be done with the `abc` script directly
(see [scripts.md](scripts.md)). But when you like `make`, `abc init` creates a
`Makefile` in your project which includes the file `Makefile.boilerplate` of
the Ansible Boilerplate Collection. You can (re-) create it with the
`./bin/abc generate makefile` command.

## Make Targets

- `all` (the default target): Install the project, when its Python "virtual
  environment" is missing or outdated, by calling `./bin/abc install`.
- `venv`: Install the project (`./bin/abc install`) unconditionally.
- `update`: Update the project and all its dependencies (`./bin/abc update`).
- `check`: Run `ansible --version`, a syntax check of the "site" playbook (when
  `playbooks/site.yml` or `site.yml` exists), and `ansible-lint` (when
  available).
- `clean`: Remove the `.cache/` directory.
- `distclean`: Run `clean` and remove all installed dependencies
  (`./bin/abc reset`).
- `maintainer-clean`: The same as `distclean`.
- `cleanup`: Remove all `*.new*` and `*.old*` files, for example after updating
  the project and merging all new template files. It asks before removing each
  file.

You can add your own targets to the `Makefile` of your project, and extend the
targets above: for example, add more checks with `check: my-check`.

## Python Virtual Environment

The Makefile uses an activated Python "virtual environment", when there is one,
and the `.venv/` directory of the project otherwise.
