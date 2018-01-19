### how to list project files in git from any sub-directory

For example, you could use this to grep for a certain file / command / directory etc..

- show tree of files from top level dir:

```sh
git config --global alias.ls-files-root "! git ls-files"
git ls-files-root --cached --others --exclude-standard
```

or

- w.r.t. CWD:

```sh
git ls-files $(git rev-parse --show-toplevel)
```

Another way to set an alias is to add an `[alias]` section to `~/.gitconfig`:

```ini
[user]
        name = Archit Sharma
        email = archit@
[gitreview]
        username = arcolife
[push]
        default = simple
[credential]
        helper = cache --timeout=3600
[http]
        sslCAPath = /etc/pki/tls/certs

[alias]
        ls-files-root = ! git ls-files
```

#### Credit

http://gitbaby.com/list-files-with-git-ls-files-from-root-instead-of-current-working-directory.html
