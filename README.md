# Dotfiles

Personal configuration files managed with GNU Stow.

## Prerequisites

- Git
- GNU Stow
- SSH key configured for GitHub (for cloning)

## Installation

### First Time Setup on a New System

#### Linux (Fedora)
```bash
# Install stow
sudo dnf install stow

# Clone the repository
cd ~
git clone git@github.com:yourusername/dotfiles.git

# Run the install script
cd ~/dotfiles
./install.sh
```

Or manually stow specific packages:
```bash
cd ~/dotfiles
stow bash
stow tmux
stow nvim
stow alacritty
```

#### WSL (Fedora)
```bash
# Install stow
sudo dnf install stow

# Clone the repository
cd ~
git clone git@github.com:yourusername/dotfiles.git

# Stow packages EXCEPT alacritty (see below)
cd ~/dotfiles
stow bash
stow tmux
stow nvim
```

**Handling Alacritty on WSL:**

Since Alacritty runs on the Windows side, you have several options:

**Option A: Symlink to Windows filesystem (Recommended)**
```bash
# Create symlink to Windows config location
mkdir -p ~/.config
ln -s /mnt/c/Users/YourWindowsUsername/AppData/Roaming/alacritty ~/.config/alacritty

# Now you can stow alacritty
cd ~/dotfiles
stow alacritty
```

This way, editing the config from WSL will update the Windows Alacritty configuration.

**Option B: Manual sync**

Keep the Alacritty config in the repo but manually copy it to Windows when needed:
```bash
cp ~/dotfiles/alacritty/.config/alacritty/alacritty.toml \
   /mnt/c/Users/YourWindowsUsername/AppData/Roaming/alacritty/
```

**Option C: Don't sync Alacritty on WSL**

Simply manage the Windows Alacritty config separately and don't stow it on WSL.

## Daily Usage

### Making Changes

Edit your config files normally. Since they're symlinked to the repository, changes are automatically tracked:
```bash
# Edit any config file
nvim ~/.bashrc
nvim ~/.config/nvim/init.lua
nvim ~/.tmux.conf

# Commit and push changes
cd ~/dotfiles
./update.sh
```

The `update.sh` script will show you the current status and prompt for a commit message.

Or do it manually:
```bash
cd ~/dotfiles
git status
git add -A
git commit -m "Your commit message"
git push
```

### Pulling Changes from Another System
```bash
cd ~/dotfiles
git pull
```

Since your configs are symlinked, the changes take effect immediately. You may need to:
- Restart your terminal (for `.bashrc` changes)
- Source the file: `source ~/.bashrc`
- Restart the application (for app-specific configs)

### Adding New Configuration Files
```bash
cd ~/dotfiles

# Create a new package directory
mkdir -p newpackage/.config

# Move your existing config into the package
mv ~/.config/somefile newpackage/.config/somefile

# Stow the new package
stow newpackage

# Commit and push
git add newpackage
git commit -m "Add somefile configuration"
git push
```

### Removing a Stowed Package
```bash
cd ~/dotfiles
stow -D packagename  # Removes the symlinks
```

This won't delete the files from the repository, just removes the symlinks from your home directory.

### Restowing (Update Symlinks)

If you've added new files to a package:
```bash
cd ~/dotfiles
stow -R packagename  # Restow to create new symlinks
```

## Repository Structure
```
dotfiles/
├── bash/
│   └── .bashrc
├── tmux/
│   └── .tmux.conf
├── nvim/
│   └── .config/
│       └── nvim/
│           └── (nvim config files)
├── alacritty/
│   └── .config/
│       └── alacritty/
│           └── alacritty.toml
├── install.sh      # Automated installation script
├── update.sh       # Helper script for committing changes
└── README.md
```

Each top-level directory is a "package" that can be independently stowed. The structure inside each package mirrors your home directory.

## Troubleshooting

### Stow complains about existing files

If stow encounters existing files that aren't symlinks:
```bash
# Backup the existing file
mv ~/.bashrc ~/.bashrc.backup

# Then stow
stow bash
```

### Symlinks not working

Verify the symlink:
```bash
ls -la ~/.bashrc
# Should show: .bashrc -> dotfiles/bash/.bashrc
```

### Changes not appearing after git pull

Make sure the files are actually symlinked:
```bash
# Check if it's a symlink
file ~/.bashrc

# If not, restow
cd ~/dotfiles
stow -R bash
```

### WSL Alacritty config not syncing

Verify the Windows path is correct:
```bash
ls -la /mnt/c/Users/YourWindowsUsername/AppData/Roaming/alacritty/
```

Check your symlink:
```bash
ls -la ~/.config/alacritty
```

## Tips

- **Test after stowing**: Always verify your configs still work after stowing
- **Commit often**: Small, frequent commits are easier to manage than large ones
- **Use descriptive commit messages**: Future you will thank present you
- **Back up before first install**: Consider backing up existing configs before overwriting

## SSH Key Setup (For New Systems)

If you need to set up SSH for GitHub on a new system:
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key
cat ~/.ssh/id_ed25519.pub
```

Then add the public key to GitHub: Settings → SSH and GPG keys → New SSH key

## License

Personal dotfiles. Use at your own risk.
