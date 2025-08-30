#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Initial Setup and Package Management ---

echo "--- Updating Termux repositories and packages... ---"
termux-change-repo
pkg update -y && pkg upgrade -y

echo "--- Installing essential and recommended packages... ---"
# 'git' and 'emacs' are required for Doom Emacs.
# 'ripgrep' and 'fd' are highly recommended for better performance.
pkg install -y git emacs ripgrep fd

# --- Cloning Repositories ---

echo "--- Cloning Doom Emacs repository... ---"
if [ -d "$HOME/.config/emacs" ]; then
    echo "Doom Emacs directory already exists. Skipping clone."
else
    mkdir -p "$HOME/.config"
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
fi

echo "--- Cloning user dotfiles repository... ---"
if [ -d "$HOME/.dotfiles" ]; then
    echo "Dotfiles directory already exists. Skipping clone."
else
    git clone https://github.com/ashwinjadhav818/dotfiles.git "$HOME/.dotfiles"
fi

# --- Configuring Doom Emacs ---

echo "--- Creating symbolic link for Doom configuration... ---"
if [ -L "$HOME/.config/doom" ]; then
    echo "Symlink for Doom config already exists. Skipping."
else
    ln -s "$HOME/.dotfiles/.config/doom" "$HOME/.config/doom"
fi

# --- Installing and Syncing Doom Emacs ---

echo "--- Installing Doom Emacs modules and dependencies... ---"
if [ -x "$HOME/.config/emacs/bin/doom" ]; then
    "$HOME/.config/emacs/bin/doom" install
else
    echo "Error: Doom executable not found. Installation may have failed."
    exit 1
fi

echo "--- Syncing Doom Emacs configuration... ---"
echo "This step installs packages and regenerates autoloads."
"$HOME/.config/emacs/bin/doom" sync

echo "--- Doom Emacs installation complete! ---"
echo "You can now run 'emacs' to start the application."

# --- Final Health Check ---

echo "--- IMPORTANT: Run the Doom Doctor check. ---"
echo "To ensure everything is working correctly and find any missing dependencies, please run:"
echo ""
echo "$HOME/.config/emacs/bin/doom doctor"
echo ""
