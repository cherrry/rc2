# rc2

Better organized personal configuration files.

## Installation

```sh
./install.sh
```

### Additional Setup

#### Vim

1. Run `:PluginInstall` to pull all vim plugins.

2. Build `YouCompleteMe` with desired options:

   ```sh
   cd "${HOME}/.vim/bundle/YouCompleteMe
   python3 ./install.py --clangd-completer --clang-completer --ts-completer
   ```

### More on Linux

#### Fonts

```sh
sudo ln -s "${PWD}/linux/fontconfig/*" "/etc/fonts/conf.d"
```

#### X11

```sh
sudo rm -f "/etc/X11/xorg.conf"
sudo ln -s "${PWD}/linux/X11/xorg.conf" "/etc/X11/xorg.conf"
```

### More on Mac

#### iTerm2

1. Open Preferences.
2. Set preferences custom foloder: `${PWD}/mac/iterm2`.
