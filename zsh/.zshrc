# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH

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
alias zshconf="vi ~/.zshrc"
alias zshref="source ~/.zshrc"
alias antidote="~/.antidote/antidote"
alias regenanti="antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh"
alias ls='ls -l'
alias ll='ls -la'
alias g="git"
alias cls="clear"
alias lg="lazygit"
alias em='emacsclient -c -a "emacs"'

eval "$(zoxide init zsh --cmd cd)"

# Start Syncthing on Android
if [[ "$(uname -o)" == "Android" ]]; then
	echo "Termux environment detected."

	alias doom="$HOME/.config/emacs/bin/doom"
	sv-enable emacsd

	# Check if the Syncthing process is already running
	if ! pgrep -x syncthing > /dev/null 2>&1; then
		echo "Syncthing is not running. Starting it now..."
		# Start Syncthing in the background and silence its output
		syncthing --no-browser > /dev/null 2>&1 &
		echo "Syncthing started in the background."
	else
		echo "Syncthing is already running. No action needed."
	fi
fi

# Antidote
source ~/.zsh_plugins.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/powerlevel10k/.p10k.zsh.
[[ ! -f ~/.dotfiles/powerlevel10k/.p10k.zsh ]] || source ~/.dotfiles/powerlevel10k/.p10k.zsh
