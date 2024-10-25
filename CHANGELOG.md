# Ansible Boilerplate Collection - alexbarton.boilerplate - ChangeLog

This document lists noteworthy changes from release to release which are
relevant for users of this collection. Please see the full Git history for all
details, fixes and internal changes.

- All commits on GitHub:
  <https://github.com/alexbarton/ansible-collection-boilerplate/commits/main/>
- Releases on GitHub:
  <https://github.com/alexbarton/ansible-collection-boilerplate/releases>

## Release *TBD*

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

- ansible.cfg: "collections_paths" is deprecated, use singular.
- Update ansible.cfg to current standards.

## Release 1.0.0 (2023-10-10)

- Initial release.
