# Ansible "Best Practices"

## Task Tags

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

## Installing Packages

1. Always flush all handlers first, earlier tasks could have changed the
   package manager (repository) configuration!

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
     ansible.builitin.apt:
       name: logrotate
       state: present
       install_recommends: false
   ```

2. Use the generic `ansible.builtin.package` module, only use the package
   manager specific modules like `ansible.builtin.apt` or `ansible.builtin.dnf`
   when you make use of their specific options! This helps making your role or
   task more independent of the operating system used.
