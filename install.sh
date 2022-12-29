#!/usr/bin/env bash

RC_BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${RC_BASE}"

download() {
  local url="$1"
  local dest="$2"
  echo "Download File ${dest} -> ${url}"
  return  # comment to download
  mkdir -p "$(dirname "${dest}")"
  rm -rf "${dest}"
  curl --fail --location --output "${dest}" "${url}"
}

gitmodule() {
  local repo="$1"
  local dest="$2"
  echo "Git Module ${dest} -> ${repo}"
  return  # comment to clone
  mkdir -p "$(dirname "${dest}")"
  rm -rf "${dest}"
  git clone --recursive "${repo}" "${dest}"
}

symlink() {
  local src="$1"
  local dest="$2"
  echo "Symlink ${dest} -> ${src}"
  mkdir -p "$(dirname "${dest}")"
  rm -rf "${dest}"
  ln -s "${src}" "${dest}"
}

user_service() {
  local service="$1"
  if [ -x "$(command -v systemctl)" ]; then
    echo "User Service ${service}"
    systemctl --user enable "${service}"
    systemctl --user start "${service}"
  fi
}

copy() {
  local src="$1"
  local dest="$2"
  echo "Copy ${dest} -> ${src}"
  mkdir -p "$(dirname "${dest}")"
  rm -rf "${dest}"
  cp "${src}" "${dest}"
}

sudo_copy() {
  local src="$1"
  local dest="$2"
  return  # comment to sudo copy
  echo "SUDO: Copy ${dest} -> ${src}"
  sudo mkdir -p "$(dirname "${dest}")"
  sudo rm -rf "${dest}"
  sudo cp "${src}" "${dest}"
}

SHARED_BASE="${RC_BASE}/shared"

# Shared: Zsh
gitmodule "https://github.com/chriskempson/base16-shell.git" "${HOME}/.config/base16-shell"
gitmodule "https://github.com/sorin-ionescu/prezto.git" "${HOME}/.zprezto"
symlink "${SHARED_BASE}/zsh/zshrc" "${HOME}/.zshrc"
symlink "${SHARED_BASE}/zsh/zpreztorc" "${HOME}/.zpreztorc"
symlink "${SHARED_BASE}/zsh/zcustom" "${HOME}/.zcustom"

# Shared: Tmux
gitmodule "https://github.com/tmux-plugins/tpm.git" "${HOME}/.tmux/plugins/tpm"
symlink "${SHARED_BASE}/tmux/tmux.conf" "${HOME}/.tmux.conf"

# Shared: Fzf
gitmodule "https://github.com/junegunn/fzf.git" "${HOME}/.fzf"
if [ ! -x "$(command -v fzf)" ]; then
  yes | "${HOME}/.fzf/install"
fi
gitmodule "https://github.com/Aloxaf/fzf-tab.git" "${HOME}/.zcontrib/fzf-tab"

# Shared: Vim
download \
  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
  "${HOME}/.vim/autoload/plug.vim"
symlink "${SHARED_BASE}/vim/vimrc" "${HOME}/.vimrc"

# Shared: Git
symlink "${SHARED_BASE}/git/gitconfig" "${HOME}/.gitconfig"
symlink "${SHARED_BASE}/git/gitignore" "${HOME}/.gitignore"
symlink "${SHARED_BASE}/git/hooks" "${HOME}/.git_hooks"

symlink "${SHARED_BASE}/wallpapers" "${HOME}/wallpapers"

# Shared: Fonts
HACK_NERD_PREFIX="https://github.com/ryanoasis/nerd-fonts/raw/v2.2.2/patched-fonts/Hack"
HACK_NERD_TTFS=(
  "Bold/complete/Hack Bold Nerd Font Complete.ttf"
  "BoldItalic/complete/Hack Bold Italic Nerd Font Complete.ttf"
  "Italic/complete/Hack Italic Nerd Font Complete.ttf"
  "Regular/complete/Hack Regular Nerd Font Complete.ttf"
)
CHIRON_HEI_PREFIX="https://github.com/chiron-fonts/chiron-hei-hk/raw/v2.505/TTF"
CHIRON_HEI_TTFS=(
  "ChironHeiHK-R.ttf"
  "ChironHeiHK-R-It.ttf"
  "ChironHeiHK-L.ttf"
  "ChironHeiHK-L-It.ttf"
  "ChironHeiHK-B.ttf"
  "ChironHeiHK-B-It.ttf"
)
CHIRON_SUNG_PREFIX="https://github.com/chiron-fonts/chiron-sung-hk/raw/v1.007/TTF"
CHIRON_SUNG_TTFS=(
  "ChironSungHK-R.ttf"
  "ChironSungHK-R-It.ttf"
  "ChironSungHK-L.ttf"
  "ChironSungHK-L-It.ttf"
  "ChironSungHK-B.ttf"
  "ChironSungHK-B-It.ttf"
)

# Linux specific
if [ `uname` == 'Linux' ]; then
  LINUX_BASE="${RC_BASE}/linux"

  symlink "${LINUX_BASE}/X11/xsessionrc" "${HOME}/.xsessionrc"
  symlink "${LINUX_BASE}/X11/Xresources" "${HOME}/.Xresources"
  sudo_copy "${LINUX_BASE}/X11/60-keyboard-backlight.conf" "/etc/X11/xorg.conf.d/60-keyboard-backlight.conf"

  copy "${LINUX_BASE}/gtk-3.0/settings.ini" "${HOME}/.config/settings.ini"
  symlink "${LINUX_BASE}/compton/compton.conf" "${HOME}/.config/compton.conf"
  symlink "${LINUX_BASE}/redshift/redshift.conf" "${HOME}/.config/redshift.conf"

  SYMLINK_CONFIGS=(
    "autorandr/postswitch"
    "dunst/dunstrc"
    "i3/config"
    "i3/i3status"
    "kitty/kitty.conf"
    "sway/config"
    "systemd/user/ssh-agent.service"
  )
  for file in "${SYMLINK_CONFIGS[@]}"; do
    symlink "${LINUX_BASE}/${file}" "${HOME}/.config/${file}"
  done

  symlink "${LINUX_BASE}/i3/scripts/touchpad.sh" "${HOME}/bin/i3/touchpad.sh"

  symlink "${LINUX_BASE}/bin/nemo" "${HOME}/bin/nemo"
  symlink "${LINUX_BASE}/bin/nocaps" "${HOME}/bin/nocaps"
  symlink "${LINUX_BASE}/bin/reset_monitor" "${HOME}/bin/reset_monitor"
  symlink "${LINUX_BASE}/bin/telegram" "${HOME}/bin/telegram"
  symlink "${LINUX_BASE}/bin/xsecurelock" "${HOME}/bin/xsecurelock"
  symlink "$(which google-chrome-stable)" "${HOME}/bin/chrome"

  FONT_FILES=(
    "joypixels.ttf"
  )
  for file in "${FONT_FILES[@]}"; do
    symlink "${LINUX_BASE}/fonts/${file}" "${HOME}/.local/share/fonts/${file}"
  done
  for file in "${HACK_NERD_TTFS[@]}"; do
    download "${HACK_NERD_PREFIX}/${file// /%20}" "${HOME}/.local/share/fonts/$(basename "${file}")"
  done
  for file in "${CHIRON_HEI_TTFS[@]}"; do
    download "${CHIRON_HEI_PREFIX}/${file}" "${HOME}/.local/share/fonts/${file}"
  done
  for file in "${CHIRON_SUNG_TTFS[@]}"; do
    download "${CHIRON_SUNG_PREFIX}/${file}" "${HOME}/.local/share/fonts/${file}"
  done
  sudo_copy "${LINUX_BASE}/fonts/65-cjk-fallback.conf" "/etc/fonts/conf.d/65-cjk-fallback.conf"
  sudo_copy "${LINUX_BASE}/fonts/75-color-emoji.conf" "/etc/fonts/conf.d/75-color-emoji.conf"
  sudo_copy \
    "${LINUX_BASE}/fonts/78-please-dont-show-me-simplified-chinese.conf" \
    "/etc/fonts/conf.d/78-please-dont-show-me-simplified-chinese.conf"
  sudo_copy \
    "${LINUX_BASE}/fonts/78-ban-noto-cjk-fonts.conf" \
    "/etc/fonts/conf.d/78-ban-noto-cjk-fonts.conf"

  sudo_copy "${LINUX_BASE}/sway/sway_shell/sway_shell" "/usr/local/bin/sway_shell"
  sudo_copy "${LINUX_BASE}/sway/sway_shell/sway_shell.desktop" "/usr/share/wayland-sessions/sway_shell.desktop"

  user_service "ssh-agent"

  if [ ! -x "$(command -v kitty)" ]; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
    symlink "${HOME}/.local/kitty.app/bin/kitty" "${HOME}/bin/kitty"
  fi
fi

# Mac Specific
if [ `uname` == 'Darwin' ]; then
  MAC_BASE="${RC_BASE}/mac"

  tic -o "${HOME}/.terminfo" "${MAC_BASE}/terminfo/xterm-256color.terminfo"

  for file in "${HACK_NERD_TTFS[@]}"; do
    download "${HACK_NERD_PREFIX}/${file// /%20}" "${HOME}/Library/Fonts/$(basename "${file}")"
  done
  for file in "${CHIRON_HEI_TTFS[@]}"; do
    download "${CHIRON_HEI_PREFIX}/${file}" "${HOME}/Library/Fonts/${file}"
  done
  for file in "${CHIRON_SUNG_TTFS[@]}"; do
    download "${CHIRON_SUNG_PREFIX}/${file}" "${HOME}/Library/Fonts/${file}"
  done
fi

# Corp Specific
if [ -x "$(command -v gcert)" ]; then
  CORP_BASE="${RC_BASE}/corp"

  symlink "${CORP_BASE}/bin/automouse" "${HOME}/bin/automouse"
  symlink "${CORP_BASE}/ssh/config" "${HOME}/.ssh/config"

  # Laptop
  if [ ! -x "$(command -v g4)" ]; then
    symlink "${CORP_BASE}/bin/newday" "${HOME}/bin/newday"
  fi

  # Workstation
  if [ -x "$(command -v g4)" ]; then
    symlink "${CORP_BASE}/git/gitconfig" "${HOME}/.gitconfig"

    symlink "${CORP_BASE}/android/android_hook.sh" "${HOME}/.hook/android_hook.sh"
    symlink "${CORP_BASE}/android/envrc" "${HOME}/.hook/android_envrc"

    symlink "${CORP_BASE}/vim/vimrc" "${HOME}/.vimrc"

    symlink "${CORP_BASE}/zsh/zpreztorc" "${HOME}/.zpreztorc"
  fi
fi
