# .bashrc

# =============================================================================
# GENERAL CONFIGS
# =============================================================================

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Sources additional bash configuration files from a ~/.bashrc.d/ directory if it exists
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# -----------------------------------------------------------------------------
# QoL Aliases
# -----------------------------------------------------------------------------

# Frequent directory navigation
alias cdd='cd ~/Dotfiles'
alias cdh='cd ~'
alias cdp='cd ~/Projects'
alias cdn='cd ~/Notes'

# WSL: Navigate to Windows user directory
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
  alias cdw="cd /mnt/c/Users/$WIN_USER"
else
  alias cdw='echo "cdw only works on WSL"'
fi

# =============================================================================
# DATA SCIENCE-SPECIFIC CONFIGS
# =============================================================================

# Quick activation for common python environments
alias ds="source ~/Projects/venvs/ds/bin/activate"

# Function to create a new project with its own venv
newproject() {
  if [ -z "$1" ]; then
    echo "Usage: newproject <Project-Name>"
    return 1
  fi
  mkdir -p ~/Projects/"$1"
  python3 -m venv ~/Projects/venvs/"$1"
  source ~/Projects/venvs/"$1"/bin/activate
  pip install --upgrade pip setuptools wheel
  cd ~/Projects/"$1"
  echo "Created project '$1' with virtual environment"
}

# Function to activate a project's environment and cd to it
workon() {
  if [ -z "$1" ]; then
    echo "Available environments:"
    ls ~/Projects/venvs/
    return 0
  fi
  if [ -d ~/Projects/venvs/"$1" ]; then
    source ~/Projects/venvs/"$1"/bin/activate
    [ -d ~/Projects/"$1" ] && cd ~/Projects/"$1"
  else
    echo "Environment '$1' not found"
  fi
}
