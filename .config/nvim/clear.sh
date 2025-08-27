#!/bin/bash

echo "?? Cleaning Neovim data directories..."

# Backup config just in case
if [ -d ~/.config/nvim ]; then
    echo "?? Config found at ~/.config/nvim (keeping it safe)"
else
    echo "??  No config found at ~/.config/nvim"
    exit 1
fi

# Stop any running nvim instances
echo "?? Stopping Neovim processes..."
pkill nvim 2>/dev/null || true

# Remove data directories
echo "???  Removing data directories..."
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Remove lock files
echo "?? Removing lock files..."
rm -f ~/.config/nvim/lazy-lock.json
rm -f ~/.config/nvim/.luarc.json

echo "? Neovim reset complete!"
echo "?? Run 'nvim' to start fresh (plugins will reinstall automatically)"
