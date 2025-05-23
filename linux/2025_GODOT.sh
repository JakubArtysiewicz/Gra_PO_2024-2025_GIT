#!/bin/sh
echo -ne '\033c\033]0;Gra_PO_2024-2025_GODOT\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/2025_GODOT.x86_64" "$@"
