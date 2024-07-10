# Ansible "Best Practices"

## Task Tags

Before introducing new tags, check which ones are already available and try to
reuse those whenever possible!

```shell
./bin/aps --list-tags | grep -i 'task tags' | cut -d'[' -f2 | sed -e 's/, /\n/g' -e 's/]//' | sort -u
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
     ansible.builtin.meta: flush_handlers
   ```
