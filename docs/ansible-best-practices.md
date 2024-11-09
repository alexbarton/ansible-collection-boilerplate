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

   Example:

   ```yaml
   - name: Flush all handlers
     tags:
       - always
     ansible.builtin.meta: flush_handlers
   ```

2. Use the generic `ansible.builtin.package` module, only use the package
   manager specific modules like `ansible.builtin.apt` or `ansible.builtin.dnf`
   when you make use of their specific options! This helps making your role or
   task more independent of the operating system used.
