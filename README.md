# Ashwin's dotfiles

![Cover](./assets/cover.png)

<details>
  <summary>More Screenshots</summary>

  #### GlazeWM + Zebar
  ![GlazeWM + Zebar 1](./assets/glazewm+zebar1.png)
  ![GlazeWM + Zebar 2](./assets/glazewm+zebar2.png)

  #### Zen Browser
  ![Zen Browser](./assets/zen-browser.png)
</details>

## Configurations

-  vim (NeoVim & LunarVim)
   -  Plugins are managed with [Lazy](https://github.com/folke/lazy.nvim.git")
-  doom emacs
-  bas
-  fish
-  zsh
-  oh-my-zsh
-  powerlevel10k
-  powershell
-  tmux
-  glaze-wm
-  zebar
-  komorebi
-  yasb
-  kanata
-  tacky-borders
-  alacritty
-  wezterm
-  hyper
-  winfetch
-  zen-browser

### Vim (NeoVim & LunarVim) config

Requires Neovim (>= 0.9)

-  [LunarVim](https://www.lunarvim.org/) - Fast IDE layer for Neovim with awesome plugins already installed.

### Fish config

-  [fish shell](https://fishshell.com/)
-  [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
-  [fisher](https://github.com/jorgebucaran/fisher/) - a plugin manager for Fish
-  [tide](https://github.com/IlanCosman/tide/) - the ultimate fish prompt
-  [nvm](https://github.com/jorgebucaran/nvm.fish/) - node package manager for fish
-  [zoxide](https://github.com/ajeetdsouza/zoxide) - directory jumper

### Zsh config

-  [zsh shell](https://ohmyz.sh/)
-  [nerd font](https://www.nerdfonts.com/) - Powerline-patched fonts.
-  [zoxide](https://github.com/ajeetdsouza/zoxide) - Directory jumping
-  [exa](https://the.exa.website/) - `ls` replacement
-  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like fast/unobtrusive autosuggestions for zsh.
-  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Fish shell-like syntax highlighting for zsh.

### PowerShell config

-  [scoop](https://scoop.sh/) - A command-line installer
-  [git for windows](https://gitforwindows.org/)
-  [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
-  [Terminal Icons](https://github.com/devblackops/Terminal-Icons) - Folder and file icons
-  [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/) - Cmdlets for customizing the editing environment, used for autocompletion
-  [zoxide](https://github.com/ajeetdsouza/zoxide) - directory jumper


## Steps to install

### Linux

1. Clone this repository to your home directory.

```bash
# Using gh
gh repo clone ashwinjadhav818/dotfiles ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/ashwinjadhav818/dotfiles.git ~/.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```bash
stow .
```

### Windows

1. Clone this repository to your home directory.

```pwsh
# Using gh
gh repo clone ashwinjadhav818/dotfiles $HOME\.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/ashwinjadhav818/dotfiles.git $HOME\.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```pwsh
sudo New-Item -Path $HOME\.config\ -ItemType SymbolicLink -Value $HOME\.dotfiles\.config\

sudo New-Item -Path $HOME\.bashrc -ItemType SymbolicLink -Value $HOME\.dotfiles\.bashrc

sudo New-Item -Path $HOME\.glzr -ItemType SymbolicLink -Value $HOME\.dotfiles\.glzr

sudo New-Item -Path $Env:AppData\alacritty\alacritty.toml -ItemType SymbolicLink -Value $HOME\.dotfiles\.config\alacritty\alacritty.toml

sudo New-Item -Path $Env:AppData\zen\<Profile_Name>\chrome\userChrome.cs -ItemType SymbolicLink -Value $HOME\.dotfiles\.config\zen-browser\userChrome.css
```
