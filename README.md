# Run GNU Stow

```sh
stow -v2 --no-folding -t $HOME .
```

* `-v2`: output verbosity. Use `-v5` to log ignore lists and more details
* `-t`: sets the target folder
* `--no-folding`: prevents symlinks of folders
* (optional) `-n`: runs in SIMULATION mode

Delete symlinks:
```sh
stow -n -D -v2 -t $HOME .
```

Redirect output (stow logs in stderr):
```sh
v <(stow -n -D -v2 -t $HOME . 2>&1)

stow -n -D -v2 -t $HOME . 2> out.txt
```
