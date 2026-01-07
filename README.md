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
# Install stow (if not already installed)
sudo dnf install stow

# Clone the repository
cd ~
git clone git@github.com:yourusername/dotfiles.git

# Run the install script
cd ~/Dotfiles
./install.sh
```

**Note:** The install script will:
1. Show you which packages will be installed
2. Ask for confirmation before proceeding
3. Automatically remove any conflicting configuration files
4. Create symlinks for all packages in the repository

This is intended for fresh installations. If you want more control, see the manual installation method below.

#### Manual Installation (More Control)

If you want to stow packages individually or preserve existing configs:
```bash
cd ~/Dotfiles

# Stow specific packages
stow bash
stow tmux
stow nvim
stow alacritty
```

If you have existing configs you want to keep, back them up first:
```bash
# Backup existing configs
mkdir -p ~/config-backup
cp ~/.bashrc ~/config-backup/
cp ~/.tmux.conf ~/config-backup/
cp -r ~/.config/nvim ~/config-backup/
cp -r ~/.config/alacritty ~/config-backup/
```

#### WSL (Fedora)
```bash
# Install stow
sudo dnf install stow

# Clone the repository
cd ~
git clone git@github.com:yourusername/dotfiles.git
cd ~/Dotfiles

# For WSL, you may want to manually stow packages to handle alacritty separately
stow bash
stow tmux
stow nvim
# Handle alacritty separately (see options below)
```

**Handling Alacritty on WSL:**

Since Alacritty runs on the Windows side, you have several options:

**Option A: Symlink to Windows filesystem (Recommended)**
```bash
# First, create symlink to Windows config location
mkdir -p ~/.config
ln -s /mnt/c/Users/YourWindowsUsername/AppData/Roaming/alacritty ~/.config/alacritty

# Now you can stow alacritty
cd ~/Dotfiles
stow alacritty
```

This way, editing the config from WSL will update the Windows Alacritty configuration.

**Option B: Manual sync**

Keep the Alacritty config in the repo but manually copy it to Windows when needed:
```bash
cp ~/Dotfiles/alacritty/.config/alacritty/alacritty.toml \
   /mnt/c/Users/YourWindowsUsername/AppData/Roaming/alacritty/
```

**Option C: Don't sync Alacritty on WSL**

Simply don't stow the alacritty package on WSL and manage the Windows Alacritty config separately.

## Daily Usage

### Making Changes

Edit your config files normally. Since they're symlinked to the repository, changes are automatically tracked:
```bash
# Edit any config file
nvim ~/.bashrc
nvim ~/.config/nvim/init.lua
nvim ~/.tmux.conf

# Commit and push changes
cd ~/Dotfiles
./update.sh
```

The `update.sh` script will show you the current status and prompt for a commit message.

Or do it manually:
```bash
cd ~/Dotfiles
git status
git add -A
git commit -m "Your commit message"
git push
```

### Pulling Changes from Another System
```bash
cd ~/Dotfiles
git pull
```

Since your configs are symlinked, the changes take effect immediately. You may need to:
- Restart your terminal (for `.bashrc` changes)
- Source the file: `source ~/.bashrc`
- Restart the application (for app-specific configs)

### Adding New Configuration Files
```bash
cd ~/Dotfiles

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
cd ~/Dotfiles
stow -D packagename  # Removes the symlinks
```

This won't delete the files from the repository, just removes the symlinks from your home directory.

### Restowing (Update Symlinks)

If you've added new files to a package:
```bash
cd ~/Dotfiles
stow -R packagename  # Restow to create new symlinks
```

## Repository Structure
```
Dotfiles/
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
├── install.sh      # Automated installation script (removes existing configs)
├── update.sh       # Helper script for committing changes
└── README.md
```

Each top-level directory is a "package" that can be independently stowed. The structure inside each package mirrors your home directory.

## Troubleshooting

### Install script won't run

Make sure the script is executable:
```bash
chmod +x ~/Dotfiles/install.sh
```

### Stow complains about existing files (manual installation)

If you're manually stowing and encounter existing files that aren't symlinks:
```bash
# Option 1: Backup and remove
mv ~/.bashrc ~/.bashrc.backup
stow bash

# Option 2: Use --adopt to move existing file into repo
stow --adopt bash
# Then check what changed: git diff
```

### Symlinks not working

Verify the symlink:
```bash
ls -la ~/.bashrc
# Should show: .bashrc -> Dotfiles/bash/.bashrc
```

### Changes not appearing after git pull

Make sure the files are actually symlinked:
```bash
# Check if it's a symlink
file ~/.bashrc

# If not, restow
cd ~/Dotfiles
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

- **Read the warnings**: The install script shows you what will be removed—read it carefully
- **Test after stowing**: Always verify your configs still work after stowing
- **Commit often**: Small, frequent commits are easier to manage than large ones
- **Use descriptive commit messages**: Future you will thank present you
- **Manual installation for production systems**: Consider manually stowing packages on important systems where you want more control

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
