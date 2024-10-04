# Creating a new Ansible Boilerplate Collection Release

## Prerequisites

1. Make sure your source tree is clean.
2. Make sure everything is committed and pushed out.
3. Run `make check`!

## Steps to Create the new Release

1. Set new version number (major.minor.fix):

   ```sh
   major=1; minor=2; fix=3
   galaxy_api_key=…
   ```

2. Update `galaxy.yml`, bump the version number accordingly:

   ```sh
   sed -i'.bak' \
     -e "s/^version: .*$/version: ${major}.${minor}.${fix}/g" galaxy.yml
   rm -fv galaxy.yml.bak
   ```

3. Create the release commit and signed tag:

   ```sh
   git add galaxy.yml
   git diff --cached --patch-with-stat
   git commit --message "Release ${major}.${minor}.${fix}"
   git tag -m "Release ${major}.${minor}.${fix}" -s \
     "rel-${major}-${minor}-${fix}"
   ```

4. Create the distribution archive:

   ```sh
   make distcheck
   ```

   The resulting `.tar.gz` file is in the `./dist/` sub-directory.

5. Push the commit and tag out:

   ```sh
   git push --follow-tags
   ```

6. Publish the new release on the Ansible Galaxy repository:

   ```sh
   .venv/bin/ansible-galaxy collection publish \
     --api-key "${galaxy_api_key}" \
     "dist/alexbarton-boilerplate-${major}.${minor}.${fix}.tar.gz"
   ```

7. Check the result online:
   <https://galaxy.ansible.com/ui/repo/published/alexbarton/boilerplate/>
