#!/usr/bin/env bash

# Ensure cargo is in the path for this script execution
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

echo "Checking cargo tools..."

install_if_missing() {
    if ! command -v $1 &> /dev/null; then
        echo "Installing $1..."
        cargo install $2
    else
        echo "✅ $1 is already installed."
    fi
}

install_if_missing eza eza
install_if_missing bat "--locked bat"
install_if_missing delta git-delta
install_if_missing ouch ouch
