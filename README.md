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
