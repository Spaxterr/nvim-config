echo "Uninstalling neovim..."
sudo apt remove neovim --purge
echo "Removing local files..."
sudo rm -r ~/.local/share/nvim/
echo "Re-installing neovim..."
sudo apt install neovim -y
echo "NvChad installation cleaned!"
