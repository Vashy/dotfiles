#!/usr/bin/env bash
# Symlink everything under home/ into $HOME.
# Directories in DIR_LINKS are linked as a whole; every other file is linked on its own.
# Anything already at a target path is moved to ~/.dotfiles-backup/<timestamp>/ first.
#
# Usage: ./install.sh [-n|--dry-run]
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
SRC="$REPO/home"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Linked as whole directories, so new files created there land in the repo
DIR_LINKS=(
    .config/nvim
)

DRY_RUN=0
case "${1:-}" in
    -n|--dry-run) DRY_RUN=1; echo "(dry run, nothing is changed)" ;;
    "") ;;
    *) echo "usage: $0 [-n|--dry-run]" >&2; exit 2 ;;
esac

changed=0
backed_up=0

run() {
    (( DRY_RUN )) || "$@"
}

# Print a path with $HOME shortened to ~
tilde() {
    case "$1" in
        "$HOME"/*) printf '~%s\n' "${1#"$HOME"}" ;;
        *) printf '%s\n' "$1" ;;
    esac
}

link() {
    local rel="$1" src="$SRC/$1" dst="$HOME/$1"
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        return
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "backup  ~/$rel -> $(tilde "$BACKUP/$rel")"
        run mkdir -p "$(dirname "$BACKUP/$rel")"
        run mv "$dst" "$BACKUP/$rel"
        backed_up=1
    fi
    echo "link    ~/$rel -> $(tilde "$src")"
    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
    changed=1
}

in_dir_link() {
    local d
    for d in "${DIR_LINKS[@]}"; do
        [[ "$1" == "$d"/* ]] && return 0
    done
    return 1
}

for d in "${DIR_LINKS[@]}"; do
    link "$d"
done

# Tracked plus untracked-but-not-ignored files, so a new file links before `git add`
while IFS= read -r -d '' rel; do
    rel="${rel#home/}"
    in_dir_link "$rel" && continue
    [[ -e "$SRC/$rel" ]] || continue
    link "$rel"
done < <(git -C "$REPO" ls-files -z --cached --others --exclude-standard -- home)

(( changed )) || echo "Everything already linked."
(( backed_up && ! DRY_RUN )) && echo "Backups in $BACKUP"
exit 0
