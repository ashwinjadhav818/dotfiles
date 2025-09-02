export PATH=$HOME/bin:/usr/local/bin:$PATH

# Oh My Zsh
export ZSH="/home/ashwin/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zoxide zsh-interactive-cd themes)
source $ZSH/oh-my-zsh.sh

# Terminal
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="nvim"
else
  export EDITOR="nvim"
fi
 
# Alias
alias vi="nvim"
alias vim="nvim"
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="source ~/.zshrc"
alias l="eza --long --header --git --icons -a"
alias ll="eza --long --header --git --icons -a"
alias ls="eza --icons"
alias g="git"
alias cls="clear"
alias lg="lazygit"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

