#!/bin/bash

# Install stow if not present
if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    sudo dnf install -y stow
fi

cd ~/Dotfiles

echo "WARNING: This will remove existing configuration files and replace them with symlinks."
echo "The following packages will be installed:"
echo ""

# Show what will be stowed
for dir in */; do
    [[ -d "$dir" ]] || continue
    package=$(basename "$dir")
    echo "  - $package"
done

echo ""
read -p "Do you want to continue? (yes/no): " confirmation

if [[ "$confirmation" != "yes" ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Removing conflicting files..."

# Remove existing files based on what's in each package
for dir in */; do
    [[ -d "$dir" ]] || continue
    package=$(basename "$dir")
    
    # Find all files in this package and remove corresponding files in home
    find "$dir" -type f | while read -r file; do
        # Get relative path from package directory
        rel_path="${file#$dir}"
        target="$HOME/$rel_path"
        
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "  Removing $target"
            rm -f "$target"
        fi
    done
    
    # Remove empty directories that might have been left behind
    find "$dir" -type d | while read -r dir_path; do
        rel_path="${dir_path#$dir}"
        target="$HOME/$rel_path"
        
        if [[ -d "$target" && ! -L "$target" && -z "$(ls -A "$target" 2>/dev/null)" ]]; then
            rmdir "$target" 2>/dev/null
        fi
    done
done

# Stow all packages
echo ""
echo "Creating symlinks..."
for dir in */; do
    [[ -d "$dir" ]] || continue
    package=$(basename "$dir")
    echo "  Stowing $package..."
    stow "$package"
done

echo ""
echo "Dotfiles installed!"
