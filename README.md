# My Ubuntu dotfiles

## Contents

- vim (NeoVim) config
  - Plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug)
- zsh config
- powerlevel10k config
- yarn config

## Steps to installations it on Ubuntu:

````Note run all these commands in the home directory

1. Clone this repository to your home directory

```zsh
# Using gh
gh repo clone AshAll-Rounder/.dotfiles ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/AshAll-Rounder/.dotfiles.git ~/.dotfiles
````

2. Create symlinks in the Home directory to the real files in the repo.

```zsh
# There are better and less manual ways to do this;
# investigate install scripts and bootstrapping tools.

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

# Create a .config directory and inside it create nvim directory.
mkdir .config .config/nvim
ln -s ~/.dofiles/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
```
