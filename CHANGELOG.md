# Ansible Boilerplate Collection - alexbarton.boilerplate - ChangeLog

This document lists noteworthy changes from release to release which are
relevant for users of this collection. Please see the full Git history for all
details, fixes and internal changes.

- All commits on GitHub:
  <https://github.com/alexbarton/ansible-collection-boilerplate/commits/main/>
- Releases on GitHub:
  <https://github.com/alexbarton/ansible-collection-boilerplate/releases>

## Release 1.6.1 (2025-02-06)

- Bugfix release: Bring the documentation in line with the changes in 1.6.0.

## Release 1.6.0 (2025-02-06)

- `./bin/ansible-boilerplate upgrade` is now an alias for `update` (and `up`),
  no longer for `init`, and therefore no longer recreates some template files
  when they no longer exist.
- You can set (and therefore override) the `ANSIBLE_GALAXY` variable specifying
  the `ansible-galaxy` command to use ever since, but it was always reset to
  the version in a Python virtual environment when one was detected. Now, it is
  only reset to the version in a virtual environment when the `ANSIBLE_GALAXY`
  variable was *not* explicitly set in the environment.

## Release 1.5.0 (2024-12-29)

- Restructure and enhance the `ansible-best-practices.md` document: Add a new
  "Naming Conventions" section, explain use of tags on `flush_handlers` when
  installing packages and add recommendation to use `ansible.builtin.package`.
- Add new "new" extension. For now, it can create templates for new roles.
- Add new "docs" extension, a wrapper for `ansible-doc`.
- `Makefile.boilerplate`: Add new "cleanup" target
- `ansible.cfg`: Enable `force_handlers`, which is a saner default
- Further enhance the `README.md` file

## Release 1.4.0 (2024-10-25)

- Add new "get-facts" playbook.
- "list" plugin: Add "plays" subcommand to list all available playbooks.
- playbooks/ping: Do not stop on errors and do not collect "facts".

## Release 1.3.2 (2024-10-04)

- Bugfix release.

## Release 1.3.1 (2024-10-04)

- Bugfix release.

## Release 1.3.0 (2024-10-04)

- Check for a valid project directory for most subcommands.
- Show help for plugin commands.
- Look for plugins in more places:
    1. Plugins in the local project:
        `./libexec`
    2. Local system-wide plugins:
        `/usr/local/libexec/ansible-boilerplate/` and
        `/usr/local/lib/ansible-boilerplate/`
    3. Plugins from the local "boilerplate" Ansible Galaxy collection:
        `./ansible_galaxy/ansible_collections/alexbarton/boilerplate/libexec`
    4. System-wide plugins:
        `/usr/libexec/ansible-boilerplate/`

## Release 1.2.0 (2024-08-22)

- Add support for extensions in the `ansible-boilerplate` script, and implement
  the first extension, `list`, to list all defined hosts and used tags.
- Add `docs/ansible-best-practices.md`.
- Require Ansible >=2.16.
- Implement `./bin/ap --list` subcommand listing all playbooks.

## Release 1.1.2 (2024-05-29)

- Bugfix release.

## Release 1.1.1 (2024-05-29)

- Run `mdl` on `make check` when it is available.
- Add `docs/how-to-release.md`.
- Bugfix release.

## Release 1.1.0 (2024-05-29)

- Document the usage of "ansible-vault" in `docs/ansible-vault.md`.
- Run `shellcheck` on `make check` when it is available.
- Show diff's for files with newer templates after running an upgrade.
- Fix and enhance `./bin/ansible-boilerplate` in various ways; "upgrade" is now
  equivalent to (and an alias of) "init".

## Release 1.0.1 (2023-12-08)

- `ansible.cfg`: `collections_paths` is deprecated, use singular.
- Update `ansible.cfg` to current standards.

## Release 1.0.0 (2023-10-10)

- Initial release.
