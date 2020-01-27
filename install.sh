#!/usr/bin/env bash

RC_BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${RC_BASE}"

# Necessary submodules
git submodule update --init --recursive
git submodule update --remote --recursive

# Linux specific
if [ `uname` == 'Linux' ]; then
  LINUX_BASE="${RC_BASE}/linux"
  # xfce4
  mkdir -p "${HOME}/.config/xfce4/terminal"
  rm -f "${HOME}/.config/xfce4/terminal/terminalrc"
  ln -s "${LINUX_BASE}/xfce4/terminal/terminalrc" "${HOME}/.config/xfce4/terminal/terminalrc"
  # gtk-3.0
  mkdir -p "${HOME}/.config/gtk-3.0"
  rm -f "${HOME}/.config/gtk-3.0/gtk.css"
  ln -s "${LINUX_BASE}/gtk-3.0/gtk.css" "${HOME}/.config/gtk-3.0/gtk.css"
fi
