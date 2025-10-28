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
