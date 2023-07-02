# New upstream version

:fire: **Warning**: Ensure you don't loose local modifications while doing `git reset --hard` below.

```shell
# Add upstream Git repository
git remote add upstream https://github.com/pear/pear-core.git
git fetch upstream

# Sync Debian branches
gbp pull --track-missing

# Import new upstream version
upstream_version=1.10.9
git checkout upstream/stable
git reset --hard origin/upstream/stable
git merge --ff-only "v$upstream_version"

#Update submodules
git checkout upstream/stable+submodules
git reset --hard origin/upstream/stable+submodules
git merge upstream/stable
git submodule update --remote
git commit -am'Update submodules to latest version'

# Remove targzs
git checkout upstream/stable+submodules+notgz
git reset --hard origin/upstream/stable+submodules+notgz
git merge upstream/stable+submodules
git tag "upstream/$upstream_version+submodules+notgz"

# Update debian/sid
git checkout debian/sid
git reset --hard debian/sid
git merge upstream/stable+submodules

# Update changelog

dch --newversion "1:$upstream_version+submodules+notgz-1"
# git commit -v debian/changelog
# ...

# Update substvars
./debian/rules debian/php-pear.substvars-static
git commit -am'Update debian/php-pear.substvars-static'

# Once you are happy with the changes, push to Salsa
git push origin upstream/stable:upstream/stable upstream/stable+submodules:upstream/stable+submodules upstream/stable+submodules+notgz:upstream/stable+submodules+notgz
gbp push
```
