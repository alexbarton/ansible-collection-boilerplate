# Upgrading from Ansible Boilerplate Collection Version 1

The most prominent change is the renaming of the helper tool from the old
`bin/ansible-boilerplate` to the new `bin/abc` name.

Most probably your local setup was not pinned to version 1 and automatically
updated to version 2, and now you see an error message like this:

```text
Copying "boilerplate" script into bin/ directory ...
cp: ansible_galaxy/ansible_collections/alexbarton/boilerplate/bin/ansible-boilerplate:
  No such file or directory
```

... or this:

```text
ansible_galaxy/ansible_collections/alexbarton/boilerplate/Makefile.boilerplate:
  No such file or directory
make: *** No rule to make target
  `ansible_galaxy/ansible_collections/alexbarton/boilerplate/Makefile.boilerplate'.
  Stop.
```

... or this:

```text
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

When you have merged all changes, you can remove the `*.new` files (and the
`*.old` backup files), for example with `make cleanup`.

## Makefiles

If you use the Makefile system, make sure to update how the `Makefile` of the
Ansible Boilerplate Collection is included.

You can check the required configuration with the following command:

```bash
bin/abc generate makefile
```
