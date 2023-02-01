# Ashwin's dotfiles

![Cover](./assets/cover.png)

## Contents

-  vim (NeoVim & LunarVim) config
   -  Plugins are managed with [Packer](https://github.com/wbthomason/packer.nvim)
-  fish config
-  zsh config
-  powerlevel10k config
-  powershell config
-  tmux config
-  yarn config
-  programming fonts

## Apps/utilites I use

-  [NeoVim](https://neovim.io)
-  [LunarVim](http://lunarvim.org)
-  [fish shell](https://fishshell.com)
-  powershell

## Vim (LunarVim & NvChad) config

Requires Neovim (>= 0.8)

-  [LunarVim](https://www.lunarvim.org/) - Fast IDE layer for Neovim with awesome plugins already installed.
-  [NvChad](https://nvchad.github.io/) - Awesome config for NeoVim.
-  [awesome-vim-colorschemes](https://github.com/rafi/awesome-vim-colorschemes) - Collection of awesome color schemes for Vim, merged for quick use.
-  [vim-visual-multi](https://github.com/mg979/vim-visual-multi) - Minimal plugin for multi-cursors.
-  [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) - Preview markdown on your modern browser with synchronised scrolling and flexible configuration.

## Fish config

-  [fish shell](https://fishshell.com/)
-  [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
-  [fisher](https://github.com/jorgebucaran/fisher/) - a plugin manager for Fish
-  [tide](https://github.com/IlanCosman/tide/) - the ultimate fish prompt
-  [nvm](https://github.com/jorgebucaran/nvm.fish/) - node package manager for fish
-  [z](https://github.com/jethrokuan/z/) - directory jumper

## Zsh config

-  [zsh shell](https://ohmyz.sh/)
-  [nerd font](https://www.nerdfonts.com/) - Powerline-patched fonts. I use Fira Code NF Retina and JetBrainsMono Nerd Font.
-  [z zsh plugin](https://github.com/agkozak/zsh-z) - Directory jumping
-  [exa](https://the.exa.website/) - `ls` replacement
-  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like fast/unobtrusive autosuggestions for zsh.
-  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Fish shell-like syntax highlighting for zsh.

## PowerShell config

-  [scoop](https://scoop.sh/) - A command-line installer
-  [git for windows](https://gitforwindows.org/)
-  [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
-  [Terminal Icons](https://github.com/devblackops/Terminal-Icons) - Folder and file icons
-  [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/) - Cmdlets for customizing the editing environment, used for autocompletion
-  [z](https://www.powershellgallery.com/packages/z) - directory jumper

## Programming fonts

A set of awesome programming fonts I love.

## Dank Mono

![Dank Mono](./Assets/Dank%20Mono.png)

## Victor Mono

![Victor Mono](./Assets/Victor%20Mono.png)

## Operator Mono

![Operator Mono](./Assets/Operator%20Mono.png)

## MonoLisa

![MonoLisa](./Assets/MonoLisa.png)

## Fira Code

![Fira Code](./Assets/Fira%20Code.png)

> The theme used in the screenshots is Synthwave 84 on Visual Studio Code

## Steps to install

### Ubuntu

1. Clone this repository to your home directory.

```bash
# Using gh
gh repo clone ashwinjadhav818/dotfiles ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/ashwinjadhav818/dotfiles.git ~/.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```bash
stow bash fish zsh nvim lvim tmux
```

3. Install LunarVim

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

### Windows

1. Clone this repository to your home directory.

```bash
# Using gh
gh repo clone ashwinjadhav818/dotfiles C:\Users\<UserName>\.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/ashwinjadhav818/dotfiles.git C:\Users\<UserName>\.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```bash
sudo New-Item -Path C:\Users\<UserName>\.config\powershell -ItemType SymbolicLink -Value C:\Users\<UserName>\.dotfiles\.config\powershell\
```
