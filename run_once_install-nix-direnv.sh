#!/usr/bin/env bash

NIX_DIRENV_PATH=$HOME/.local/share/nix-direnv/direnvrc
 
if [ ! -f "$NIX_DIRENV_PATH" ]; then
    echo "nix-direnv not found at $NIX_DIRENV_PATH. Installing..."
    git clone https://github.com/nix-community/nix-direnv.git $NIX_DIRENV_PATH
    echo "✅ nix-direnv installed"
else
    echo "nix-direnv is already installed at $NIX_DIRENV_PATH."
fi
