# .bashrc

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

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

#######################################################################################
## Data Science Configs                                                              ##
#######################################################################################
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

# Dotfiles management
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
