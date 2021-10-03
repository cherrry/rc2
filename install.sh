#!/usr/bin/env bash

RC_BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${RC_BASE}"

download() {
  local url="$1"
  local dest="$2"
  echo "Download File ${dest} -> ${url}"
  mkdir -p "$(dirname ${dest})"
  rm -rf "${dest}"
  curl --fail --location --output "${dest}" "${url}"
}

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
gitmodule "https://github.com/fnune/base16-shell.git" "${HOME}/.config/base16-shell"
gitmodule "https://github.com/sorin-ionescu/prezto.git" "${HOME}/.zprezto"
symlink "${SHARED_BASE}/zsh/zshrc" "${HOME}/.zshrc"
symlink "${SHARED_BASE}/zsh/zpreztorc" "${HOME}/.zpreztorc"
symlink "${SHARED_BASE}/zsh/zcustom" "${HOME}/.zcustom"

# Shared: Tmux
gitmodule "https://github.com/tmux-plugins/tpm.git" "${HOME}/.tmux/plugins/tpm"
symlink "${SHARED_BASE}/tmux/tmux.conf" "${HOME}/.tmux.conf"

# Shared: Fzf
gitmodule "https://github.com/junegunn/fzf.git" "${HOME}/.fzf"
yes | "${HOME}/.fzf/install"
gitmodule "https://github.com/Aloxaf/fzf-tab.git" "${HOME}/.zcontrib/fzf-tab"

# Shared: Vim
download \
  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
  "${HOME}/.vim/autoload/plug.vim"
symlink "${SHARED_BASE}/vim/vimrc" "${HOME}/.vimrc"
symlink "${SHARED_BASE}/vim/coc-settings.json" "${HOME}/.vim/coc-settings.json"

# Shared: Git
symlink "${SHARED_BASE}/git/gitconfig" "${HOME}/.gitconfig"
symlink "${SHARED_BASE}/git/gitignore" "${HOME}/.gitignore"

# Linux specific
if [ `uname` == 'Linux' ]; then
  LINUX_BASE="${RC_BASE}/linux"

  symlink "${LINUX_BASE}/X11/xsessionrc" "${HOME}/.xsessionrc"
  symlink "${LINUX_BASE}/X11/Xresources" "${HOME}/.Xresources"

  symlink "${LINUX_BASE}/compton/compton.conf" "${HOME}/.config/compton.conf"
  symlink "${LINUX_BASE}/redshift/redshift.conf" "${HOME}/.config/redshift.conf"

  SYMLINK_CONFIGS=(
    "dunst/dunstrc"
    "i3/config"
    "i3/i3status"
    "kitty/kitty.conf"
  )
  for file in "${SYMLINK_CONFIGS[@]}"; do
    symlink "${LINUX_BASE}/${file}" "${HOME}/.config/${file}"
  done
fi

# Mac Specific
if [ `uname` == 'Darwin' ]; then
  MAC_BASE="${RC_BASE}/mac"

  tic -o "${HOME}/.terminfo" "${MAC_BASE}/terminfo/xterm-256color.terminfo"
fi

# Corp Specific
if [ -x "$(command -v gcert)" ]; then
  CORP_BASE="${RC_BASE}/corp"

  symlink "${CORP_BASE}/git/gitconfig" "${HOME}/.gitconfig"

  symlink "${CORP_BASE}/bin/newday" "${HOME}/bin/newday"
  symlink "${CORP_BASE}/systemd/ssh-agent.service" "${HOME}/.config/systemd/user/ssh-agent.service"
fi

