#!/bin/bash

cd ~/dotfiles

echo "Current status:"
git status

echo ""
read -p "Commit message: " message

if [ -n "$message" ]; then
    git add -A
    git commit -m "$message"
    git push
    echo "Changes pushed!"
else
    echo "No commit message provided, aborting."
fi
