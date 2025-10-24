export PATH=$HOME/bin:/usr/local/bin:$PATH

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="half-life"
plugins=(git zsh-autosuggestions themes)
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
alias g="git"
alias cls="clear"
alias lg="lazygit"

eval "$(zoxide init zsh --cmd cd)"

