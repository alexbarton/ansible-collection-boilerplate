# Ansible "Best Practices"

## Naming Conventions

Rule of thumb: Make sure things are consistent.

For example, it is common to use the short `.yml` extension for YAML files
(instead of `.yaml` which would work as well).

### Projects

Depending on the type of your project, the *Project name* is either purely
cosmetic and of "local" meaning only (e.g., when implementing an Ansible-based
deployment) or directly linked to the name of the entity (e.g., when developing
a stand-alone role or collection). If the latter, its name must follow the
naming conventions relevant for its type.

### Playbooks

*Playbooks* are stored in YAML files on the file file system. Their names must
consist of lowercase word characters only (i.e., the characters a-z and the
digits 0-9) and use *snake_case* style (i.e., using underscores as word
delimiters). The file extension is `.yml`.

It is a good idea to store individual playbooks (if there are any), optionally
including the "site playbook" `site.yml`, in a subdirectory named `playbooks`.

### Roles and Collections

*Role* and *Collection* are stored in directories on the file system
corresponding to their names. Their names must consist of lowercase word
characters only (i.e., the characters a-z and the digits 0-9) and use
*snake_case* style (i.e., using underscores as word delimiters). The first
character of a collection name must be a letter.

*Note:* This is the only format supported by the "Ansible Galaxy" repository
system and therefore highly recommended!

It is a good idea to store individual roles in an Ansible project (which
implements multiple roles) in a subdirectory named `roles`.

References:

- <https://stackoverflow.com/a/73393717/4493047>

### Tasks

Individual *Tasks* are stored in YAML files. Their name should start with a
*verb* and a *capital* first letter: Use an action verb to indicate what the
role does. For example: *"Install Apache"* or *"Configure firewall"*.

There is no need to end the short task description with a period.

Example:

```yaml
- name: This is an example task
  ansible.builtin.debug:
    msg: Hello World!
```

## Metadata

### Task Tags

Before introducing new tags, check which ones are already available and try to
reuse those whenever possible!

```shell
./bin/ansible-boilerplate list tags
```

Or, without any Ansible tools:

```shell
grep -r -A 5 -h tags roles/*/tasks \
 | grep -F -- '- ' | grep -Ev '(:|")' | cut -d'-' -f2 | sort -u
```

## Common Operations

### Installing Packages

1. Always flush all handlers before installing packages: earlier tasks could
   have changed the package manager (package repository) configuration and the
   package probably is only available ("known to the package manager") after
   refreshing its package database, for example.

   You don't have to (and probably shouldn't) use the "always" tag, but you
   have to include *all the tags* assigned to subsequent tasks that possibly
   depend on handlers to be run first!

   Example:

   ```yaml
   # Earlier tasks could have modified the package manager configuration!
   - name: Flush all handlers before installing packages
     tags:
       - packages
       - apt
     ansible.builtin.meta: flush_handlers

   - name: Install a example package
     tags:
       - apt
       - packages
     ansible.builtin.apt:
       name: logrotate
       state: present
       install_recommends: false
   ```

2. Use the generic `ansible.builtin.package` module, only use the package
   manager specific modules like `ansible.builtin.apt` or `ansible.builtin.dnf`
   when you make use of their specific options! This helps making your role or
   task more independent of the operating system used.
