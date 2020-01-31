#!/usr/bin/env bash

RC_BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${RC_BASE}"

# Necessary submodules
git submodule update --init --recursive
git submodule update --remote --recursive

# Linux specific
if [ `uname` == 'Linux' ]; then
  LINUX_BASE="${RC_BASE}/linux"
  SYMLINK_CONFIGS=(
    "xfce4/terminal/terminalrc"
    "gtk-3.0/gtk.css"
  )
  for file in "${SYMLINK_CONFIGS[@]}"; do
    source="${LINUX_BASE}/${file}"
    target="${HOME}/.config/${file}"
    echo "Symlink ${target} -> ${source}"
    mkdir -p "$(dirname ${target})"
    rm -rf "${target}"
    ln -s "${source}" "${target}"
  done
fi
