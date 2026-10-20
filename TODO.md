# TODO

## bootstrap.sh for fresh machines

Merge the leftover chezmoi `run_*` scripts into one idempotent `bootstrap.sh`.
The `run_*` scripts and `tmp/` stay in the repo as reference until this is done;
nothing runs them anymore.

1. Install if missing (same logic as the current `run_*` scripts):
   homebrew, nix, rustup, zsh, then cargo tools (eza, bat, delta, ouch).
2. Clone if missing:
   - oh-my-zsh
   - zsh-autosuggestions, fast-syntax-highlighting, fzf-tab into
     `~/.oh-my-zsh/custom/plugins` (on the current WSL machine the first two
     live in `~/.oh-my-zsh/plugins`; works, just not the standard place)
   - tpm into `~/.config/tmux/plugins/tpm`
   - nix-direnv into `~/.local/share/nix-direnv`
3. Don't append to `direnvrc` like `run_once_install-nix-direnv.sh` does:
   `home/.config/direnv/direnvrc` is tracked and already sources nix-direnv.
4. Copy `~/.gitconfig.local.example` to `~/.gitconfig.local` if missing and
   remind to fill in name/email.
5. Run `install.sh`.
6. Delete the `run_*` scripts.

Open question: `tmp/` holds build-from-source installs for ddgr and entr.
Fold them into bootstrap or drop them?
