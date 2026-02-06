#!/usr/bin/env bash

NIX_DIRENV_PATH=$HOME/.local/share/nix-direnv/direnvrc
DIRENV_CONFIG_PATH=$HOME/.config/direnv

if [ ! -f "$NIX_DIRENV_PATH" ]; then
    echo "nix-direnv not found at $NIX_DIRENV_PATH. Installing..."
    git clone https://github.com/nix-community/nix-direnv.git $NIX_DIRENV_PATH
    if [ ! -d "$DIRENV_CONFIG_PATH" ]; then
        mkdir -p "$DIRENV_CONFIG_PATH"
        touch $DIRENV_CONFIG_PATH/direnvrc
    fi
    echo "source $NIX_DIRENV_PATH" >> $DIRENV_CONFIG_PATH/direnvrc
    echo "✅ nix-direnv installed"
else
    echo "nix-direnv is already installed at $NIX_DIRENV_PATH."
fi
