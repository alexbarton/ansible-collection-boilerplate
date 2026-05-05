# Ansible Boilerplate Collection and Ansible vault

This Boilerplate Collection is meant to cope well with Ansible vault.

Just use the regular `ansible.cfg` file to configure all required Ansible Vault
related settings, for example like this:

```ini
[default]
vault_password_file = .ansible-vault-secret
```

Note that password files should _not_ be added to the source code repository!
Therefore the auto-generated `.gitignore` file includes this pattern:
`.ansible-vault*`.
