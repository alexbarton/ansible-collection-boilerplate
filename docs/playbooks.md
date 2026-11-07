# Ansible Boilerplate Collection Playbooks

The Ansible Boilerplate Collection provides some playbooks which can be used by
dependent projects. Those playbooks are stored in the `playbooks/` directory
and can be run with the `ap` wrapper script (see `docs/scripts.md`).

All playbooks run on all hosts of the inventory by default. Use the `-l`
(`--limit`) option of `ansible-playbook`, or set the `target` variable to a host
pattern, to select other hosts. For example:

```shell
./bin/ap ping -l example.host.name
./bin/ap ping -e target=webservers
```

## "ping" Play

Run the Ansible "ping" module on the target hosts to verify that they are
reachable and usable by Ansible. No facts are gathered.

## "get_facts" Play

Gather the Ansible "facts" and the "package facts" (the list of installed
packages) of the target hosts. Package facts are only gathered when the package
manager of a host is supported by the `package_facts` module. Together with the
fact cache configured in `ansible.cfg`, this can be used to refresh the cached
facts. All tasks are tagged `facts`, gathering package facts is tagged
`packages` as well.
