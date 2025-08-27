#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Updating Termux repositories and packages..."
pkg update -y && pkg upgrade -y

echo "Installing required packages..."
pkg install -y git emacs

echo "Cloning Doom Emacs repository..."
# Check if the Doom Emacs directory already exists to prevent errors.
if [ -d "$HOME/.config/emacs" ]; then
    echo "Doom Emacs directory already exists. Skipping clone."
else
    mkdir -p "$HOME/.config"
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
fi

echo "Cloning dotfiles repository..."
# Check if the dotfiles directory already exists.
if [ -d "$HOME/.dotfiles" ]; then
    echo "Dotfiles directory already exists. Skipping clone."
else
    git clone https://github.com/ashwinjadhav818/dotfiles.git "$HOME/.dotfiles"
fi

echo "Creating symbolic link for Doom configuration..."
# Check if the symlink already exists.
if [ -L "$HOME/.config/doom" ]; then
    echo "Symlink for Doom config already exists. Skipping."
else
    ln -s "$HOME/.dotfiles/.config/doom" "$HOME/.config/doom"
fi

echo "Installing Doom Emacs modules and dependencies..."
# Check if Doom Emacs is installed before running the install command.
if [ -x "$HOME/.config/emacs/bin/doom" ]; then
    "$HOME/.config/emacs/bin/doom" install
else
    echo "Error: Doom executable not found. Installation may have failed."
    exit 1
fi

echo "Doom Emacs installation complete!"
echo "To start Emacs, run: emacs"
