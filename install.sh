#!/bin/bash

# LITTlinux - Live in the Terminal
# A Bash Script for Alpine Linux

# Author: c0wb0y54mur41
# Website: https://c0wb0y54mur41.dev/

# Update package index then Upgrade installed packages
apk update && apk upgrade

# Uncomment the community repositories
sed -i '/^#.*community/s/^#//' /etc/apk/repositories

# Update the package index
apk update

# Install necessary packages
apk add fish neovim ranger htop neofetch weechat

# Install Oh My Fish
curl -L https://get.oh-my.fish | fish

# Install Starship prompt
curl -fsSL https://starship.rs/install.sh | bash

# Set Fish as default shell for all users
sed -i 's#/bin/ash#/usr/bin/fish#' /etc/passwd

# Set Fish as default shell for future users
echo "/usr/bin/fish" >> /etc/skel/.profile

# Configure Fish and plugins
echo "set -g theme_color_scheme nord" >> ~/.config/fish/config.fish
echo "set -g fish_prompt_pwd_dir_length 0" >> ~/.config/fish/config.fish
fish -c "omf install bobthefish"
fish -c "omf install fzf"
fish -c "omf install z"
fish -c "omf install git"
fish -c "omf install docker"

# Configure Neovim
mkdir -p ~/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
echo "let &packpath=&runtimepath" >> ~/.config/nvim/init.vim
echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ~/.local/share/nvim/site/autoload/plug.vim
nvim -c 'PlugInstall' -c 'qa!'

# Configure Ranger
ranger --copy-config=all
echo "set preview_images true" >> ~/.config/ranger/rc.conf

# Add neofetch to Fish shell startup
echo "neofetch" >> ~/.config/fish/config.fish

# Print message to inform script completed
echo "Installation and configuration complete."
