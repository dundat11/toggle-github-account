#!/bin/bash

# Detect the OS
OS="$(uname)"
if [[ "$OS" == "Linux" || "$OS" == "Darwin" ]]; then
    # Unix-based OS (Linux or macOS)
    PERSONAL_KEY="$HOME/.ssh/id_rsa_personal"
    WORK_KEY="$HOME/.ssh/id_rsa_work"
elif [[ "$OS" == *"NT"* || "$OS" == *"MINGW"* || "$OS" == *"CYGWIN"* ]]; then
    # Windows (Git Bash, Cygwin, or MSYS)
    PERSONAL_KEY="$HOMEPATH/.ssh/id_rsa_personal"
    WORK_KEY="$HOMEPATH/.ssh/id_rsa_work"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

switch_account() {
    if [ "$1" == "personal" ]; then
        ssh-add -D
        ssh-add ~/.ssh/id_rsa_personal
        echo "Switched to personal GitHub account."
        
        #! Add personal account details here
        git config --global user.name ""
        git config --global user.email ""
        echo "Updated global Git config to personal account."

    elif [ "$1" == "work" ]; then
        ssh-add -D 
        ssh-add ~/.ssh/id_rsa_work
        echo "Switched to work GitHub account."
        
        #! Add work account details here
        git config --global user.name ""
        git config --global user.email ""
        echo "Updated global Git config to work account."

    else
        echo "Usage: $0 [personal|work]"
        return
    fi

    CURRENT_KEYS=$(ssh-add -l 2>/dev/null)
    echo "Debug: ssh-add -l output:"
    echo "$CURRENT_KEYS"

    if echo "$CURRENT_KEYS" | grep -q "id_rsa_personal"; then
        echo "Currently using personal GitHub account SSH key."
    elif echo "$CURRENT_KEYS" | grep -q "id_rsa_work"; then
        echo "Currently using work GitHub account SSH key."
    else
        #! Currently this is always displaying, even when a key is in use
        echo "No recognized SSH key is currently in use."
    fi
}

switch_account $1
