#!/usr/bin/env bash

RC_BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${RC_BASE}"

gitmodule() {
  local repo="$1"
  local dest="$2"
  echo "Git Module ${dest} -> ${repo}"
  mkdir -p "$(dirname ${dest})"
  rm -rf "${dest}"
  git clone --recursive "${repo}" "${dest}"
}

symlink() {
  local src="$1"
  local dest="$2"
  echo "Symlink ${dest} -> ${src}"
  mkdir -p "$(dirname ${dest})"
  rm -rf "${dest}"
  ln -s "${src}" "${dest}"
}

SHARED_BASE="${RC_BASE}/shared"

# Shared: Zsh
gitmodule "https://github.com/chriskempson/base16-shell.git" "${HOME}/.config/base16-shell"
gitmodule "https://github.com/sorin-ionescu/prezto.git" "${HOME}/.zprezto"
symlink "${SHARED_BASE}/zsh/zshrc" "${HOME}/.zshrc"
symlink "${SHARED_BASE}/zsh/zpreztorc" "${HOME}/.zpreztorc"
symlink "${SHARED_BASE}/zsh/zcustom" "${HOME}/.zcustom"

# Shared: Vim
gitmodule "https://github.com/VundleVim/Vundle.vim.git" "${HOME}/.vim/bundle/Vundle.vim"
symlink "${SHARED_BASE}/vim/vimrc" "${HOME}/.vimrc"

# Linux specific
if [ `uname` == 'Linux' ]; then
  LINUX_BASE="${RC_BASE}/linux"

  symlink "${LINUX_BASE}/X11/xsessionrc" "${HOME}/.xsessionrc"
  symlink "${LINUX_BASE}/X11/Xresources" "${HOME}/.Xresources"

  symlink "${LINUX_BASE}/redshift/redshift.conf" "${HOME}/.config/redshift.conf"

  SYMLINK_CONFIGS=(
    "i3/config"
    "i3/i3status"
    "xfce4/terminal/terminalrc"
    "gtk-3.0/gtk.css"
  )
  for file in "${SYMLINK_CONFIGS[@]}"; do
    source="${LINUX_BASE}/${file}"
    target="${HOME}/.config/${file}"
    symlink "${LINUX_BASE}/${file}" "${HOME}/.config/${file}"
  done
fi
