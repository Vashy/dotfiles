#!/bin/sh
# Pane <-> window moves that remember window names.
#
# A pane merged into another window remembers how its window was named:
# @window_name holds a name given by hand, @window_auto marks an automatic
# one (tmux naming the window after the running command). Breaking the pane
# out again restores that naming, so names survive merge/break rounds.
#
#   panes.sh break PANE        keep PANE in place and focused, move every other
#                              pane of its window to its own window right
#                              after it, in pane order
#   panes.sh join -h|-v PANE   merge the last window into PANE's window, which
#                              keeps its name and focus; incoming panes go in a
#                              full-height column (-h) or full-width row (-v)
set -eu

get() { tmux display -p -t "$1" "$2"; }

# remember PANE WINDOW: store on PANE how WINDOW is named
remember() {
  if [ "$(get "$2" '#{automatic-rename}')" = 0 ]; then
    tmux set -p -t "$1" @window_name "$(get "$2" '#{window_name}')"
    tmux set -pu -t "$1" @window_auto
  else
    tmux set -pu -t "$1" @window_name
    tmux set -p -t "$1" @window_auto 1
  fi
}

# claim WINDOW: its panes that remember no naming take WINDOW's; a lone pane
# always does, since its window's name is unambiguously its own (and may have
# been renamed since it was last remembered)
claim() {
  panes=$(tmux list-panes -t "$1" -F '#{pane_id}')
  if [ "$(get "$1" '#{window_panes}')" = 1 ]; then
    remember "$panes" "$1"
    return
  fi
  for p in $panes; do
    if [ -z "$(get "$p" '#{@window_name}#{@window_auto}')" ]; then remember "$p" "$1"; fi
  done
}

case "${1:-}" in
break)
  pane=$2
  win=$(get "$pane" '#{window_id}')
  prev=$win
  for p in $(tmux list-panes -t "$win" -F '#{pane_id}'); do
    [ "$p" = "$pane" ] && continue
    name=$(get "$p" '#{@window_name}')
    # chain each new window after the previous one to keep pane order;
    # without -n tmux names it automatically
    prev=$(tmux break-pane -d -a -P -F '#{window_id}' -s "$p" -t "$prev" ${name:+-n "$name"})
  done
  # the kept pane takes back its own naming too; a pane never merged anywhere
  # (split here) remembers nothing and leaves the name as is
  name=$(get "$pane" '#{@window_name}')
  if [ -n "$name" ]; then
    tmux rename-window -t "$win" "$name"
  elif [ -n "$(get "$pane" '#{@window_auto}')" ]; then
    tmux set -w -t "$win" automatic-rename on
  fi
  ;;
join)
  dir=$2 pane=$3
  win=$(get "$pane" '#{window_id}')
  src=$(tmux list-windows -t "$(get "$pane" '#{session_id}')" -f '#{window_last_flag}' -F '#{window_id}')
  if [ -z "$src" ]; then
    tmux display-message 'no last window to merge'
    exit 0
  fi
  claim "$win"
  claim "$src"
  # -f: each incoming pane spans the whole window, appended at the right
  # (-h) or bottom (-v); -d: focus stays on PANE. A joined pane is numbered
  # right after its target, so chain from the last pane to keep pane order.
  prev=$(tmux list-panes -t "$win" -F '#{pane_id}' | tail -n 1)
  for p in $(tmux list-panes -t "$src" -F '#{pane_id}'); do
    tmux join-pane -d -f "$dir" -s "$p" -t "$prev"
    prev=$p
  done
  ;;
*)
  echo "usage: ${0##*/} break PANE | join -h|-v PANE" >&2
  exit 1
  ;;
esac
