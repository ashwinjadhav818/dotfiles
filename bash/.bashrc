# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls="clear"
alias bat="batcat"
alias vi=nvim
alias vim=nvim
alias lg=lazygit
alias em='emacsclient -c -a "emacs"'
alias g='git'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# StarShip prompt
eval "$(starship init bash)"

# Zoxide Setup
eval "$(zoxide init bash --cmd cd)"

# Start syncthing on android
if [ "$(uname -o)" == "Android"  ]; then
    echo "Termux environment detected."

    alias doom="~/.config/emacs/bin/doom"
    sv-enable emacsd
    # Check if the Syncthing process is already running
    # `pgrep -x syncthing` looks for an exact process name match
    # If it returns an empty string, the process is not running
    if ! pgrep -x "syncthing" > /dev/null; then
        echo "Syncthing is not running. Starting it now..."
        # Start Syncthing in the background and redirect output to a log file
        syncthing --no-browser > /dev/null 2>&1 &
        echo "Syncthing started in the background."
    else
        echo "Syncthing is already running. No action needed."
    fi
fi

