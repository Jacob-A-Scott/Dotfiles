#!/bin/bash

# Install stow if not present
if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    sudo dnf install -y stow
fi

cd ~/dotfiles

# Stow all packages
for dir in */; do
    package=$(basename "$dir")
    echo "Stowing $package..."
    stow "$package"
done

echo "Dotfiles installed!"
