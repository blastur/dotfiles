#!/usr/bin/env bash
# Move every window from every other workspace onto the focused workspace.
# Scratchpad windows are left alone. Pass --dry-run to only print the command.
set -euo pipefail

target=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

cmd=$(i3-msg -t get_tree | jq -r --arg target "$target" '
  [ .. | objects
    | select(.type == "workspace" and .name != $target and .name != "__i3_scratch")
    | .. | objects | select(.window != null) | .id ]
  | map("[con_id=\(.)] move container to workspace \($target | tojson)")
  | join("; ")')

[ -z "$cmd" ] && exit 0

if [ "${1:-}" = "--dry-run" ]; then
  echo "$cmd"
else
  i3-msg -q "$cmd"
fi
